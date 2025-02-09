library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity statemachine is
  port (
    Clk      : in std_logic;
    reset    : in std_logic;
    CountVal : in std_logic_vector(7 downto 0);
    Keys     : in std_logic_vector(3 downto 0);
    stateOut : out std_logic_vector(3 downto 0)
  );
end statemachine;

architecture struct of statemachine is
  type State_type is (INIT, TEST, PAUSE, PWM);
  signal stateVAR : state_type;
  type freqType is (Hz60, Hz120, Hz1000);
  signal freqState    : freqType;
  signal prevCountVal : std_logic_vector(7 downto 0);
  signal state        : std_logic_vector(3 downto 0);

--procedure btn_pulse_procedure(
--		signal clk : in std_logic;
--		signal Btn : in std_logic;
--		signal btn_pulse: out std_logic;	
--		signal btncnt : out integer	
--		) is
----	constant CNTR_MAX : std_logic_vector(15 downto 0) := X"00FF";
----	variable btn_cntr   : std_logic_vector(15 downto 0) := (others => '0');
----	variable btn_sync: std_logic_vector(1 downto 0):= (others => '0');
----	variable btn_reg: std_logic:= '0';
--	variable cnt : integer range 0 to 255;
--	
--	begin
--	if (rising_edge(clk)) then
--		cnt := cnt + 1;
--	end if;
--	btncnt <= cnt;
----		if ((btn_reg = '1') xor (Btn = '1')) then
----			if (btn_cntr = CNTR_MAX) then
----				btn_cntr := (others => '0');
----			else
----				btn_cntr := btn_cntr + 1;
----			end if;
----		else
----			btn_cntr := (others => '0');
----		end if;
----		if (btn_cntr = CNTR_MAX) then
----			btn_reg := not(btn_reg);
----		end if;
----		btn_sync(0) := btn_reg;
----		btn_sync(1) := btn_sync(0);
----	end if;
----	if (btn_cntr = CNTR_MAX) then
----		btn_pulse <= '1';
----	else
----		btn_pulse <= '0';
----		btncnt <= btn_cntr;
----	end if;
--	
--	--	btn_pulse   <= (not btn_sync(1)) and btn_sync(0);	
--end procedure;
--
--
--function btn_pulse(btn_in : std_logic) return std_logic is
--	variable btn_sync: std_logic_vector(1 downto 0):= (others => '0');
--	variable btn_pulse: std_logic;
--	begin
--		btn_sync(0) := btn_in;
--		btn_sync(1) := btn_sync(0);
--		btn_pulse := (not btn_sync(1)) and btn_sync(0);	
--		return btn_pulse;
--end function;

begin	
   process (Clk, reset, Keys)
  begin
    if (reset = '1') then
      stateVAR <= INIT;
    elsif rising_edge(Clk) then
      case stateVAR is
        when INIT =>
          if keys(0) = '0' then
            if (prevCountVal = X"FF" and countVal = X"00") then
              stateVAR <= TEST;
            end if;
          end if;
          prevCountVal <= CountVal;
        when TEST =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif keys(1) = '1' then
					stateVAR <= PAUSE;
          elsif keys(2) = '1' then
            stateVAR <= PWM;
          end if;
        when PAUSE =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif keys(1) = '1' then
            stateVAR <= TEST;
          elsif keys(2) = '1' then
            stateVAR <= PWM;
          end if;
        when PWM =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif keys(2) = '1' then
            stateVAR <= TEST;
          elsif keys(3) = '1' then
            case freqState is
              when Hz60 =>
                freqState <= Hz120;
              when Hz120 =>
                freqState <= Hz1000;
              when Hz1000 =>
                freqState <= Hz60;
              when others =>
                freqState <= Hz60;
            end case;
          end if;
        when others => stateVAR <= INIT;
      end case;
    end if;
  end process;
  process (stateVar, freqState, state)
  begin
    case stateVAR is
      when INIT  => state              <= "0001"; -- In init mode, counter on
      when TEST  => state(3 downto 2)  <= "10"; -- In test mode
      when PAUSE => state(3 downto 2) <= "01"; -- In pause mode
      when PWM   =>
        state(3 downto 2) <= "11"; -- In PWM mode
        case freqState is
          when Hz60   => state(1 downto 0)   <= "00";
          when Hz120  => state(1 downto 0)  <= "10";
          when Hz1000 => state(1 downto 0) <= "11";
        end case;
    end case;

    stateOut <= state;
  end process;
end struct;