-- kp_controller

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity KP_Controller is
    Port (
        clk         : in  std_logic;  
        rows        : in  std_logic_vector(4 downto 0);
        columns     : out std_logic_vector(3 downto 0);
        oData       : out std_logic_vector(4 downto 0);
        kp_pulse20  : out std_logic
    );
   
end KP_Controller;

architecture Behavioral of KP_Controller is
   
    type state_type is (A, B, C, D);
    signal state             : state_type := A;

    signal clk_cnt           : integer range 0 to 999999 ;
    signal clk_en            : std_logic; -- 5ms clock e             
    signal key_pressed       : std_logic;
    signal kp_pulse5         : std_logic;
    signal r                 : std_logic_vector(1 downto 0); -- registers
	 signal q                 : std_logic_vector(1 downto 0); -- registers



begin

key_pressed <= not (rows(0) and rows(1) and rows(2) and rows(3) and rows(4));
    
	 process(clk)
    begin
        if rising_edge(clk) then
            if (clk_cnt = 499999) then
                clk_cnt <= 0;
                clk_en <= '1';
            else
                clk_cnt <= clk_cnt + 1;
                clk_en  <= '0';
            end if;
        end if;
    end process;


   
    process(clk,state)
    begin
    if rising_edge(clk) and clk_en = '1' then
        if key_pressed = '0' then
            case state is
                when A => state <= B;
                when B => state <= C;
                when C => state <= D;
                when D => state <= A;
                when others => state <= A;
            end case;
        end if;
    end if;
end process;

    process(state)
        begin
            case state is
                when A => columns <= "0111";
                when B => columns <= "1011";
                when C => columns <= "1101";
                when D => columns <= "1110";
            when others => columns <= "1111";
        end case;
    end process;

    process(clk, rows)
    begin
        if rising_edge(clk) then
        case state is
            when A =>
                case rows is
        when "01111" => oData <= '0' & X"A"; -- A
        when "10111" => oData <= '0' & X"1"; -- 1
        when "11011" => oData <= '0' & X"4"; -- 4
        when "11101" => oData <= '0' & X"7"; -- 7
        when "11110" => oData <= '0' & X"0"; -- 0
        when others  => oData <= '1' & X"F"; -- no connection
            end case;
               
        when B =>
                case rows is        
        when "01111" => oData <= '0' & X"B"; -- B
        when "10111" => oData <= '0' & X"2"; -- 2
        when "11011" => oData <= '0' & X"5"; -- 5
        when "11101" => oData <= '0' & X"8"; -- 8
        when "11110" => oData <= '1' & X"2"; -- H
        when others  => oData <= '1' & X"F"; -- no connection
            end case;
               
        when C =>
                case rows is
        when "01111" => oData <= '0' & X"C"; -- C
        when "10111" => oData <= '0' & X"3"; -- 3
        when "11011" => oData <= '0' & X"6"; -- 6
        when "11101" => oData <= '0' & X"9"; -- 9
        when "11110" => oData <= '1' & X"1"; -- L
        when others  => oData <= '1' & X"F"; -- No Connection
end case;

        when D =>
                case rows is
        when "01111" => oData <= '0' & X"D"; -- D
        when "10111" => oData <= '0' & X"E"; -- E
        when "11011" => oData <= '0' & X"F"; -- F
        when "11101" => oData <= '1' & X"3"; -- SHIFT
        when "11110" => oData <= '1' & X"F"; -- No Connection
        when others  => oData <= '1' & X"F"; -- No connection
end case;
end case;
end if;
end process;

        -- r and q are used to generate pulses based on key_pressed transitions
		  
process(clk)
   begin
   if rising_edge(clk) and clk_en = '1' then -- r is a 2 bit shift register
  	 r(0) <= key_pressed; 		-- r(0) stores current value
   	 r(1) <= r(0); 			-- r(1) stores previous value
	 kp_pulse5 <= r(0) and not r(1);
   end if;
end process;
          
process(clk) -- second process uses 2 bit shift reg q to store states of key_pressed 
   begin
   if rising_edge(clk) then 
    	 q(0) <= kp_pulse5; 		  -- q(0) stores current state
	 q(1) <= q(0); 			  -- q(1) stores prev state
	 kp_pulse20 <= q(0) and not q(1); -- on rising_edge of kp_pulse5 kp_pulse20 is created?
   end if;
end process;
       
          
end architecture Behavioral;
