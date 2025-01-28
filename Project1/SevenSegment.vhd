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

    signal address_buffer : STD_LOGIC_VECTOR(7 downto 0); 
    signal current_digit  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Current digit
    signal digit_index    : INTEGER range 0 to 5 := 0; -- Index for selecting digits
    signal refresh_count  : INTEGER := 0; -- Counter for multiplexing displays
	 signal hex            : STD_LOGIC_VECTOR(3 downto 0);
	 signal seg            : STD_LOGIC_VECTOR(6 downto 0);
	 signal loopiter			: integer range 0 to 4;
    -- 7-segment encoding 
    
 begin
	
	process(clk, reset,hex,seg)
	 begin
      if reset = '1' then
		 data_out <= (others => '0');
		 elsif rising_edge(clk)then
			hex <= data_in(3 downto 0);
			data_out(6 downto 0) <= seg;

--			for loopiter in 0 to(NUM_SEG_DISPLAY-1) loop			-- input for how big it is (segments) 
--				hex <= data_in((loopiter+1)*4-1 downto loopiter*4); 
--				data_out((loopiter+1)*7-1 downto loopiter*7) <= seg;
			end loop;
			end if;
		end process;
			
			
	process(hex,seg,clk)
		begin
		if (rising_edge(clk)) then
        case hex is
            when "0000" => seg <= "1000000"; -- 0
            when "0001" => seg <= "1111001"; -- 1
            when "0010" => seg <= "0100100"; -- 2
            when "0011" => seg <= "0110000"; -- 3
            when "0100" => seg <= "0011001"; -- 4
            when "0101" => seg <= "0010010"; -- 5
            when "0110" => seg <= "0000010"; -- 6
            when "0111" => seg <= "1111000"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0010000"; -- 9
            when "1010" => seg <= "0001000"; -- A
            when "1011" => seg <= "0000011"; -- B
            when "1100" => seg <= "1000110"; -- C
            when "1101" => seg <= "0100001"; -- D
            when "1110" => seg <= "0000110"; -- E
            when "1111" => seg <= "0001110"; -- F
            when others => seg <= "1111111"; -- Blank
        end case;
		 end if;
    end process;
		 

end Behavioral;
