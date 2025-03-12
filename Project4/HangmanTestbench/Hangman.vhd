LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;


entity Hangman is
PORT(
    clk       	: IN         STD_LOGIC;                    --system clock
    reset    	: IN         STD_LOGIC;
	 Word 		: IN 			String(1 to 16);
	 letter 		: IN 			character:='*';
	 newLetterPulse: IN		std_LOGIC;
	 iwrongGuess: OUT			integer range 0 to 5;
	 vGameOver	: OUT			std_LOGIC_vector(1 downto 0);
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
					signal bLetterInWord: out std_LOGIC;
					signal wordChecked: out std_LOGIC)is
			
			variable bLetterInWordTemp: std_LOGIC := '0';
			variable tempOut : string(1 to 16) := prevRebuildOut;		

	begin
		for currentIter in word'length downto 1 loop
			if letter = word(currentIter) then
				tempOut(currentIter) := letter;
				bletterInWordTemp := '1';
			elsif 'X' = word(currentIter) then
				tempOut(currentIter) := 'X';
--			else
--				tempOut(currentIter) := '_'; 
			end if;
		end loop;
	bLetterInWord <= bLetterInWordTemp;
	wordChecked <= '1';
	output <= tempOut;
end procedure;
-------------------------------------------------------

--------------------------------------------------
signal rebuildOut: String(1 TO 16):= "0000000000000000";
signal bLetterInWord: std_LOGIC := '1';
signal guesscount		:integer range 0 to 5;
signal wordChecked	:std_LOGIC := '0';
signal templetter 	: character := '*';
signal truth			: integer  range 1 to 16:=1;
signal bWordsmatch	: std_LOGIC;

begin
	process(reset,newLetterPulse,clk,rebuildOut)
		begin		
			if reset = '0' then		-- need to have a reset that does something
				rebuildOut <= "0000000000000000";
				guesscount <= 0;
			elsif(newLetterPulse = '1') then
				CheckWordletter(word,rebuildOut,letter,rebuildOut,bLetterInWord,wordChecked);
--				if bletterInWord = '1' then
--					if truth < 16 then
--						truth <= truth + 1;
--					else
--						truth <= 1;
--					end if;
--				end if;
			elsif(rising_edge(clk)) then
				if bLetterInWord = '0' and wordChecked = '1' then
					guesscount <= guesscount +1;
					wordChecked <= '0';
				end if;
			end if;
	iwrongGuess <= guesscount;
	end process;
	
	

	process(guesscount,rebuildOut,truth)
		begin
			if guesscount > 5 then
				vGameOver <= "10";	--Losing Condition
				vrebuilt <= "GAME LOSEXXXXXXX";

			elsif truth >= 16 then
				vGameOver <= "01";	--Winning Condition
				vrebuilt <= "GAME WINXXXXXXXX";
			else
				vRebuilt <= rebuildOut;
				vGameOver <= "00";
			end if;
	end process;
	
	
end logic;