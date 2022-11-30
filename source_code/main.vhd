
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main is
    Port ( number_1, number_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0)
--			    n1_out, n2_out : out std_logic;
--				 full_fraction_1_out, full_fraction_2_out : out std_logic_vector(23 downto 0);
--				 salu_input_1_out, salu_input_2_out : out std_logic_vector(7 downto 0);
--				 exponent_difference_out : out std_logic_vector(7 downto 0);
--				 borrow_out : out std_logic;
--				 small_num_out, big_num_out : out std_logic_vector(23 downto 0);
--				 sign_big_number_out, sign_small_number_out : out std_logic;
--				 small_number_shifted_out : out std_logic_vector (23 downto 0);
--				 big_number_complemented_out, small_number_complemented_out : out std_logic_vector(28 downto 0);
--				 sum_of_complemented_out : out std_logic_vector (28 downto 0);
--				 sum_sm_out : out std_logic_vector (28 downto 0);
--				 exp_nominated_out : out std_logic_vector (7 downto 0);
--				 sub_normalized_out : out std_logic_vector (28 downto 0);
--				 exp_normalized_out : out std_logic_vector (7 downto 0);
--				 subsm_rounded_out : out std_logic_vector (28 downto 0);
--				 fexp_rounded_out : out std_logic_vector (7 downto 0);
--				 subsm_rerounded_out : out std_logic_vector (28 downto 0);
--				 fexp_rerounded_out : out std_logic_vector (7 downto 0)
			  );
end main;

architecture Behavioral of main is

-- Adding components architecture to the main module

component nvd is port (exp : in std_logic_vector(7 downto 0); n : out std_logic);
end component;

component salu is port (exponent_1 : in std_logic_vector(7 downto 0); exponent_2 : in std_logic_vector(7 downto 0); difference : out std_logic_vector(7 downto 0); borrow : out std_logic);
end component;

component chbf is port (N : in std_logic; fraction : in STD_LOGIC_VECTOR(22 downto 0); operand : out std_logic_vector(23 downto 0));
end component;

component sre is port (exp_diff : in std_logic_vector(7 downto 0); small_num : in std_logic_vector(23 downto 0); small_shifted : out std_logic_vector(23 downto 0));
end component;

component sm2c is port (num : in std_logic_vector(23 downto 0); sign : in std_logic; numc : out std_logic_vector(28 downto 0));
end component;

component c2s is Port ( sum : in  STD_LOGIC_VECTOR (28 downto 0); sumsm : out  STD_LOGIC_VECTOR (28 downto 0); sign : out std_logic);
end component;

component norm is Port ( fexp : in  STD_LOGIC_VECTOR (7 downto 0); sumsm : in  STD_LOGIC_VECTOR (28 downto 0); sub_norm : out  STD_LOGIC_VECTOR (28 downto 0); fexp_norm : out std_logic_vector (7 downto 0));
end component;

component round is
    Port ( sumsm_shifted : in  STD_LOGIC_VECTOR (28 downto 0); fexp_corrected : in  STD_LOGIC_VECTOR (7 downto 0); sumsm_sh_rounded : out  STD_LOGIC_VECTOR (28 downto 0);fexp_co : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component SNC is Port ( exp_norm2 : in  STD_LOGIC_VECTOR (7 downto 0); frac_norm2 : in  STD_LOGIC_VECTOR (28 downto 0); EXPONENT_F : out  STD_LOGIC_VECTOR (7 downto 0); fraction_f : out  STD_LOGIC_VECTOR (22 downto 0));
end component;

signal sign_1, sign_2 , sign_small_number , sign_big_number : std_logic;
signal exp_1, exp_2, fexp_rounded, fexp_rerounded, final_exp : std_logic_vector(7 downto 0);
signal frac_1, frac_2, final_frac : std_logic_vector(22 downto 0);

signal n1,n2 : STD_LOGIC;
signal full_fraction_1 , full_fraction_2 : STD_LOGIC_VECTOR(23 downto 0);

signal salu_input_1 , salu_input_2 : STD_LOGIC_VECTOR(7 downto 0);
signal exponent_difference, exp_normalized, exp_nominated : STD_LOGIC_VECTOR(7 downto 0);
signal borrow, sign_out : STD_LOGIC;

signal small_num , big_num, small_number_shifted, big_number_shifted : STD_LOGIC_VECTOR(23 downto 0);
signal small_number_complemented , big_number_complemented : STD_LOGIC_VECTOR(28 downto 0);
signal sum_of_complemented, sum_sm, sub_normalized, subsm_rounded, subsm_rerounded  : STD_LOGIC_VECTOR(28 downto 0);

--signal n1_out, n2_out : std_logic;
--signal full_fraction_1_out, full_fraction_2_out : std_logic_vector(23 downto 0);
--signal salu_input_1_out, salu_input_2_out : std_logic_vector(7 downto 0);
--signal exponent_difference_out : std_logic_vector(7 downto 0);
--signal borrow_out : std_logic;
--signal small_num_out, big_num_out : std_logic_vector(23 downto 0);
--signal sign_big_number_out, sign_small_number_out : std_logic;
--signal small_number_shifted_out : std_logic_vector (23 downto 0);
--signal big_number_complemented_out, small_number_complemented_out : std_logic_vector(28 downto 0);
--signal sum_of_complemented_out : std_logic_vector (28 downto 0);
--signal sum_sm_out : std_logic_vector (28 downto 0);
--signal exp_nominated_out : std_logic_vector (7 downto 0);
--signal sub_normalized_out : std_logic_vector (28 downto 0);
--signal exp_normalized_out : std_logic_vector (7 downto 0);
--signal subsm_rounded_out : std_logic_vector (28 downto 0);
--signal fexp_rounded_out : std_logic_vector (7 downto 0);
--signal subsm_rerounded_out : std_logic_vector (28 downto 0);
--signal fexp_rerounded_out : std_logic_vector (7 downto 0);

begin

----------------------------------------- Extracting Fraction & exponent & sign
sign_1 <= number_1(31); 
sign_2 <= number_2(31);

exp_1 <= number_1(30 downto 23);
exp_2 <= number_2(30 downto 23);

frac_1 <= number_1(22 downto 0);
frac_2 <= number_2(22 downto 0);

------------------------------------------- Normalized or Denormalized

nvd1 : nvd port map(exp_1,n1);
nvd2 : nvd port map(exp_2,n2);

--n1_out <= n1;
--n2_out <= n2;

------------------------------------------- Concatenation of hidden bit

concat1 : chbf port map(n1,frac_1,full_fraction_1);
concat2 : chbf port map(n2,frac_2,full_fraction_2);

--full_fraction_1_out <= full_fraction_1;
--full_fraction_2_out <= full_fraction_2;

------------------------------------------- Choose right exponent for SALU

-- If denormalized (N1 = 1) pass exponent value as before , otherwise pass 1
with n1 select
		salu_input_1 <= exp_1 when '1',
							 "00000001" when '0';
							 
with n2 select
		salu_input_2 <= exp_2 when '1',
							 "00000001" when '0';							 

--salu_input_1_out <= salu_input_1;
--salu_input_2_out <= salu_input_2;

------------------------------------------- Exponent Difference (Small ALU)(SALU)

salu1 : salu port map(salu_input_1,salu_input_2,exponent_difference,borrow);

--exponent_difference_out <= exponent_difference;
--borrow_out <= borrow;

------------------------------------------- Swap inputs if necessary

-- if borrow (MSB of subtraction) , then E2 > E1 so we need to swap, otherwise leave them unchanged (E1 > E2) 
with borrow select
		small_num <= full_fraction_2 when '0',
						 full_fraction_1 when '1';

with borrow select
		big_num <= full_fraction_1 when '0',
					  full_fraction_2 when '1';

-- Need to swap sign values too
with borrow select
		sign_small_number <= sign_2 when '0',
						 sign_1 when '1';

with borrow select
		sign_big_number <= sign_1 when '0',
						 sign_2 when '1';		

--small_num_out <= small_num;
--big_num_out <= big_num;
--sign_small_number_out <= sign_small_number;	
--sign_big_number_out <= sign_big_number;
------------------------------------------- Shift Small number right

shift_r : sre port map (exponent_difference, small_num, small_number_shifted);

--small_number_shifted_out <= small_number_shifted;

------------------------------------------- Sign Magnitude -> 2s complement

sm2c1 : sm2c port map(small_number_shifted,sign_small_number,small_number_complemented);
sm2c2 : sm2c port map(big_num,sign_big_number,big_number_complemented);

--small_number_complemented_out <= small_number_complemented;
--big_number_complemented_out <= big_number_complemented;

------------------------------------------- Adding Fractions (29 bits)

sum_of_complemented <= std_logic_vector(signed(small_number_complemented) + signed(big_number_complemented));

--sum_of_complemented_out <= sum_of_complemented;

------------------------------------------- twos compleemnt to sign magnitude 
 
c2s1 : c2s port map(sum_of_complemented, sum_sm, sign_out); 

--sum_sm_out <= sum_sm;

------------------------------------------- choosing exponent

-- Choosing the exponent of bigger number for normalization
with borrow select 
	exp_nominated <= salu_input_2 when '1',
						  salu_input_1 when '0';

--exp_nominated_out <= exp_nominated;						  

------------------------------------------- normalizing 

norm1 : norm port map (exp_nominated, sum_sm, sub_normalized, exp_normalized);

--sub_normalized_out <= sub_normalized;
--exp_normalized_out <= exp_normalized;

------------------------------------------- rounding 

round1 : round port map (sub_normalized, exp_normalized, subsm_rounded, fexp_rounded);

--subsm_rounded_out <= subsm_rounded;
--fexp_rounded_out <= fexp_rounded;

------------------------------------------- renormalizing 

norm2 : norm port map (fexp_rounded, subsm_rounded, subsm_rerounded, fexp_rerounded);

--subsm_rerounded_out <= subsm_rerounded;
--fexp_rerounded_out <= fexp_rerounded;
------------------------------------------- handling denormalized cases 

denorm1 : SNC port map (fexp_rerounded, subsm_rerounded, final_exp, final_frac);

------------------------------------------- assembing RESULT!

-- Concatenating different parts of result to assemble one final answer
result <= sign_out & final_exp & final_frac;

-- the end (rooz khosh :)

end Behavioral;

