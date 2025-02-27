library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_gen is
   port(
		clk 		: in std_logic;
		reset		: in std_logic;
		datain		: in std_logic_vector(7 downto 0);
		clock_out	: out std_logic
   );
end clock_gen;

architecture behavioral of clock_gen is

   signal counter	: integer range 0 to 50000 := 50000;
	signal clk_reg	: std_logic := '0';
	signal N_1		: integer;
	signal N_2		: integer;
	signal N			: integer;

begin
    inst_counter: process(clk, reset)
    begin
        if reset = '1' then
            counter <= 50000;
            clk_reg <= '0';
        elsif rising_edge(clk) then
			if counter > 16666 then
				counter <= counter - 130;
			elsif counter < N then
				clk_reg <= not clk_reg;
				counter <= 50000;
			else
				counter <= 50000;
			end if;
        end if;
    end process;

	 N_1 <= to_integer(unsigned("0" & datain & "0000000"));
	 N_2 <= to_integer(unsigned("0000000" & datain & "0"));
	 N   <= 50000 - N_1 - N_2;
			
	clock_out <= clk_reg;

end behavioral;
