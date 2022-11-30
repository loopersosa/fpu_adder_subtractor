library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity round is
    Port ( sumsm_shifted : in  STD_LOGIC_VECTOR (28 downto 0);
           fexp_corrected : in  STD_LOGIC_VECTOR (7 downto 0);
           sumsm_sh_rounded : out  STD_LOGIC_VECTOR (28 downto 0);
           fexp_co : out  STD_LOGIC_VECTOR (7 downto 0));
end round;

architecture Behavioral of round is

signal G,R,S,Control_Case : STD_LOGIC;
signal sumsm_plus : STD_LOGIC_VECTOR(28 downto 0);

begin

-- no changes to exponent when rounding
fexp_co <= fexp_corrected;

-- extracting Sticky bits (S) , Round bit (R) , Guard Bit (G)
S <= sumsm_shifted(0) or sumsm_shifted(1) or  sumsm_shifted(2) or  sumsm_shifted(3);
R <= sumsm_shifted(4);
G <= sumsm_shifted(5);

-- A measure of when to add one to Guard for rounding
Control_Case <= (R and S) or (R and G);

-- Rounded by adding one to Guard (32 is equivalant to 100000 , adds one to guard bit)
sumsm_plus <= std_logic_vector(unsigned(sumsm_shifted) + 32);

-- Deciding whether to choose the rounded version or the sumsm itself
with Control_Case select
		sumsm_sh_rounded <= sumsm_shifted when '0',
								  sumsm_plus when '1';

end Behavioral;

