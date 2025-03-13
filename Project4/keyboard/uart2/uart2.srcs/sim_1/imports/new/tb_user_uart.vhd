-------------------------------------------------------
-- Testbench for UART
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_user_uart is
end tb_user_uart;

architecture sim of tb_user_uart is

    -- Signal declaration
      signal   utx_data     : std_logic_vector (7 downto 0);--ps2 data 
        signal ureset       : std_logic:='0';
        signal utxclk       : std_logic;-- baud rate 
        signal utx_pulse    : std_logic;
        signal utx_out      :std_logic;
  SIGNAL clk              : std_logic;
   component user_logic_uart2 is 
   port(
        clk          :in std_logic; 
        utx_data     :in  std_logic_vector (7 downto 0);--ps2 data 
        ureset       :in  std_logic;
        utxclk       :in  std_logic;-- baud rate 
        utx_pulse    :in  std_logic;
        utx_out      :out std_logic);
   end component;
   
begin

    -- Instantiate the UART component
    uut: user_logic_uart2
    PORT MAP(
utx_data=> utx_data ,
ureset=>ureset  ,   
utxclk=> utxclk ,
utx_pulse=> utx_pulse ,
utx_out=>utx_out,
clk=>clK
    
    );

    -- Clock generation for txclk and rxclk
    txclk_process :process
    begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;

   
process
begin 
wait for 400 ns; 

--wait for 20 ns;
--ureset<='1';
--wait for 20 ns;
--ureset <='0';
--wait for 20 ns; 
--utx_pulse<='0';
--wait for 20 ns;
--utx_pulse<='1';
--wait for 20 ns;
--utx_pulse<='0';
--wait for 20 ns; 
utx_data<="10101010";

--wait for 400 ns;

--wait for 400 ns; 
--utx_pulse<='0';
--wait for 20 ns;
--utx_pulse<='1';
--wait for 20 ns;
--utx_pulse<='0';
--wait for 20 ns; 
--utx_data<="10000000";
--      wait for 400 ns;
  
        
    end process;

end architecture;

