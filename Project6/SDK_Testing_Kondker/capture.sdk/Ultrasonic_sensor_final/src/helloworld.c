/******************************************************************************
*
* Copyright (C) 2002 - 2019 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
* @file xgpio_intr_tapp_example.c
*
* This file contains a design example using the GPIO driver (XGpio) in an
* interrupt driven mode of operation. This example does assume that there is
* an interrupt controller in the hardware system and the GPIO device is
* connected to the interrupt controller.
*
* This file is used in the Peripheral Tests Application in SDK to include a
* simplified test for gpio interrupts.

* The buttons and LEDs are on 2 separate channels of the GPIO so that interrupts
* are not caused when the LEDs are turned on and off.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date	 Changes
* ----- ---- -------- -------------------------------------------------------
* 2.01a sn   05/09/06 Modified to be used by TestAppGen to include test for
*		      interrupts.
* 3.00a ktn  11/21/09 Updated to use HAL Processor APIs and minor changes
*		      as per coding guidelines.
* 3.00a sdm  02/16/11 Updated to support ARM Generic Interrupt Controller
* 4.1   lks  11/18/15 Updated to use canonical xparameters and
*		      clean up of the comments and code for CR 900381
* 4.3   ms   01/23/17 Modified xil_printf statement in main function to
*                     ensure that "Successfully ran" and "Failed" strings
*                     are available in all examples. This is a fix for
*                     CR-965028.
*
*</pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xil_io.h"



#ifdef XPAR_INTC_0_DEVICE_ID
 #include "xintc.h"
 #include <stdio.h>
#else
 #include "xscugic.h"
 #include "xil_printf.h"
#endif

/************************** Constant Definitions *****************************/
#ifndef TESTAPP_GEN
/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define GPIO_DEVICE_ID		XPAR_GPIO_1_DEVICE_ID
#define LCD_BASE_ADDR XPAR_MY_LCD_IP_0_S00_AXI_BASEADDR
#define GPIO_CHANNEL1		1

#define BTN_Reset_BIT 0x01	//BTN0
#define BTN_SRC_BIT 0x02	//BTN1
#define BTN_EN_BIT 0x04		//BTN2

#ifdef XPAR_INTC_0_DEVICE_ID
 #define INTC_GPIO_INTERRUPT_ID	XPAR_INTC_0_GPIO_0_VEC_ID
 #define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID
#else
 #define INTC_GPIO_INTERRUPT_ID	XPAR_FABRIC_AXI_GPIO_1_IP2INTC_IRPT_INTR
 #define INTC_DEVICE_ID	XPAR_SCUGIC_SINGLE_DEVICE_ID
#endif /* XPAR_INTC_0_DEVICE_ID */


//void write_lcd_line(u32 base_addr, u32 offset, u32 w3, u32 w2, u32 w1, u32 w0) {
//    Xil_Out32(base_addr + offset + 0x0C, w3);
//    Xil_Out32(base_addr + offset + 0x08, w2);
//    Xil_Out32(base_addr + offset + 0x04, w1);
//    Xil_Out32(base_addr + offset + 0x00, w0);
//}
//
//void update_lcd_line1(SystemState state) {
//    if (state == ENABLED) {
//        write_lcd_line(LCD_BASE_ADDR, 0x00, 0x456E6162, 0x6C656420, 0x20202020, 0x20202020); // "Enabled         "
//    } else {
//        write_lcd_line(LCD_BASE_ADDR, 0x00, 0x44697361, 0x626C6564, 0x20202020, 0x20202020); // "Disabled        "
//    }
//}
//
//void update_lcd_line2(AnalogSource src) {
//    if (src == POT) {
//        write_lcd_line(LCD_BASE_ADDR, 0x10, 0x506F7465, 0x6E74696F, 0x6D657465, 0x72202020); // "Potentiometer   "
//    } else {
//        write_lcd_line(LCD_BASE_ADDR, 0x10, 0x4C696768, 0x74205365, 0x6E736F72, 0x20202020); // "Light Sensor    "
//    }
//}

/*
 * The following constants define the positions of the buttons and LEDs each
 * channel of the GPIO
 */
#define GPIO_ALL_LEDS		0xFFFF
#define GPIO_ALL_BUTTONS	0xFFFF

/*
 * The following constants define the GPIO channel that is used for the buttons
 * and the LEDs. They allow the channels to be reversed easily.
 */
#define BUTTON_CHANNEL	 1	/* Channel 1 of the GPIO Device */
#define LED_CHANNEL	 2	/* Channel 2 of the GPIO Device */
#define BUTTON_INTERRUPT XGPIO_IR_CH1_MASK  /* Channel 1 Interrupt Mask */

/*
 * The following constant determines which buttons must be pressed at the same
 * time to cause interrupt processing to stop and start
 */
#define INTERRUPT_CONTROL_VALUE 0x7

/*
 * The following constant is used to wait after an LED is turned on to make
 * sure that it is visible to the human eye.  This constant might need to be
 * tuned for faster or slower processor speeds.
 */
#define LED_DELAY	1000000

#endif /* TESTAPP_GEN */

#define INTR_DELAY	0x00FFFFFF

#ifdef XPAR_INTC_0_DEVICE_ID
 #define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID
 #define INTC		XIntc
 #define INTC_HANDLER	XIntc_InterruptHandler
#else
 #define INTC_DEVICE_ID	XPAR_SCUGIC_SINGLE_DEVICE_ID
 #define INTC		XScuGic
 #define INTC_HANDLER	XScuGic_InterruptHandler
#endif /* XPAR_INTC_0_DEVICE_ID */

typedef enum { DISABLED, ENABLED } SystemState;
typedef enum { POT, LIGHT } AnalogSource;

/************************** Function Prototypes ******************************/
void GpioHandler(void *CallBackRef);

int GpioIntrExample(INTC *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId,
			u16 IntrMask, u32 *DataRead);

int GpioSetupIntrSystem(INTC *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId, u16 IntrMask);

void GpioDisableIntr(INTC *IntcInstancePtr, XGpio *InstancePtr,
			u16 IntrId, u16 IntrMask);

/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */
XGpio Gpio; /* The Instance of the GPIO Driver */

volatile SystemState current_state = DISABLED;
volatile AnalogSource current_source = POT;

INTC Intc; /* The Instance of the Interrupt Controller Driver */


static u16 GlobalIntrMask; /* GPIO channel mask that is needed by
			    * the Interrupt Handler */

static volatile u32 IntrFlag; /* Interrupt Handler Flag */
void write_lcd_line(u32 base_addr, u32 offset, u32 w3, u32 w2, u32 w1, u32 w0) {
    Xil_Out32(base_addr + offset + 0x0C, w3);
    Xil_Out32(base_addr + offset + 0x08, w2);
    Xil_Out32(base_addr + offset + 0x04, w1);
    Xil_Out32(base_addr + offset + 0x00, w0);
}

void update_lcd_line1(SystemState state) {
    if (state == ENABLED) {
        write_lcd_line(LCD_BASE_ADDR, 0x00, 0x456E6162, 0x6C656420, 0x20202020, 0x20202020); // "Enabled         "
    } else {
        write_lcd_line(LCD_BASE_ADDR, 0x00, 0x44697361, 0x626C6564, 0x20202020, 0x20202020); // "Disabled        "
    }
}

void update_lcd_line2(AnalogSource src) {
    if (src == POT) {
        write_lcd_line(LCD_BASE_ADDR, 0x10, 0x506F7465, 0x6E74696F, 0x6D657465, 0x72202020); // "Potentiometer   "
    } else {
        write_lcd_line(LCD_BASE_ADDR, 0x10, 0x4C696768, 0x74205365, 0x6E736F72, 0x20202020); // "Light Sensor    "
    }
}

void clear_lcd_line2(){
	write_lcd_line(LCD_BASE_ADDR, 0x10, 0x20202020, 0x20202020, 0x20202020, 0x20202020);
}

/****************************************************************************/
/**
* This function is the main function of the GPIO example.  It is responsible
* for initializing the GPIO device, setting up interrupts and providing a
* foreground loop such that interrupt can occur in the background.
*
* @param	None.
*
* @return
*		- XST_SUCCESS to indicate success.
*		- XST_FAILURE to indicate failure.
*
* @note		None.
*
*****************************************************************************/
#ifndef TESTAPP_GEN
int main() {
    XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
    XGpio_SetDataDirection(&Gpio, GPIO_CHANNEL1, 0xFF);

    xil_printf("Interrupt-Driven LCD Controller Initialized.\r\n");

    update_lcd_line1(current_state);
    clear_lcd_line2();

    // Set up interrupts (use existing GpioSetupIntrSystem...)
    GpioSetupIntrSystem(&Intc, &Gpio, GPIO_DEVICE_ID, INTC_GPIO_INTERRUPT_ID, GPIO_CHANNEL1);


    while (1); // interrupts handle state

    return 0;
}
//int main(void)
//{
//	int Status;
////	u32 DataRead;
//
//	  print(" Press button to Generate Interrupt\r\n");
//
//	  Status = GpioIntrExample(&Intc, &Gpio,
//				   GPIO_DEVICE_ID,
//				   INTC_GPIO_INTERRUPT_ID,
//				   GPIO_CHANNEL1, NULL); //replace Null with *DataRead
//
//	if (Status != XST_SUCCESS ){
//		xil_printf("Gpio Interrupt Setup Failed.\r\n");
////		if(DataRead == 0)
////			print("No button pressed. \r\n");
////		else
////			print("Successfully ran Gpio Interrupt Tapp Example\r\n");
////	} else {
////		 print("Gpio Interrupt Tapp Example Failed.\r\n");
//		 return XST_FAILURE;
//	}
//
//	while(1){
//
//	}
//
//	return XST_SUCCESS;
//}
#endif

/******************************************************************************/
/**
*
* This is the entry function from the TestAppGen tool generated application
* which tests the interrupts when enabled in the GPIO
*
* @param	IntcInstancePtr is a reference to the Interrupt Controller
*		driver Instance
* @param	InstancePtr is a reference to the GPIO driver Instance
* @param	DeviceId is the XPAR_<GPIO_instance>_DEVICE_ID value from
*		xparameters.h
* @param	IntrId is XPAR_<INTC_instance>_<GPIO_instance>_IP2INTC_IRPT_INTR
*		value from xparameters.h
* @param	IntrMask is the GPIO channel mask
* @param	DataRead is the pointer where the data read from GPIO Input is
*		returned
*
* @return
*		- XST_SUCCESS if the Test is successful
*		- XST_FAILURE if the test is not successful
*
* @note		None.
*
******************************************************************************/
int GpioIntrExample(INTC *IntcInstancePtr, XGpio* InstancePtr, u16 DeviceId,
			u16 IntrId, u16 IntrMask, u32 *DataRead)
{
	int Status;
	u32 delay;

	/* Initialize the GPIO driver. If an error occurs then exit */
	Status = XGpio_Initialize(InstancePtr, DeviceId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	Status = GpioSetupIntrSystem(IntcInstancePtr, InstancePtr, DeviceId,
					IntrId, IntrMask);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	IntrFlag = 0;
	delay = 0;

	while(!IntrFlag && (delay < INTR_DELAY)) {
		delay++;
	}

//	GpioDisableIntr(IntcInstancePtr, InstancePtr, IntrId, IntrMask);

//	*DataRead = IntrFlag;

	return Status;
}


/******************************************************************************/
/**
*
* This function performs the GPIO set up for Interrupts
*
* @param	IntcInstancePtr is a reference to the Interrupt Controller
*		driver Instance
* @param	InstancePtr is a reference to the GPIO driver Instance
* @param	DeviceId is the XPAR_<GPIO_instance>_DEVICE_ID value from
*		xparameters.h
* @param	IntrId is XPAR_<INTC_instance>_<GPIO_instance>_IP2INTC_IRPT_INTR
*		value from xparameters.h
* @param	IntrMask is the GPIO channel mask
*
* @return	XST_SUCCESS if the Test is successful, otherwise XST_FAILURE
*
* @note		None.
*
******************************************************************************/
int GpioSetupIntrSystem(INTC *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId, u16 IntrMask)
{
	int Result;

	GlobalIntrMask = IntrMask;

#ifdef XPAR_INTC_0_DEVICE_ID

#ifndef TESTAPP_GEN
	/*
	 * Initialize the interrupt controller driver so that it's ready to use.
	 * specify the device ID that was generated in xparameters.h
	 */
	Result = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Result != XST_SUCCESS) {
		return Result;
	}
#endif /* TESTAPP_GEN */

	/* Hook up interrupt service routine */
	XIntc_Connect(IntcInstancePtr, IntrId,
		      (Xil_ExceptionHandler)GpioHandler, InstancePtr);

	/* Enable the interrupt vector at the interrupt controller */
	XIntc_Enable(IntcInstancePtr, IntrId);

#ifndef TESTAPP_GEN
	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	Result = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Result != XST_SUCCESS) {
		return Result;
	}
#endif /* TESTAPP_GEN */

#else /* !XPAR_INTC_0_DEVICE_ID */

#ifndef TESTAPP_GEN
	XScuGic_Config *IntcConfig;

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Result = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Result != XST_SUCCESS) {
		return XST_FAILURE;
	}
#endif /* TESTAPP_GEN */

	XScuGic_SetPriorityTriggerType(IntcInstancePtr, IntrId,
					0xA0, 0x3);

	/*
	 * Connect the interrupt handler that will be called when an
	 * interrupt occurs for the device.
	 */
	Result = XScuGic_Connect(IntcInstancePtr, IntrId,
				 (Xil_ExceptionHandler)GpioHandler, InstancePtr);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/* Enable the interrupt for the GPIO device.*/
	XScuGic_Enable(IntcInstancePtr, IntrId);
#endif /* XPAR_INTC_0_DEVICE_ID */

	/*
	 * Enable the GPIO channel interrupts so that push button can be
	 * detected and enable interrupts for the GPIO device
	 */
	XGpio_InterruptEnable(InstancePtr, IntrMask);
	XGpio_InterruptGlobalEnable(InstancePtr);

	/*
	 * Initialize the exception table and register the interrupt
	 * controller handler with the exception table
	 */
	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER, IntcInstancePtr);

	/* Enable non-critical exceptions */
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

/******************************************************************************/
/**
*
* This is the interrupt handler routine for the GPIO for this example.
*
* @param	CallbackRef is the Callback reference for the handler.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void GpioHandler(void *CallbackRef)
{
    XGpio *GpioPtr = (XGpio *)CallbackRef;
    u32 btns = XGpio_DiscreteRead(GpioPtr, GPIO_CHANNEL1);

    static u32 prev_btns = 0;
    u32 rising = (btns ^ prev_btns) & btns;
    prev_btns = btns;

    if(rising){
    	 xil_printf("Interrupt Triggered. Button value: 0x%X\r\n", btns);
    }

    if (rising & BTN_Reset_BIT) {
        current_state = DISABLED;
        current_source = POT;
        write_lcd_line(LCD_BASE_ADDR, 0x00, 0x52657365, 0x74205379, 0x7374656D, 0x20202020); // "Reset System    "
        clear_lcd_line2();
    }

    if (rising & BTN_SRC_BIT) {
        current_source = (current_source == POT) ? LIGHT : POT;
        if (current_state == ENABLED) {
            update_lcd_line2(current_source);
        }
    }

    if (rising & BTN_EN_BIT) {
        current_state = (current_state == ENABLED) ? DISABLED : ENABLED;
        update_lcd_line1(current_state);
        if (current_state == ENABLED) {
            update_lcd_line2(current_source);
        } else {
            clear_lcd_line2();
        }
    }



    XGpio_InterruptClear(GpioPtr, GlobalIntrMask);
}
//void GpioHandler(void *CallbackRef)
//{
//	XGpio *GpioPtr = (XGpio *)CallbackRef;
//
//	u32 btns = XGpio_DiscreteRead(GpioPtr, BUTTON_CHANNEL);
//
//	xil_printf("Interrupt Triggered. Button value: 0x%X\r\n", btns);
//
//	if (btns & 0x01){//BTN0
//		xil_printf("BTN0 was pressed\r\n\n");
//		write_lcd_line(LCD_BASE_ADDR, 0x00, 0x52657365, 0x74202020, 0x20202020, 0x20202020); // "Reset System    "
//		write_lcd_line(LCD_BASE_ADDR, 0x10, 0x20202020, 0x20202020, 0x20202020, 0x20202020); // "    "
//	} else if (btns & 0x02){ //BTN1
//		xil_printf("BTN1 was pressed\r\n\n");
//		write_lcd_line(LCD_BASE_ADDR, 0x00, 0x456E6162, 0x6C656420, 0x20202020, 0x20202020); // "Enabled    "
//		write_lcd_line(LCD_BASE_ADDR, 0x10,  0x506F7465, 0x6E74696F, 0x6D657465, 0x72202020); // "Potentiometer    "
//	}else if (btns & 0x04){ //BTN1
//		xil_printf("BTN2 was pressed\r\n\n");
//		write_lcd_line(LCD_BASE_ADDR, 0x00, 0x44697361, 0x626C6564, 0x20202020, 0x20202020); // "Disabled    "
//		write_lcd_line(LCD_BASE_ADDR, 0x10, 0x20202020, 0x20202020, 0x20202020, 0x20202020); // "    "
//	}
//
////	if(btns != 0){
////
////		xil_printf("Interrupt Triggered. Button value: 0x%X\r\n", btns);
////
////		if (btns & 0x01)
////			xil_printf("BTN0 was pressed\r\n\n");
////		else if (btns & 0x02)
////			xil_printf("BTN1 was pressed\r\n\n");
////		else if (btns & 0x04)
////			xil_printf("BTN2 was pressed\r\n\n");
////
////	}
//
//	/* Clear the Interrupt */
//	XGpio_InterruptClear(GpioPtr, GlobalIntrMask);
////	IntrFlag = 1;
//
//}

/******************************************************************************/
/**
*
* This function disables the interrupts for the GPIO
*
* @param	IntcInstancePtr is a pointer to the Interrupt Controller
*		driver Instance
* @param	InstancePtr is a pointer to the GPIO driver Instance
* @param	IntrId is XPAR_<INTC_instance>_<GPIO_instance>_VEC
*		value from xparameters.h
* @param	IntrMask is the GPIO channel mask
*
* @return	None
*
* @note		None.
*
******************************************************************************/
void GpioDisableIntr(INTC *IntcInstancePtr, XGpio *InstancePtr,
			u16 IntrId, u16 IntrMask)
{
	XGpio_InterruptDisable(InstancePtr, IntrMask);
#ifdef XPAR_INTC_0_DEVICE_ID
	XIntc_Disable(IntcInstancePtr, IntrId);
#else
	/* Disconnect the interrupt */
	XScuGic_Disable(IntcInstancePtr, IntrId);
	XScuGic_Disconnect(IntcInstancePtr, IntrId);
#endif
	return;
}
