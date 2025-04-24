/*****************************************************************************/
/**
*
* Configures timers to capture Timer input events.
*
* @param	InstancePtr is a pointer to the XTmrCtr instance.
* @param	PwmPeriod is the period of pwm signal in nano seconds.
* @param	PwmHighTime is the high time of pwm signal in nano seconds.
*
* @return	the duty cycle that will possibly be achieved.
*
* @note		This function needs to be called before enabling PWM otherwise
*		the output of PWM may be indeterminate. Here Down count mode of
*		timers are used for generating PWM output.
*
******************************************************************************/
u8 XTmrCtr_PwmConfigure(XTmrCtr *InstancePtr, u32 PwmPeriod, u32 PwmHighTime)
{
	u32 CounterControlReg;
	u32 SysClkPeriod;
	u64 Period;
	u64 High;

	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Stop the timers if they are running */
	if (InstancePtr->IsStartedTmrCtr0 == XIL_COMPONENT_IS_STARTED) {
		XTmrCtr_Stop(InstancePtr, XTC_TIMER_0);
	}
	if (InstancePtr->IsStartedTmrCtr1 == XIL_COMPONENT_IS_STARTED) {
		XTmrCtr_Stop(InstancePtr, XTC_TIMER_1);
	}

	/* Configure timers modes to be used for PWM */
	CounterControlReg = XTmrCtr_ReadReg(InstancePtr->BaseAddress,
					XTC_TIMER_0, XTC_TCSR_OFFSET);
	CounterControlReg |=
		(XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_AUTO_RELOAD_MASK);
	CounterControlReg &= ~(XTC_CSR_CASC_MASK | XTC_CSR_EXT_GENERATE_MASK);
	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_0,
					XTC_TCSR_OFFSET, CounterControlReg);

	CounterControlReg = XTmrCtr_ReadReg(InstancePtr->BaseAddress,
					XTC_TIMER_1, XTC_TCSR_OFFSET);
	CounterControlReg |=
		(XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_AUTO_RELOAD_MASK);
	CounterControlReg &= ~(XTC_CSR_CASC_MASK | XTC_CSR_EXT_GENERATE_MASK);
	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_1,
					XTC_TCSR_OFFSET, CounterControlReg);

	/* Set period and high time for PWM */
	SysClkPeriod = XTC_HZ_TO_NS(InstancePtr->Config.SysClockFreqHz);
	if (PwmPeriod < PwmHighTime ||
		PwmPeriod < (2 * SysClkPeriod) ||
		PwmHighTime < (2 * SysClkPeriod)) {
		return XST_INVALID_PARAM;
	}

	Period = XTC_ROUND_DIV(PwmPeriod, SysClkPeriod) - 2;
	High = XTC_ROUND_DIV(PwmHighTime, SysClkPeriod) - 2;
	if (Period > XTC_MAX_LOAD_VALUE) {
		return XST_INVALID_PARAM;
	}

	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_0,
						XTC_TLR_OFFSET, (u32)Period);
	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_1,
						XTC_TLR_OFFSET, (u32)High);

	/* Configure timers in generate mode */
	CounterControlReg = XTmrCtr_ReadReg(InstancePtr->BaseAddress,
					XTC_TIMER_0, XTC_TCSR_OFFSET);
	CounterControlReg &= ~(XTC_CSR_CAPTURE_MODE_MASK);
	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_0,
					XTC_TCSR_OFFSET, CounterControlReg);
	CounterControlReg = XTmrCtr_ReadReg(InstancePtr->BaseAddress,
					XTC_TIMER_1, XTC_TCSR_OFFSET);
	CounterControlReg &= ~(XTC_CSR_CAPTURE_MODE_MASK);
	XTmrCtr_WriteReg(InstancePtr->BaseAddress, XTC_TIMER_1,
					XTC_TCSR_OFFSET, CounterControlReg);

	return (((float)High / Period * 100));
}
