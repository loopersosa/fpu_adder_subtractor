library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity salu is
    Port ( exponent_1, exponent_2: in  STD_LOGIC_VECTOR (7 downto 0);
           difference : out  STD_LOGIC_VECTOR (7 downto 0);
           borrow : out  STD_LOGIC);
end salu;

architecture Behavioral of salu is

signal temp : STD_LOGIC_VECTOR(7 downto 0);

begin
	
	-- finding the difference between exponents
	temp <= std_logic_vector(unsigned(exponent_1) - unsigned(exponent_2));
	
	-- sign bit
	borrow <= temp(7);
	
	-- The difference
	difference <= temp;
	
end Behavioral;

