library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SNC is
    Port ( exp_norm2 : in  STD_LOGIC_VECTOR (7 downto 0);
           frac_norm2 : in  STD_LOGIC_VECTOR (28 downto 0);
           EXPONENT_F : out  STD_LOGIC_VECTOR (7 downto 0);
           fraction_f : out  STD_LOGIC_VECTOR (22 downto 0));
end SNC;

architecture Behavioral of SNC is

signal denorm_check : std_logic;

begin

-- check if exponent is one , so as not to renormalize 
denorm_check <= not exp_norm2(7) and not exp_norm2(6) and not exp_norm2(5) and not exp_norm2(4) and not exp_norm2(3) and not exp_norm2(2) and not exp_norm2(1) and exp_norm2(0);

-- replace exponent 1 with zero in case of a denormalized number
with denorm_check select
		EXPONENT_F <= "00000000" when '1',
						   exp_norm2 when '0';

-- Masking fration for final result (23 bit)(current size 29 bits)							
fraction_f <= frac_norm2(22 downto 5) & "00000";		

end Behavioral;

