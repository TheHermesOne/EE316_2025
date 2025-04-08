--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY hw_image_generator IS
  GENERIC(
    pixels_y :  INTEGER := 256;   --row that first color will persist until
    pixels_x :  INTEGER := 256;    --column that first color will persist until
    screen_y :  INTEGER := 480;
    screen_x :  INTEGER := 640);  
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    pixel_clk:  IN   STD_LOGIC;
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    RAMData    :  IN   std_logic_vector(2 downto 0);
    RAMADDR   : OUT std_logic_vector(15 downto 0); 
    letterData: IN   std_logic_vector(7 downto 0);
    letterAddr: OUT  std_logic_vector(8 downto 0);
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0') --blue magnitude output to DAC
   );
END hw_image_generator;




ARCHITECTURE behavior OF hw_image_generator IS

signal offsetX : integer:= ((screen_x - pixels_x)/2);  
signal offsetY : integer:= ((screen_y - pixels_y)/2);

SIGNAL pixel_x : INTEGER:= 10;  -- Initial pixel X position
SIGNAL pixel_y : INTEGER := 10;  -- Initial pixel Y position
SIGNAL direction_x : INTEGER := 1;
SIGNAL direction_y : INTEGER := 1;

constant BOX_CLK_DIV : natural := 1000000; --MAX=(2^25 - 1)
signal box_cntr_reg : std_logic_vector(24 downto 0) := (others =>'0');
signal update_box : std_logic;

signal Stringin: string(1 to 11):= "Hello World";
signal CharIn: unsigned(7 downto 0);

signal LetterNum: unsigned ( 8 downto 0);
signal letterRowIndex: unsigned(2 downto 0);
signal letter_col_index:integer;

constant text_x : integer := 100; -- column position
constant text_y : integer := 50;  -- row position
signal tempiteratior : integer;

signal RAMaddrTemp: unsigned(15 downto 0);
signal RAM_YAxis : integer;
signal RAM_XAxis : integer;

BEGIN

RAMADDR <= std_logic_vector(RAMaddrTemp);

  PROCESS(disp_ena, row, column)
  BEGIN
    IF(disp_ena = '1') THEN        --display time
--      IF row >= text_y and row < text_y + 8 and column >= text_x*tempiteratior and column < text_x + 8*tempiteratior then
--            letter_col_index <= column - text_x;
--         if letterData(7 - letter_col_index) = '1' then
--                  red   <= (others => '1');
--                  green <= (others => '0');
--                  blue  <= (others => '0');
--                else
--                  red   <= (others => '0');
--                  green <= (others => '0');
--                  blue  <= (others => '0');
--                END IF;
      IF((row < (pixels_y+offsetY) AND row > offsetY)  AND (column < (pixels_x + offsetX) AND column > offsetX)) THEN
                    RAMaddrTemp <= to_unsigned(((row - offsetY) * 256) + (column - offsetX), RAMaddrTemp'length);
                    red <= (others => RAMData(2));
                    green <= (others => RAMData(1));
                    blue <= (others => RAMData(0));
--          IF((row > pixel_y+offsetY AND row < pixel_y+offsetY+10) AND (column > pixel_x+offsetX AND column < pixel_x+offsetX+10 )) THEN
--          red <= (OTHERS => '0');
--          green  <= (OTHERS => '0');
--          blue <= (OTHERS => '1'); 
--          ELSE
--          red <= (OTHERS => '1');
--          green  <= (OTHERS => '1');
--          blue <= (OTHERS => '1');
--          END if;
      elsIF (row mod 10 = 0) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '0');
      ELSE
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
      END IF;
    ELSE                           --blanking time
      red <= (OTHERS => '0');
      green <= (OTHERS => '0');
      blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
  

process (pixel_clk)
begin
    if rising_edge(pixel_clk) then
        if (disp_ena = '1') THEN
            if (row >= text_y and row < text_y + 8) then
                for i in stringin'length downto 0 loop
                 if column >= text_x + (i - 1) * 8 and column < text_x + i * 8 then
                    tempiteratior <= i;
                    CharIn <= to_unsigned(character 'pos(stringIn(i)),8);
                    LetterNum <= shift_left((CharIn & '0'),2);
                    letterRowIndex <= to_unsigned(row - text_y,3);
                    letterAddr <= std_logic_vector(unsigned(LetterNum) + resize(letterRowIndex, LetterNum'length));
                    
                end if;
            end loop;
      end if;
    end if;    
  end if;

END PROCESS;

  
  
process (pixel_clk)
  begin
    if (rising_edge(pixel_clk)) then
      if (box_cntr_reg >= (BOX_CLK_DIV - 1)) then
        box_cntr_reg <= (others=>'0');
        update_box <= not update_box;
        if (update_box = '1') then
            pixel_x <= pixel_x + direction_x;
            if ((direction_x = 1 AND pixel_x >= pixels_x-10) or (direction_x = -1 AND pixel_x <= pixels_x - offsetX)) THEN
                direction_x <= -direction_x;
            end if;

       end if;
      else
        box_cntr_reg <= box_cntr_reg + 1;     
      end if;
    end if;
  end process;
 
   
END behavior;
