library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	

entity CHBF is
    Port ( N : in  STD_LOGIC;
           Fraction : in  STD_LOGIC_VECTOR (22 downto 0);
           Operand : out  STD_LOGIC_VECTOR (23 downto 0));
end CHBF;

architecture Behavioral of CHBF is

signal fraction_zero : STD_LOGIC_VECTOR(23 downto 0);

begin

-- Resizing fraction before concatenation with hidden bit
fraction_zero <= '0' & Fraction;

-- concatenating the hidden bit to fraction
Operand <= (N & "00000000000000000000000") or fraction_zero;

end Behavioral;
