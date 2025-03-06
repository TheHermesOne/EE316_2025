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
	 vResult		: OUT 		STD_LOGIC_vector(7 downto 0);
	 iwrongGuess: OUT			integer range 0 to 5;
	 vGameOver	: OUT			std_LOGIC_vector(1 downto 0);
	 vRebuilt 	: out 		character	 
	 );
end Hangman;

ARCHITECTURE logic OF Hangman IS


----------------------------------------------
-----------------Word Checker-----------------
----------------------------------------------
procedure CheckWordletter(
					signal word : in string(1 to 16);
					signal letter: in character;
					signal output: out string(1 to 16);
					signal bLetterInWord: out std_LOGIC;
					signal wordChecked: out std_LOGIC)is
			
			variable bLetterInWordTemp: std_LOGIC := '0';
			variable letterCount: integer range 0 to 16 := 0;
	
	begin
		for currentIter in word'length downto 1 loop
			if letter = word(currentIter) then
				output(currentIter) <= '1';
				bletterInWordTemp := '1';
			elsif 'X' = word(currentIter) then
				output(currentIter) <= 'X';
			else
				output(currentIter) <= '0'; 
			end if;
		end loop;
	bLetterInWord <= bLetterInWordTemp;
	wordChecked <= '1';
end procedure;


----------------------------------------------
-----------------Rebuid word-----------------
----------------------------------------------
procedure RebuildWord(
				signal checkWordOut : in string(1 to 16);
				signal PrevRebuildOut: in string(1 to 16);
				signal letter : in character;
				signal RebuildOut: out String(1 to 16))is
		
		variable tempOut : string(1 to 16) := prevRebuildOut;		
		variable letterCount: integer range 0 to 16 := 0;
	
	begin
		for currentIter in checkWordOut'range loop
			if checkWordOut(currentIter) = '1'  then
				tempOut(currentIter) := letter;
			elsif 'X' = checkWordOut(currentIter) then
				tempOut(currentIter) := 'X';
			end if;
		end loop;
	RebuildOut <= tempOut;
end procedure;
----------------------------------------------

function CompareString(
	OrgWord : string;
	NewWord : string) return boolean is
		variable truth : integer range 1 to 16;
	begin
	for i in 1 to 16 loop
		if OrgWord(i) = NewWord(i) then
			truth := truth+1;
		end if;
	end loop;
	if (truth = 16) then
		return true;
	else 
		return false;
	end if;
end function;

signal ChkOut: string(1 to 16);
signal rebuildOut: String(1 TO 16):= "0000000000000000";
signal bLetterInWord: std_LOGIC := '1';
signal guesscount		:integer range 0 to 5;
signal tempLetter		:character := letter;
signal wordChecked	:std_LOGIC := '0';

--process(word)
--	begin
--		for ii in Word'range loop
--			if word(ii) = 'X' then
--				rebuildOut(ii) <= 'X';
--			end if;
--		end loop;
--end process;

begin
	process(reset,newLetterPulse,clk)
		begin		
			if reset = '0' then		-- need to have a reset that does something
				rebuildOut <= "0000000000000000";
				guesscount <= 0;
			elsif(newLetterPulse = '1') then
				CheckWordletter(word,templetter,ChkOut,bLetterInWord,wordChecked);
			elsif(rising_edge(clk)) then
				if bLetterInWord = '1' and wordChecked = '1' then
					RebuildWord(ChkOut,rebuildOut,templetter,rebuildOut);
					bletterInWord <= '0';
					wordChecked <= '0';
				elsif bLetterInWord = '0' and wordChecked = '1' then
					guesscount <= guesscount +1;
					wordChecked <= '0';
				end if;
			end if;
	iwrongGuess <= guesscount;
--	vResult <= ChkOut(7 downto 0);
	vRebuilt <= rebuildOut(16);
	end process;
	
	process(guesscount,rebuildOut)
		begin
			if guesscount > 5 then
				vGameOver <= "10";	--Losing Condition
			elsif compareString(word,rebuildOut) then
				vGameOver <= "01";	--Winning Condition
			else
				vGameOver <= "00";
			end if;
	end process;
	
	
end logic;