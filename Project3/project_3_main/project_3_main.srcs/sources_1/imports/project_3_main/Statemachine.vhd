library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity statemachine is
  port (
    Clk      : in std_logic;
    reset    : in std_logic;
    Keys1      : in std_logic;
    Keys2      : in std_logic;
    stateOut : out std_logic_vector(3 downto 0)
  );
end statemachine;

architecture struct of statemachine is
  type State_type is (ClkGenEn,ClkGenDis);
  signal stateVAR : state_type;
  type ADCSource is (LDR, TEMP,AIN2, POT);
  signal ADCState    : ADCSource;
  signal state        : std_logic_vector(3 downto 0);

begin	
   process (Clk, reset, Keys1,Keys2)
  begin
    if (reset = '1') then
      stateVAR <= ClkGenDis;
      ADCState <= LDR;
    elsif rising_edge(Clk) then
        if keys2 = '1' then
          case stateVAR is
                when ClkGenDis =>
                        stateVAR <= ClkGenEn;
                when ClkGenEn => 
                    stateVar <= ClkGenDis;
            when others => stateVAR <= ClkGenDis;
          end case;
        elsif keys1 = '1' then
          case ADCState is
            when LDR => 
                ADCState <= TEMP;
            when TEMP =>
                ADCState <= AIN2;
            when AIN2 =>
                ADCState <= POT;
            when POT =>
                ADCState <= LDR;
            end case;
          end if;
    end if;
  end process;
  
  
  
  process (stateVar)
  begin
    case stateVAR is
      when ClkGenDis  => state(3 downto 2) <= "00"; -- In init mode, counter on
      when ClkGenEn  => state(3 downto 2)  <= "01"; -- In test mode
      end case;
          stateOut <= state;
 end process;

process(ADCState)
begin
     case ADCState is
          when LDR   => state(1 downto 0)   <= "00";
          when TEMP  => state(1 downto 0)  <= "01";
          when AIN2 => state(1 downto 0) <= "10";
          when POT => state(1 downto 0) <= "11";
    end case;
        stateOut <= state;
end process;


end struct;