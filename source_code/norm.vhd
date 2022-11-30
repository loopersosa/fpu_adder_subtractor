
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- use ieee.std_logic_arith.all;

entity norm is
    Port ( fexp : in  STD_LOGIC_VECTOR (7 downto 0);
           sumsm : in  STD_LOGIC_VECTOR (28 downto 0);
           sub_norm : out  STD_LOGIC_VECTOR (28 downto 0);
			  fexp_norm : out std_logic_vector (7 downto 0));
end norm;

architecture Behavioral of norm is

signal hidden_bit : std_logic;
signal ex_bit : std_logic;
signal fexp_plus : std_logic_vector(7 downto 0);
signal fraction_shifted_left : std_logic_vector(28 downto 0);
signal fraction_shifted_right : std_logic_vector(28 downto 0);
signal fexp_minus : std_logic_vector (7 downto 0);
signal check_left_right : std_logic_vector (1 downto 0);
signal one : std_logic;
signal control_case : StD_LOGIC;
signal check_exponent : std_logic;
signal check : std_logic_vector (2 downto 0);

begin

--extracting hidden bit 
hidden_bit <= sumsm(23);

-- extracting the bit after hidden bit
ex_bit <= sumsm(24);

-- additional signals

-- exponent +1
fexp_plus <= std_logic_vector(unsigned(fexp) + 1);

-- exponent -1
fexp_minus <= std_logic_vector(unsigned(fexp) - 1);

-- fraction shifted to right
fraction_shifted_left <= std_logic_vector(shift_left(unsigned(sumsm), 1));

-- fraction shifted to left
fraction_shifted_right <= std_logic_vector(shift_right(unsigned(sumsm), 1));
 
-- case exp = 0b00...1 = 1
-- check if exponent is one in order not to shift any further
check_exponent <= not fexp(7) and not fexp(6) and not fexp(5) and not fexp(4) and not fexp(3) and not fexp(2) and not fexp(1) and fexp(0);

-- Creating a control mechanism for checking how to proceed with normalizing process
check <= hidden_bit & ex_bit & check_exponent;

-- Deciding whether fraction should be shifted to right or left or not to be shifted at all
with check select 
	sub_norm <= fraction_shifted_left when "000", 
					fraction_shifted_right when "010",  
					sumsm when "100",
					fraction_shifted_right when "110",
					sumsm when others;
	

-- Deciding if exponent should be incremented by one or decremented by one or remain unchanged based on check mechanism					
with check select
	fexp_norm <= fexp_minus when "000", 
					 fexp_plus when "010",  
					 fexp when "100",
					 fexp_plus when "110",
					 fexp when others;					 
				
end Behavioral;

 
