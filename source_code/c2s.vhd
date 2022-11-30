library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity c2s is
    Port ( sum : in  STD_LOGIC_VECTOR (28 downto 0);
           sumsm : out  STD_LOGIC_VECTOR (28 downto 0);
			  sign : out std_logic);
end c2s;

architecture Behavioral of c2s is

signal msb_sum : STD_LOGIC;
signal sum_comp : STD_LOGIC_VECTOR(28 downto 0);
signal cin : STD_LOGIC;
signal x : STD_LOGIC_VECTOR(28 downto 0);
signal cary : STD_LOGIC_VECTOR(28 downto 0);
signal y : STD_LOGIC_VECTOR(28 downto 0);

component full_adder is
  port (p,q,r:in std_logic; sm,cr: out std_logic);
end component;

begin

-- extracting the MSB ( Most Significant Bit)
msb_sum <= sum(28);

-- assigning MSB to sign bit
sign <= msb_sum;

-- if sum is negative , calculate two's complemented version of sum, otherwise pass the sum itself
with msb_sum select
	sumsm <= sum when '0',
			   sum_comp when '1';

-- subtraction (for calculating two's complement)
Cin <= '1';

-- Assigning zero to x ( x-y -> 0-y -> -y )
x <= "00000000000000000000000000000";

-- the number to be complemented by two
y <= sum;

     a0:full_adder port map (x(0),not y(0),cin,sum_comp(0),cary(0));
     a1:full_adder port map (x(1),not y(1),cary(0),sum_comp(1),cary(1));
     a2:full_adder port map (x(2),not y(2),cary(1),sum_comp(2),cary(2));
     a3:full_adder port map (x(3),not y(3),cary(2),sum_comp(3),cary(3));
     a4:full_adder port map (x(4),not y(4),cary(3),sum_comp(4),cary(4));
     a5:full_adder port map (x(5),not y(5),cary(4),sum_comp(5),cary(5));
     a6:full_adder port map (x(6),not y(6),cary(5),sum_comp(6),cary(6));
	  a7:full_adder port map (x(7),not y(7),cary(6),sum_comp(7),cary(7));
     a8:full_adder port map (x(8),not y(8),cary(7),sum_comp(8),cary(8));
     a9:full_adder port map (x(9),not y(9),cary(8),sum_comp(9),cary(9));
     a10:full_adder port map (x(10),not y(10),cary(9),sum_comp(10),cary(10));
     a11:full_adder port map (x(11),not y(11),cary(10),sum_comp(11),cary(11));
     a12:full_adder port map (x(12),not y(12),cary(11),sum_comp(12),cary(12));
     a13:full_adder port map (x(13),not y(13),cary(12),sum_comp(13),cary(13));
	  a14:full_adder port map (x(14),not y(14),cary(13),sum_comp(14),cary(14));
     a15:full_adder port map (x(15),not y(15),cary(14),sum_comp(15),cary(15));
     a16:full_adder port map (x(16),not y(16),cary(15),sum_comp(16),cary(16));
     a17:full_adder port map (x(17),not y(17),cary(16),sum_comp(17),cary(17));
     a18:full_adder port map (x(18),not y(18),cary(17),sum_comp(18),cary(18));
     a19:full_adder port map (x(19),not y(19),cary(18),sum_comp(19),cary(19));
     a20:full_adder port map (x(20),not y(20),cary(19),sum_comp(20),cary(20));
	  a21:full_adder port map (x(21),not y(21),cary(20),sum_comp(21),cary(21));
     a22:full_adder port map (x(22),not y(22),cary(21),sum_comp(22),cary(22));
     a23:full_adder port map (x(23),not y(23),cary(22),sum_comp(23),cary(23));
     a24:full_adder port map (x(24),not y(24),cary(23),sum_comp(24),cary(24));
     a25:full_adder port map (x(25),not y(25),cary(24),sum_comp(25),cary(25));
     a26:full_adder port map (x(26),not y(26),cary(25),sum_comp(26),cary(26));
     a27:full_adder port map (x(27),not y(27),cary(26),sum_comp(27),cary(27));
	  a28:full_adder port map (x(28),not y(28),cary(27),sum_comp(28),cary(28));


end Behavioral;

-- Full adder architecture to be instanced in adder
library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
   port (p,q,r:in std_logic; sm,cr: out std_logic);
end full_adder;

architecture FA_arc of full_adder is
  begin
    sm <= p xor q xor r;
    cr <= (p and q) or (q and r) or (r and p);
   end FA_arc;
