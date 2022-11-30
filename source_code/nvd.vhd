library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NVD is
    Port ( exp : in  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC);
end NVD;

architecture Behavioral of NVD is

begin

-- Checking whether Exponent is zero (determining if denormalized)
N <= exp(0) or exp(1) or exp(2) or exp(3) or exp(4) or exp(5) or exp(6) or exp(7);

end Behavioral;

