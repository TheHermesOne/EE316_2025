library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity rotary is
		generic(N: integer := 8; N2: integer := 255; N1: integer := 0);
		port (
		iCLK					: in std_logic; 
		A						: in std_logic; -- A value
		B		 				: in std_logic; -- B value
		count_out				: out std_logic_vector(N-1 downto 0)
		);
end rotary;

architecture Arch of rotary is



	component btn_debounce_toggle is
		 GENERIC (
			 CONSTANT CNTR_MAX 	: std_logic_vector(15 downto 0) := X"FFFF");
		 PORT(	
			BTN_I						: in std_logic;	 
			clk						    : in std_logic;
			BTN_O 					    : out std_logic;
			TOGGLE_O 			        : out std_logic;
			PULSE_O 					: out std_logic);
	end component;


--	signal SW_db							: std_logic;
	signal A_db 							: std_logic;
	signal B_db 							: std_logic;
	signal A_prev  : std_logic := '0';
	signal B_prev  : std_logic := '0';
--    signal reset_d 		       		        : std_logic;	
	signal Enc_Out						    : std_logic_vector(1 downto 0);
    signal count                            : integer := 0;
begin

process(iclk)
begin
    if rising_edge(iclk) then
        A_prev <= A_db;
        B_prev <= B_db;
    end if;
end process;

--Process(iCLK)
--Begin
--    if rising_edge(iClK) THEN 
--			if A_db /= A_prev then
--			     if B_db /= B_prev then
--			         if count < 256 then
--			             count <= count + 1;
--			         end if;
--			     else
--			         if count > 0 then
--			             count <= count - 1;
--			         end if;
--			      end if;
--			 end if;
--	       count_out <= std_logic_vector(to_unsigned(count, 8));
--    end if;
--end process;
process(iclk)
begin
    if rising_edge(iclk) then
        A_prev <= A_db;
        B_prev <= B_db;
        
        if (A_prev = '0' and A_db = '1') then
            if B_db = '0' then  
                if count < 255 then
                    count <= count + 1;
                end if;
            else
                if count > 0 then
                    count <= count - 1;
                end if;
            end if;
        end if;
        count_out <= std_logic_vector(to_unsigned(count, 8));
    end if;
end process;



				
	inst_A: btn_debounce_toggle
	GENERIC MAP( CNTR_MAX => X"FFFF")
		Port Map( 
				BTN_I 		=> A,
				CLK 		=> iCLK,
				BTN_O 		=> A_db,
				TOGGLE_O 	=> open,
				PULSE_O 	=> open
				);
				
	inst_B: btn_debounce_toggle
	GENERIC MAP( CNTR_MAX => X"FFFF")
		Port Map( 
				BTN_I 		=> B,
				CLK 		=> iCLK,
				BTN_O 		=> B_db,
				TOGGLE_O 	=> open,
				PULSE_O 	=> open
				);
				
	





end Arch;

