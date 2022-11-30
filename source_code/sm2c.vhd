library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SM2C is
    Port ( num : in  STD_LOGIC_VECTOR (23 downto 0);
           sign : in  STD_LOGIC;
           numc : out  STD_LOGIC_VECTOR (28 downto 0));
end SM2C;

architecture Behavioral of SM2C is

signal num_zero : STD_LOGIC_VECTOR(28 downto 0);
signal num_comp : STD_LOGIC_VECTOR(28 downto 0);
signal borrow : STD_LOGIC;

component FA_8bit is
	port(x,y : in std_logic_vector(28 downto 0);
      sum : out std_logic_vector(28 downto 0);
      co : out std_logic);
end component;

begin

-- extending number with zeros for 29-bit adder (current size 24 bits)
num_zero <= "00000" & num;

FA_8bit_29 : FA_8bit port map("00000000000000000000000000000",num_zero,num_comp,borrow);

-- if sign bit is 1 (negative number) , return two's complement. otherwise return the zero-extended number 
with sign select
	numc <= num_comp when '1',
			  num_zero when '0';
				
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

-- SALU
entity FA_8bit is
port(x,y : in std_logic_vector(28 downto 0);
      sum : out std_logic_vector(28 downto 0);
      co : out std_logic);
end FA_8bit;

architecture FA_arch of FA_8bit is
signal cary : std_logic_vector(27 downto 0);
signal cin  : std_logic;

component full_adder is
  port (p,q,r:in std_logic; sm,cr: out std_logic);
end component;
  begin
  
  -- 29 bit adder
  
  -- Cin = 1 for subtraction (usage of adder circuit for subtracting) 
	Cin <= '1';
	
	  -- 29 Cascading full adders make up one 29-bit adder
     a0:full_adder port map (x(0),not y(0),cin,sum(0),cary(0));
     a1:full_adder port map (x(1),not y(1),cary(0),sum(1),cary(1));
     a2:full_adder port map (x(2),not y(2),cary(1),sum(2),cary(2));
     a3:full_adder port map (x(3),not y(3),cary(2),sum(3),cary(3));
     a4:full_adder port map (x(4),not y(4),cary(3),sum(4),cary(4));
     a5:full_adder port map (x(5),not y(5),cary(4),sum(5),cary(5));
     a6:full_adder port map (x(6),not y(6),cary(5),sum(6),cary(6));
	  a7:full_adder port map (x(7),not y(7),cary(6),sum(7),cary(7));
     a8:full_adder port map (x(8),not y(8),cary(7),sum(8),cary(8));
     a9:full_adder port map (x(9),not y(9),cary(8),sum(9),cary(9));
     a10:full_adder port map (x(10),not y(10),cary(9),sum(10),cary(10));
     a11:full_adder port map (x(11),not y(11),cary(10),sum(11),cary(11));
     a12:full_adder port map (x(12),not y(12),cary(11),sum(12),cary(12));
     a13:full_adder port map (x(13),not y(13),cary(12),sum(13),cary(13));
	  a14:full_adder port map (x(14),not y(14),cary(13),sum(14),cary(14));
     a15:full_adder port map (x(15),not y(15),cary(14),sum(15),cary(15));
     a16:full_adder port map (x(16),not y(16),cary(15),sum(16),cary(16));
     a17:full_adder port map (x(17),not y(17),cary(16),sum(17),cary(17));
     a18:full_adder port map (x(18),not y(18),cary(17),sum(18),cary(18));
     a19:full_adder port map (x(19),not y(19),cary(18),sum(19),cary(19));
     a20:full_adder port map (x(20),not y(20),cary(19),sum(20),cary(20));
	  a21:full_adder port map (x(21),not y(21),cary(20),sum(21),cary(21));
     a22:full_adder port map (x(22),not y(22),cary(21),sum(22),cary(22));
     a23:full_adder port map (x(23),not y(23),cary(22),sum(23),cary(23));
     a24:full_adder port map (x(24),not y(24),cary(23),sum(24),cary(24));
     a25:full_adder port map (x(25),not y(25),cary(24),sum(25),cary(25));
     a26:full_adder port map (x(26),not y(26),cary(25),sum(26),cary(26));
     a27:full_adder port map (x(27),not y(27),cary(26),sum(27),cary(27));
	  a28:full_adder port map (x(28),not y(28),cary(27),sum(28),co);
end FA_arch;

-- Full adder architecture to be used for constructing 29 bit adder
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
