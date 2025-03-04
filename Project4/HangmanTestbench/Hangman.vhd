LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;


entity Hangman is
PORT(
    clk       	: IN         STD_LOGIC;                    --system clock
    reset    	: IN         STD_LOGIC;
	 word 		: IN 			String(1 to 16);
	 letter 		: IN 			character;
	 Result		: OUT 		STD_LOGIC_vector(7 downto 0);
	 wrongGuess : OUT			Std_LOGIC_vector(3 downto 0)
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
	
begin
	process(reset,clk)
		begin		
			if reset = '1' then
			elsif(rising_edge(clk)) then
				CheckWordletter(word,letter,ChkOut,bLetterInWord);
				if bLetterInWord = '1' then
					RebuildWord(ChkOut,rebuildOut,letter,rebuildOut);
				else
					guesscount <= guesscount +1;
				end if;
			end if;
	wrongGuess <= guesscount;
	Result <= ChkOut(7 downto 0);
	end process;
end logic;