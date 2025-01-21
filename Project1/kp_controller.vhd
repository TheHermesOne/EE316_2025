-- kp_controller

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity KP_Controller is
    Port (
        clk         : in  std_logic;  
        rows        : in  std_logic_vector(3 downto 0); 
        columns     : out std_logic_vector(4 downto 0);
        oData       : out std_logic_vector(4 downto 0);
        clk_en_out  : out std_logic;
        kp_pulse    : out std_logic;
        et_pulse    : out std_logic
    );
    
end KP_Controller;

architecture Behavioral of KP_Controller is
    
    type state_type is (A, B, C, D);
    signal state             : state_type := A;

    constant cnt_max         : integer := 250000;
    signal clk_cnt           : integer range 0 to cnt_max;
    signal clk_en            : std_logic;
    signal key_press         : std_logic;                  
    signal key_pressed       : std_logic; 
    signal nkey_press      : std_logic;
    signal reg1              : std_logic;
    signal reg2              : std_logic;
	 signal internal_kp_pulse : std_logic; 

begin

key_pressed <= not (rows(0) and rows(1) and rows(2) and rows(3)); --and rows(4));
    process(clk)
    begin
        if rising_edge(clk) then
            if (clk_cnt = 249999) then 
                clk_cnt <= 0;
                clk_en <= '1';
            else
                clk_cnt <= clk_cnt + 1;
                clk_en <= '0';
            end if;
        end if;
    end process;

            process(clk)
            begin 
                if rising_edge(clk) and clk_en = '1' then
                key_press <= key_pressed;
                nkey_Press <= key_press;
                internal_kp_pulse <= key_press and not nkey_press;
					 kp_pulse <= internal_kp_pulse;
            end if;
    end process;
    
    process(clk,state)
    begin
    if rising_edge(clk) and internal_kp_pulse = '1' then
        if key_Pressed = '0' then
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
                when A => columns <= "1110";
                when B => columns <= "1101";
                when C => columns <= "1011";
                when D => columns <= "0111";
            when others => columns <= "1111";
        end case;
    end process;

    process(state, rows)
    begin
        case state is
            when A =>
                case rows is
        when "11110" => oData <= "01010";
        when "11101" => oData <= "00001";
        when "11110" => oData <= "00100";
        when "11110" => oData <= "00111";
        when "11110" => oData <= "00000";
        when others  => oData <= "11111";
            end case;
                
        when B => 
                case rows is         
        when "11110" => oData <= "01011";
        when "11101" => oData <= "00010";
        when "11110" => oData <= "00100";
        when "11110" => oData <= "00111";
        when "11110" => oData <= "00000";
        when others  => oData <= "11111";
            end case;
                
        when C => 
                case rows is
        when "11110" => oData <= "01011"; 
        when "11101" => oData <= "00010"; 
        when "11011" => oData <= "00100";
        when "10111" => oData <= "00111"; 
        when "01111" => oData <= "00000"; 
        when others  => oData <= "11111";		
		end case; 

        when D => 
                case rows is
        when "11110" => oData <= "01011"; 
        when "11101" => oData <= "00010"; --3 
        when "11011" => oData <= "00100"; 
        when "10111" => oData <= "00111"; 
        when "01111" => oData <= "00000"; 
        when others  => oData <= "11111";		
		end case; 
    end case;
end process;
        
--clk_en <= clk_en_out;
            
end architecture Behavioral;
