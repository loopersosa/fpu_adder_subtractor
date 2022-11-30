library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SRE is
    Port ( exp_diff : in  STD_LOGIC_VECTOR (7 downto 0);
           small_num : in  STD_LOGIC_VECTOR (23 downto 0);
           small_shifted : out  STD_LOGIC_VECTOR (23 downto 0));
end SRE;

architecture Behavioral of SRE is

begin

-- Shifting small number for alignment of small and big number
small_shifted <= std_logic_vector(shift_right(unsigned(small_num),to_integer(abs(signed(exp_diff)))));

end Behavioral;
