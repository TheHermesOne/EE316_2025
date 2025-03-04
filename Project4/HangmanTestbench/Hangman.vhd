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
	 vResult		: OUT 		STD_LOGIC_vector(7 downto 0);
	 vwrongGuess: OUT			Std_LOGIC_vector(3 downto 0);
	 vGameOver	: OUT			std_LOGIC_vector(1 downto 0)			
	 );
end Hangman;

ARCHITECTURE logic OF Hangman IS


----------------------------------------------
-----------------Word Checker-----------------
----------------------------------------------
procedure CheckWordletter(
					signal word : in string(1 to 16);
					signal letter: in character;
					signal output: out std_logic_vector(15 downto 0);
					signal bLetterInWord: out std_LOGIC)is
			
			variable bLetterInWordTemp: std_LOGIC := '0';
			variable letterCount: integer range 0 to 16 := 0;
	
	begin
		for currentIter in word'length downto 1 loop
			if letter = word(currentIter) then
				output(currentIter-1) <= '1';
				bletterInWord <= '1';
			elsif 'X' = word(currentIter) then
				output(currentIter-1) <= 'X';
			else
				output(currentIter-1) <= '0'; 
			end if;
		end loop;
	bLetterInWord <= bLetterInWordTemp;
end procedure;

---------------------------------------------

procedure RebuildWord(
				signal checkWordOut : in std_LOGIC_vector(15 downto 0);
				signal PrevRebuildOut: in string(16 downto 1);
				signal letter : in character;
				signal RebuildOut: out String(16 downto 1))is
		
		variable tempOut : string(16 downto 1) := prevRebuildOut;		
		variable letterCount: integer range 0 to 16 := 0;
	
	begin
		for currentIter in checkWordOut'range loop
			if checkWordOut(currentIter) = '1'  then
				tempOut(currentIter+1) := letter;
			elsif 'X' = checkWordOut(currentIter) then
				tempOut(currentIter+1) := 'X';
			else
				tempOut(currentIter+1) := '0'; 
			end if;
		end loop;
	RebuildOut <= tempOut;
end procedure;
----------------------------------------------


signal ChkOut: std_LOGIC_vector(15 downto 0);
signal rebuildOut: String(16 downto 1):= "0000000000000000";
signal bLetterInWord: std_LOGIC;
signal guesscount		:std_LOGIC_vector(3 downto 0);
signal tempLetter		:character := letter;

	
begin
	process(reset,clk)
		begin		
			if reset = '0' then		-- need to have a reset that does something
				rebuildOut <= "0000000000000000";
			elsif(rising_edge(clk)) then
				CheckWordletter(word,templetter,ChkOut,bLetterInWord);
				if bLetterInWord = '1' then
					RebuildWord(ChkOut,rebuildOut,templetter,rebuildOut);
				else
					guesscount <= guesscount +1;
				end if;
			end if;
	vwrongGuess <= guesscount;
	vResult <= ChkOut(7 downto 0);
	end process;
	
	process(guesscount,rebuildOut)
		begin
			if guesscount > 5 then
				vGameOver <= "10";	--Losing Condition
			elsif (word = rebuildOut) then
				vGameOver <= "01";	--Winning Condition
			end if;
	end process;
end logic;