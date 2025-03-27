----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2025 03:53:40 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
port (
		iCLK					: in std_logic; 
		A						: in std_logic; 
		B		 				: in std_logic;
		oSDA                    : inout STD_LOGIC;
        oSCL                    : inout STD_LOGIC
		); 
end top_level;

architecture Behavioral of top_level is

signal sig_count_out : std_logic_vector(7 downto 0);

component i2c_userlogic7seg is							-- Modified from SPI usr logic from last year
    Port ( iclk     : in STD_LOGIC;
           dataIn   : in STD_LOGIC_VECTOR (7 downto 0);
           oSDA     : inout STD_LOGIC;
           oSCL     : inout STD_LOGIC);
end component;

component rotary is
		generic(N: integer := 8; N2: integer := 255; N1: integer := 0);
		port (
		iCLK					: in std_logic; 
		A						: in std_logic; -- A value
		B		 				: in std_logic; -- B value
		count_out				: out std_logic_vector(N-1 downto 0)
		);
end component;


begin

inst_7seg: i2c_userlogic7seg
port map (
    iclk    => iclk,
    dataIn  => sig_count_out,
    oSDA    => oSDA,
    oSCL    => oSCL
);

inst_rotary: rotary
port map (
    iclk        => iclk,
    A           => A,
    B           => B,
    count_out   => sig_count_out
);


end Behavioral;
