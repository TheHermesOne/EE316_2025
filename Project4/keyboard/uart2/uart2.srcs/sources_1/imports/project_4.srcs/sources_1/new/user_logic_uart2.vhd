----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2025 09:01:55 PM
-- Design Name: 
-- Module Name: user_logic_uart2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity user_logic_uart2 is
Port (  
        clk          :in std_logic; 
        utx_data     :in  std_logic_vector (7 downto 0);--ps2 data 
        ureset       :in  std_logic;
        utxclk       :in  std_logic;-- baud rate 
        utx_pulse    :in  std_logic;
        utx_out      :out std_logic-- serial data sent to isaak's rx
        
);
end user_logic_uart2;

architecture Behavioral of user_logic_uart2 is
component uart is
port  (
        reset       :in  std_logic;
        txclk       :in  std_logic;-- ps2_clk
        ld_tx_data  :in  std_logic;--KB pulse 
        tx_data     :in  std_logic_vector (7 downto 0);--ps2 data 
        tx_enable   :in  std_logic;-- always keep enabled 
        
        tx_out      :out std_logic;
        tx_empty    :out std_logic;
        
        rxclk       :in  std_logic;--ps2_clk
        uld_rx_data :in  std_logic;
        rx_enable   :in  std_logic;
        rx_in       :in  std_logic;
        
        rx_empty    :out std_logic;
        rx_data     :out std_logic_vector (7 downto 0)--ps2 data 
);
end component; 
type rst      is (high, low);
signal state2           :rst;
    type statetype is (getter, printer);
    signal state       : statetype ;    
   signal reset       : std_logic := '0';
   signal txclk       : std_logic := '0';
   signal ld_tx_data  : std_logic := '0';
   signal tx_data     : std_logic_vector(7 downto 0) := (others => '0');
   signal tx_enable   : std_logic := '0';
   signal tx_out     : std_logic;
   signal tx_empty    : std_logic;
   
   signal rxclk       : std_logic := '0';
   signal uld_rx_data : std_logic := '0';
   signal rx_enable   : std_logic := '0';
   signal rx_in       : std_logic := '0';
   signal rx_empty    : std_logic;
   signal rx_data     : std_logic_vector(7 downto 0);
   signal prev         :std_logic;
   signal tmp         : std_logic; 
   signal en_cnt        :integer:=0; 
   signal pulseTemp    :std_logic;
   signal pulseTempPrev:std_logic;
   signal empty_prev    :std_logic;
   signal clk_cnt              :integer:=0;
   signal cnt_max              :integer:=250;
   signal clk_en               :std_logic; 
signal dummy    :std_logic;
begin
uut: uart
    port map (
        reset       => reset,
        txclk       => txclk,
        ld_tx_data  => ld_tx_data,
        tx_data     => tx_data,
        tx_enable   => tx_enable,
        
        tx_out      => tx_out,
        tx_empty    => tx_empty,
        
        rxclk       => rxclk,
        uld_rx_data => uld_rx_data,
        rx_enable   => rx_enable,
        rx_in       => rx_in,
        
        rx_empty    => rx_empty,
        rx_data     => rx_data
    );

pulseTemp <= utx_pulse;
    
tx_data<=utx_data;
reset<=ureset;
txclk<= utxclk;
--utx_out<=tx_out;
tx_enable<='1';
ld_tx_data<= pulseTemp;
clk_en_inst: process(clk)
	begin
	if rising_edge(clk) or falling_edge(clk)  then
		if clk_cnt = 260415 and ureset = '0'  then
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

if rising_edge(clk) then 
    pulseTempPrev<=pulseTemp;
end if;    

if clk_en='1' then 
empty_prev<=tx_empty;
end if; 
if rising_edge(clk) then 
    if clk_cnt = 260415 then 
        en_cnt<=en_cnt+1;
    elsif pulseTemp = '1' and pulseTempPrev ='0' then  
        en_cnt<=0; 
    end if;
end if;    
    
    if en_cnt=1 then 
        utx_out<=tx_out;
    else 
        utx_out<='1'; 
    end if;

end process;

--process(clk,pulseTemp)
--    begin   
--        if rising_edge(clk) then
--            pulseTempPrev <= pulseTemp;
--            if pulseTemp = '1' then 
--                tx_enable <= '1';  
           
--            else
--                tx_enable <= '0';
--            end if;
--uld_rx_data<='0';
--rx_enable<='1';
--rx_data<="00000000";
        
--        end if; 
--end process;


--process (clk)
--begin
--if rising_edge(clk) then 
--pulseTempPrev<=pulseTemp;

--case state2 is 

--when low => 
--    utx_out<=tx_out;
--   if tx_empty ='1' then 
--    state2<=high;
--   else 
--   state2<=low;
--   end if; 
    
    
--when high => 
--    utx_out<='1';
--   dummy<=tx_out;
--if pulseTemp='1' and pulseTempPrev='0' then 
--    state2<=low;
--end if; 

--when others => state2<=low;
--end case;

--end if; 
--end process; 
--process(clk)
--begin 
--if rising_edge(clk) then 

--    if reset = '1' then 
--        state<= getter; 
--    else
    
--        case state is 
        
--            when getter =>
            
--                tmp<=tx_out;
--                if tx_empty ='1' then 
--                    state<=printer;
--                else 
--                    state <=getter; 
--                end if; 
--            when printer => 
            
--                utx_out<=tmp;
--                if ld_tx_data ='1' then 
--                    state<= getter;
--                else
--                    state<= printer;
--                end if; 
                
--             when others=> null; 
--         end case;
--     end if; 
-- end if; 
--end process; 


--process(clk)
----begin 
----if ld_tx_data='1' then 
----    if tx_empty ='0' then
----        tx_enable<='1';
----    else
--        tx_enable<='0';
----    end if; 
----end if; 
--end process; 




end Behavioral;
