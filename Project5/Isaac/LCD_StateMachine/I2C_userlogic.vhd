library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity I2C_user_logic is							-- Modified from SPI usr logic from last year
    Port ( iclk         : in STD_LOGIC;
          -- dataIn       : in STD_LOGIC_VECTOR (15 downto 0);
           oSDA         : inout STD_LOGIC;
           input1       : in     std_logic_vector(127 downto 0);
           input2       : in     std_logic_vector(127 downto 0);
           oSCL         : inout STD_LOGIC);
end I2C_user_logic;

architecture Behavioral of I2C_user_logic is

------------------------------------------------------------------------------------------------------------------
component i2c_manager IS
  GENERIC(
    input_clk : INTEGER := 125_000_000; --input clock speed from user logic in Hz
    bus_clk   : INTEGER := 100_000);   --speed the i2c bus (scl) will run at in Hz (7-Segment can run from 100khz(slow mode) to 400khz(high speed mode))
  PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    reset_n   : IN     STD_LOGIC;                    --active low reset
    ena       : IN     STD_LOGIC;                    --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
    
END component i2c_manager;
------------------------------------------------------------------------------------------------------------------
signal regBusy,sigBusy,reset,enable,rw_sig : std_logic;

--signal wData : std_logic_vector(15 downto 0);
signal prevdata: std_logic_vector(127 downto 0);

signal prevdata1: std_logic_vector(127 downto 0);

signal dataOut : std_logic_vector(7 downto 0);

signal byteSel : integer range 0 to 181 := 0;

type state_type is (start,write,stop);

signal State : state_type := start;

signal address : std_logic_vector(6 downto 0);

signal Counter      : integer := 16383;		--187497 orig 
--signal input1       :    std_logic_vector(127 downto 0) := x"31323132313231323132313231323132";

--signal input2       :    std_logic_vector(127 downto 0) := x"31323132313231323132313231323132";

begin
------------------------------------------------------------------------------------------------------------------
INST_i2c_manager: i2c_manager
	Generic map(input_clk => 125_000_000,bus_clk=> 50_000) --9600 orig
	port map (
		clk=>iclk,
		reset_n=>reset,
		ena=>enable,
		addr=>address,						-- For implementation of 2 or more components, link address to a mux to select which component.
		rw=>rw_sig,
		data_wr=>dataOut,
		busy=>sigBusy,
		data_rd=>OPEN,
		ack_error=>open,				
		sda=>oSDA,
		scl=>oSCL
		);
	
------------------------------------------------------------------------------------------------------------------
StateChange: process (iClk)
begin
	if rising_edge(iClk) then
		case State is
		
			when start =>
				if Counter /= 0 then
					Counter<=Counter-1;
					reset<='0';
					State<=start;
					enable<='0';
				else
					reset<='1';					-- Sent to I2C master to start ready transaction
					enable<='1';				-- Sent to I2C master to transition to start state.
					
					address <="0100111";		-- Hardcoded to X"27", LCD default address
					rw_sig<='0';				-- Only writing in this project
					State<=write;
				end if;
			
			when write=>
				regBusy <= sigBusy;
			--	wData <= dataIn;
				prevdata <= input1;
				prevdata1 <= input2;
				
				if regBusy /= sigBusy and sigBusy = '0' then
					if byteSel /= 180 then
						byteSel <= byteSel+1;
						State <= write;
					else
						byteSel <= 45;
						State<=stop;
					end if;
				end if;
			when stop=>
				enable<='0';
				if prevdata /= input1 or prevdata1 /= input2 then
		--		if wData/=dataIn then	-- Halts transaction at slv_ack2 state until new iData comes in
					State<=start;
				else
					State<=stop;
				end if;
			end case;
	end if;
end process;
------------------------------------------------------------------------------------------------------------------
process(byteSel, input1, input2)
begin
    case byteSel is
         when 0  => dataOut <= X"38"; -- 1
         when 1  => dataOut <= X"3C";
         when 2  => dataOut <= X"38";
         when 3  => dataOut <= X"8C";
         when 4  => dataOut <= X"88";

         when 5  => dataOut <= X"3C"; -- 2
         when 6  => dataOut <= X"38";
         when 7  => dataOut <= X"8C";
         when 8  => dataOut <= X"88";

         when 9  => dataOut <= X"3C"; -- 3
         when 10 => dataOut <= X"38";
         when 11 => dataOut <= X"8C";
         when 12 => dataOut <= X"88";

         when 13 => dataOut <= X"3C"; -- 4
         when 14 => dataOut <= X"38";
         when 15 => dataOut <= X"8C";
         when 16 => dataOut <= X"88";

         when 17 => dataOut <= X"3C"; -- 5
         when 18 => dataOut <= X"38";
         when 19 => dataOut <= X"8C";
         when 20 => dataOut <= X"88";

         when 21 => dataOut <= X"3C"; -- 6
         when 22 => dataOut <= X"38";
         when 23 => dataOut <= X"8C";
         when 24 => dataOut <= X"88";

         when 25 => dataOut <= X"0C"; -- 4-bit
         when 26 => dataOut <= X"08";
         when 27 => dataOut <= X"2C";
         when 28 => dataOut <= X"28";

         when 29 => dataOut <= X"2C"; 
         when 30 => dataOut <= X"28";
         when 31 => dataOut <= X"8C";
         when 32 => dataOut <= X"88";

         when 33 => dataOut <= X"0C"; -- clear
         when 34 => dataOut <= X"08";
         when 35 => dataOut <= X"1C";
         when 36 => dataOut <= X"18";

         when 37 => dataOut <= X"0C";  
         when 38 => dataOut <= X"08";
         when 39 => dataOut <= X"CC";
         when 40 => dataOut <= X"C8";

         when 41 => dataOut <= X"0C";  
         when 42 => dataOut <= X"08";
         when 43 => dataOut <= X"6C";
         when 44 => dataOut <= X"68";

         when 45 => dataOut <= X"8C";  
         when 46 => dataOut <= X"88";
         when 47 => dataOut <= X"0C";
         when 48 => dataOut <= X"08";      
       -- now tell it what to say
           
      when 49  => dataOut <= input1(127 downto 124) & X"D"; -- 1
    when 50  => dataOut <= input1(127 downto 124) & X"9";
    when 51  => dataOut <= input1(123 downto 120) & X"D";
    when 52  => dataOut <= input1(123 downto 120) & X"9";

    when 53  => dataOut <= input1(119 downto 116) & X"D"; -- 2
    when 54  => dataOut <= input1(119 downto 116) & X"9";
    when 55  => dataOut <= input1(115 downto 112) & X"D";
    when 56  => dataOut <= input1(115 downto 112) & X"9";

    when 57  => dataOut <= input1(111 downto 108) & X"D"; -- 3
    when 58  => dataOut <= input1(111 downto 108) & X"9";
    when 59  => dataOut <= input1(107 downto 104) & X"D";
    when 60  => dataOut <= input1(107 downto 104) & X"9";

    when 61  => dataOut <= input1(103 downto 100) & X"D"; -- 4
    when 62  => dataOut <= input1(103 downto 100) & X"9";
    when 63  => dataOut <= input1(99 downto 96) & X"D";
    when 64  => dataOut <= input1(99 downto 96) & X"9";

    when 65  => dataOut <= input1(95 downto 92) & X"D"; -- 5
    when 66  => dataOut <= input1(95 downto 92) & X"9";
    when 67  => dataOut <= input1(91 downto 88) & X"D";
    when 68  => dataOut <= input1(91 downto 88) & X"9";

    when 69  => dataOut <= input1(87 downto 84) & X"D"; -- 6
    when 70  => dataOut <= input1(87 downto 84) & X"9";
    when 71  => dataOut <= input1(83 downto 80) & X"D";
    when 72  => dataOut <= input1(83 downto 80) & X"9";

    when 73  => dataOut <= input1(79 downto 76) & X"D"; -- 7
    when 74  => dataOut <= input1(79 downto 76) & X"9";
    when 75  => dataOut <= input1(75 downto 72) & X"D";
    when 76  => dataOut <= input1(75 downto 72) & X"9";

    when 77  => dataOut <= input1(71 downto 68) & X"D"; -- 8
    when 78  => dataOut <= input1(71 downto 68) & X"9";
    when 79  => dataOut <= input1(67 downto 64) & X"D";
    when 80  => dataOut <= input1(67 downto 64) & X"9";

    when 81  => dataOut <= input1(63 downto 60) & X"D"; -- 9
    when 82  => dataOut <= input1(63 downto 60) & X"9";
    when 83  => dataOut <= input1(59 downto 56) & X"D";
    when 84  => dataOut <= input1(59 downto 56) & X"9";

    when 85  => dataOut <= input1(55 downto 52) & X"D"; -- 10
    when 86  => dataOut <= input1(55 downto 52) & X"9";
    when 87  => dataOut <= input1(51 downto 48) & X"D";
    when 88  => dataOut <= input1(51 downto 48) & X"9";

        when 89  => dataOut <= input1(47 downto 44) & X"D"; -- 11
    when 90  => dataOut <= input1(47 downto 44) & X"9";
    when 91  => dataOut <= input1(43 downto 40) & X"D";
    when 92  => dataOut <= input1(43 downto 40) & X"9";

    when 93  => dataOut <= input1(39 downto 36) & X"D"; -- 12
    when 94  => dataOut <= input1(39 downto 36) & X"9";
    when 95  => dataOut <= input1(35 downto 32) & X"D";
    when 96  => dataOut <= input1(35 downto 32) & X"9";

    when 97  => dataOut <= input1(31 downto 28) & X"D"; -- 13
    when 98  => dataOut <= input1(31 downto 28) & X"9";
    when 99  => dataOut <= input1(27 downto 24) & X"D";
    when 100 => dataOut <= input1(27 downto 24) & X"9";

    when 101 => dataOut <= input1(23 downto 20) & X"D"; -- 14
    when 102 => dataOut <= input1(23 downto 20) & X"9";
    when 103 => dataOut <= input1(19 downto 16) & X"D";
    when 104 => dataOut <= input1(19 downto 16) & X"9";

    when 105 => dataOut <= input1(15 downto 12) & X"D"; -- 15
    when 106 => dataOut <= input1(15 downto 12) & X"9";
    when 107 => dataOut <= input1(11 downto 8) & X"D";
    when 108 => dataOut <= input1(11 downto 8) & X"9";

    when 109 => dataOut <= input1(7 downto 4) & X"D"; -- 16
    when 110 => dataOut <= input1(7 downto 4) & X"9";
    when 111 => dataOut <= input1(3 downto 0) & X"D";
    when 112 => dataOut <= input1(3 downto 0) & X"9";

    -- Second line select
    when 113 => dataOut <= X"CC"; 
    when 114 => dataOut <= X"C8";
    when 115 => dataOut <= X"0C";
    when 116 => dataOut <= X"08";

    when 117 => dataOut <= input2(127 downto 124) & X"D"; -- 1
    when 118 => dataOut <= input2(127 downto 124) & X"9";
    when 119 => dataOut <= input2(123 downto 120) & X"D";
    when 120 => dataOut <= input2(123 downto 120) & X"9";

    when 121 => dataOut <= input2(119 downto 116) & X"D"; -- 2
    when 122 => dataOut <= input2(119 downto 116) & X"9";
    when 123 => dataOut <= input2(115 downto 112) & X"D";
    when 124 => dataOut <= input2(115 downto 112) & X"9";

    when 125 => dataOut <= input2(111 downto 108) & X"D"; -- 3
    when 126 => dataOut <= input2(111 downto 108) & X"9";
    when 127 => dataOut <= input2(107 downto 104) & X"D";
    when 128 => dataOut <= input2(107 downto 104) & X"9";

    when 129 => dataOut <= input2(103 downto 100) & X"D"; -- 4
    when 130 => dataOut <= input2(103 downto 100) & X"9";
    when 131 => dataOut <= input2(99 downto 96) & X"D";
    when 132 => dataOut <= input2(99 downto 96) & X"9";

        when 133 => dataOut <= input2(95 downto 92) & X"D"; -- 5
    when 134 => dataOut <= input2(95 downto 92) & X"9";
    when 135 => dataOut <= input2(91 downto 88) & X"D";
    when 136 => dataOut <= input2(91 downto 88) & X"9";

    when 137 => dataOut <= input2(87 downto 84) & X"D"; -- 6
    when 138 => dataOut <= input2(87 downto 84) & X"9";
    when 139 => dataOut <= input2(83 downto 80) & X"D";
    when 140 => dataOut <= input2(83 downto 80) & X"9";

    when 141 => dataOut <= input2(79 downto 76) & X"D"; -- 7
    when 142 => dataOut <= input2(79 downto 76) & X"9";
    when 143 => dataOut <= input2(75 downto 72) & X"D";
    when 144 => dataOut <= input2(75 downto 72) & X"9";

    when 145 => dataOut <= input2(71 downto 68) & X"D"; -- 8
    when 146 => dataOut <= input2(71 downto 68) & X"9";
    when 147 => dataOut <= input2(67 downto 64) & X"D";
    when 148 => dataOut <= input2(67 downto 64) & X"9";

    when 149 => dataOut <= input2(63 downto 60) & X"D"; -- 9
    when 150 => dataOut <= input2(63 downto 60) & X"9";
    when 151 => dataOut <= input2(59 downto 56) & X"D";
    when 152 => dataOut <= input2(59 downto 56) & X"9";

    when 153 => dataOut <= input2(55 downto 52) & X"D"; -- 10
    when 154 => dataOut <= input2(55 downto 52) & X"9";
    when 155 => dataOut <= input2(51 downto 48) & X"D";
    when 156 => dataOut <= input2(51 downto 48) & X"9";

    when 157 => dataOut <= input2(47 downto 44) & X"D"; -- 11
    when 158 => dataOut <= input2(47 downto 44) & X"9";
    when 159 => dataOut <= input2(43 downto 40) & X"D";
    when 160 => dataOut <= input2(43 downto 40) & X"9";

    when 161 => dataOut <= input2(39 downto 36) & X"D"; -- 12
    when 162 => dataOut <= input2(39 downto 36) & X"9";
    when 163 => dataOut <= input2(35 downto 32) & X"D";
    when 164 => dataOut <= input2(35 downto 32) & X"9";

    when 165 => dataOut <= input2(31 downto 28) & X"D"; -- 13
    when 166 => dataOut <= input2(31 downto 28) & X"9";
    when 167 => dataOut <= input2(27 downto 24) & X"D";
    when 168 => dataOut <= input2(27 downto 24) & X"9";

    when 169 => dataOut <= input2(23 downto 20) & X"D"; -- 14
    when 170 => dataOut <= input2(23 downto 20) & X"9";
    when 171 => dataOut <= input2(19 downto 16) & X"D";
    when 172 => dataOut <= input2(19 downto 16) & X"9";

    when 173 => dataOut <= input2(15 downto 12) & X"D"; -- 15
    when 174 => dataOut <= input2(15 downto 12) & X"9";
    when 175 => dataOut <= input2(11 downto 8) & X"D";
    when 176 => dataOut <= input2(11 downto 8) & X"9";

    when 177 => dataOut <= input2(7 downto 4) & X"D"; -- 16
    when 178 => dataOut <= input2(7 downto 4) & X"9";
    when 179 => dataOut <= input2(3 downto 0) & X"D";
    when 180 => dataOut <= input2(3 downto 0) & X"9";

    when others => dataOut <= X"00"; -- Default case

------------------------------------------------------------------------------------------------------------------

end case;
end process; 

end Behavioral;

