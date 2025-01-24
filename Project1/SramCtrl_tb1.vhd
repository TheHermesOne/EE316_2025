-- Testbench for SRAM_Controller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SramCtrl_tb is
end SramCtrl_tb;

architecture Behavioral of SramCtrl_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component SRAM_Controller
	port(
		clk,reset					: in std_logic; 							-- Set up for 100Mhz clock
		mem							: in std_logic; 							-- when '1' SRAM_Controller is going to be used
		rw								: in std_logic; 							-- read write bit. '1' for read, '0' for write
		addr							: in std_logic_vector(19 downto 0);	-- Address input
		data_f2s						: in std_logic_vector(7 downto 0);	-- Data input to SRAM_Controller
		ready							: out std_logic; 							-- Status signal indcating Controller is ready for input?
		data_s2f_r, data_s2f_ur	: out std_logic_vector(7 downto 0);	-- Data (registered, unregistered) from SRAM_Controller
		ad								: out std_logic_vector(19 downto 0); --address output during read; goes to SRAM
		we_n, oe_n					: out std_logic; 							--Write enable , output enable outputs to the SRAM
		dio							: inout std_logic_vector(7 downto 0);--Data input/output that goes to the SRAM
		ce_n							: out std_logic 							--Chip enable output; goes to SRAM 
	);
    end component;

    -- Signal declarations
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
	 signal mem : std_logic;
	 signal rw : std_LOGIC;
    signal addr : STD_LOGIC_VECTOR(19 downto 0);
	 signal data_f2s : std_LOGIC_VECTOR(7 downto 0);
	 signal ready : std_LOGIC;
    signal data_s2f_r : std_LOGIC_VECTOR(7 downto 0);
	 signal data_s2f_ur : std_LOGIC_VECTOR(7 downto 0);
	 signal ad : std_LOGIC_vector(19 downto 0);
    signal we_n : STD_LOGIC;
    signal oe_n : STD_LOGIC;
	 signal dio : std_LOGIC_vector(7 downto 0);
    signal ce_n : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: SRAM_Controller
        Port map (
            clk => clk,
            reset => reset,
				mem => mem,
				rw => rw,
            addr => addr,
				data_f2s => data_f2s,
				ready => ready,
				data_s2f_r => data_s2f_r,
				data_s2f_ur => data_s2f_ur,
				ad => ad,
            we_n => we_n,
            oe_n => oe_n,
				dio => dio,
            ce_n => ce_n
        );
		
		clk <= not clk after 10 ns;


  process
    begin
        -- Write operation
        addr <= x"00001";
        data_f2s <= x"AB";
        we_n <= '1';
        ce_n <= '1';
        wait for 100ns;
        we_n <= '0';
        ce_n <= '0';
        
        -- Read operation
        addr <= x"00001";
        oe_n <= '1';
        ce_n <= '1';
        wait for 100ns;
        oe_n <= '0';
        ce_n <= '0';
        
        -- End simulation
        wait;
    end process;

end Behavioral;
