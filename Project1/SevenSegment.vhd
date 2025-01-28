library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Generic (
	 NUM_SEG_DISPLAY : integer := 4  
	 );
	 
	 Port (
		  
        clk           : in  STD_LOGIC;             -- Clock signal
        reset         : in  STD_LOGIC;             -- Reset signal
		  data_in       : in  STD_LOGIC_VECTOR((NUM_SEG_DISPLAY * 4 - 1) downto 0);
		  data_out		 : out STD_LOGIC_VECTOR((NUM_SEG_DISPLAY * 7 - 1) downto 0)
    );
end SevenSegment;

architecture Behavioral of SevenSegment is

	 signal loopiter			: integer range 0 to 4;
    -- 7-segment encoding 
  	function Hex2SegFunc (hex : in std_LOGIC_VECTOR(3 downto 0)) return std_LOGIC_VECTOR is
		begin
        case hex is
            when "0000" => return "1000000"; -- 0
            when "0001" => return "1111001"; -- 1
            when "0010" => return "0100100"; -- 2
            when "0011" => return "0110000"; -- 3
            when "0100" => return "0011001"; -- 4
            when "0101" => return "0010010"; -- 5
            when "0110" => return "0000010"; -- 6
            when "0111" => return "1111000"; -- 7
            when "1000" => return "0000000"; -- 8
            when "1001" => return "0010000"; -- 9
            when "1010" => return "0001000"; -- A
            when "1011" => return "0000011"; -- B
            when "1100" => return "1000110"; -- C
            when "1101" => return "0100001"; -- D
            when "1110" => return "0000110"; -- E
            when "1111" => return "0001110"; -- F
            when others => return "1111111"; -- Blank
        end case;
		 end function;
		 
 begin
	
	process(clk, reset)
	 begin
      if reset = '1' then
		 data_out <= (others => '0');
		 elsif rising_edge(clk)then
			for loopiter in 0 to(NUM_SEG_DISPLAY-1) loop			-- input for how big it is (segments) 
				data_out((loopiter+1)*7-1 downto loopiter*7)<= Hex2SegFunc(data_in((loopiter+1)*4-1 downto loopiter*4)); 
			end loop;
			end if;
		end process;
			
end Behavioral;