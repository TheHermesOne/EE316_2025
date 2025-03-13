LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;


entity Hangman is
PORT(
    clk       	: IN         STD_LOGIC;                    --system clock
    reset    	: IN         STD_LOGIC;
	 Word 		: IN 			String(1 to 16);
	 letter 		: IN 			character;
	 newLetterPulse: IN		std_LOGIC;
	 vwrongGuess: OUT	std_logic_vector(3 downto 0);
	 vGameOver	: OUT		std_LOGIC_vector(1 downto 0);
	 vRebuilt 	: out 		string(1 to 16)	 
	 );
end Hangman;

ARCHITECTURE logic OF Hangman IS


----------------------------------------------
-----------------Word Checker-----------------
----------------------------------------------
procedure CheckWordletter(
					signal word : in string(1 to 16);
					signal PrevRebuildOut: in string(1 to 16);
					signal letter: in character;
					signal output: out string(1 to 16);
					signal guesscount: inout integer range 0 to 5)is
			
			variable bLetterInWordTemp: std_LOGIC := '0';
			variable tempOut : string(1 to 16) := prevRebuildOut;		
			variable wordchecked :std_logic := '0';

	begin
		for currentIter in word'length downto 1 loop
			if letter = word(currentIter) then
				tempOut(currentIter) := letter;
				bletterInWordTemp := '1';
			elsif 'X' = word(currentIter) then
				tempOut(currentIter) := 'X';
			end if;
			if currentIter = word'length then
			     wordchecked := '1';
			end if;
		end loop;
        if bLetterInWordTemp = '0' and wordchecked = '1' then
            guesscount <= guesscount +1 ;
         end if;
	output <= tempOut;
end procedure;
-------------------------------------------------------

--------------------------------------------------
signal rebuildOut: String(1 TO 16):= "________________";
signal bLetterInWord: std_LOGIC := '1';
signal guesscount		:integer range 0 to 5;
signal wordChecked	:std_LOGIC := '0';
signal templetter 	: character ;
signal truth        : integer range 0 to 16;
signal bWordsmatch	: std_LOGIC;

begin
	process(reset,newLetterPulse,clk,rebuildOut)
		begin		
			if reset = '0' then		-- need to have a reset that does something
				rebuildOut <= "________________";
				guesscount <= 0;
			elsif(rising_edge(clk)) then
			    if(newLetterPulse = '1') then
				    CheckWordletter(word,rebuildOut,letter,rebuildOut,guesscount);
				end if;
			end if;
	vwrongGuess <= std_logic_vector( to_unsigned( guesscount, vwrongGuess'length));
	vRebuilt <= rebuildOut;
	end process;
	
	

--	process(guesscount,rebuildOut,truth)
--		begin
--			if guesscount > 5 then
--				vGameOver <= "10";	--Losing Condition
--				vrebuilt <= "GAME LOSEXXXXXXX";

--			elsif truth >= 16 then
--				vGameOver <= "01";	--Winning Condition
--				vrebuilt <= "GAME WINXXXXXXXX";
--			else
--				vGameOver <= "00";
--			end if;
--	end process;
	
	
end logic;