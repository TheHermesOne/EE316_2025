library IEEE;
use IEEE.STD_LOGIC_1164.all;

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
begin
  process (Clk, reset)
  begin
    if (reset = '1') then
      stateVAR <= INIT;
    elsif rising_edge(Clk) then
      case stateVAR is
        when INIT =>
          if keys(0) /= '1' then
            if (prevCountVal = X"FF" and countVal = X"00") then
              stateVAR <= TEST;
            end if;
          end if;
        when TEST =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif Keys(1) = '1' then
            stateVAR <= PAUSE;
          elsif Keys(2) = '1' then
            stateVAR <= PWM;
          end if;
        when PAUSE =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif Keys(1) = '1' then
            stateVAR <= TEST;
          elsif Keys(2) = '1' then
            stateVAR <= PWM;
          end if;
        when PWM =>
          if Keys(0) = '1' then
            stateVAR <= INIT;
          elsif Keys(2) = '1' then
            stateVAR <= TEST;
          elsif Keys(3) = '1' then
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