library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proj3clk is
   port(
		clk 			: in std_logic;
		reset			: in std_logic;
		datain		: in std_logic_vector(7 downto 0);
		clock_out	: out std_logic;
		data_ready	: in std_logic;
		btn			: in std_logic_vector(3 downto 0)
		
   );
end proj3clk;

architecture Behavioral of proj3clk is
	type state_type is (start, data_read, clock_gen);
	 signal N_1				: integer;
	 signal N_2				: integer;
	 signal N				: integer:= 0;
	 signal int 			: integer := 50000;
	 signal counter 		: integer;
	 signal state			: state_type;
	 signal clock_reg		: std_logic;
	 
	 
begin
	
	inst_counter: process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
        elsif rising_edge(clk) then
				if counter < N then
					counter <= counter + 1;
				else 
					counter <= 0;
				end if;
        end if;
    end process;
	
	
	inst_clock_logic: process(clk)
	begin
		if rising_edge(clk) then
            if btn(2) = '1' then
                case state is
                    when start =>
                        N <= 0;
                        clock_reg 	<= '0';
                        if data_ready = '1' then
                            state <= data_read;
                        else
                            state <= start;
                        end if;
                    when data_read =>
                        if reset = '1' then
                            state <= start;
                        else
                            N_1 <= to_integer(unsigned("0" & datain & "0000000"));
                            N_2 <= to_integer(unsigned("0000000" & datain & "0"));
                            N <= int - N_1 - N_2;
                            state <= clock_gen;
                        end if;
                    when clock_gen =>
                        if reset = '1' then
                            state <= start;
                        else
                            if data_ready = '1' then
                                state <= data_read;
                            else
                                if clock_reg = '0' then
                                    if counter = 0 then
                                        clock_reg <= '1';
                                        clock_out <= clock_reg;
                                        state <= clock_gen;
                                    end if;
                                else
                                    if counter = 0 then	
                                        clock_reg <= '0';
                                        clock_out <= clock_reg;
                                        state <= clock_gen;
                                    end if;
                                end if;
                            end if;
                        end if;
                    when others => null;
                end case;
		    else
			    clock_reg <= '0';
                clock_out <= clock_reg;
		    end if;
        end if;
	end process;
	
end Behavioral;
		
