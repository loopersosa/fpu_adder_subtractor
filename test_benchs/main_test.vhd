
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Main_Test_1 IS
END Main_Test_1;
 
ARCHITECTURE behavior OF Main_Test_1 IS 
 

 
    COMPONENT main
    Port ( number_1, number_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0) );
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
			  
    END COMPONENT;
    
   
   --Inputs
   signal number_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal number_2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
--   signal n1_out, n2_out : std_logic;
--	signal full_fraction_1_out, full_fraction_2_out : std_logic_vector(23 downto 0);
--	signal salu_input_1_out, salu_input_2_out : std_logic_vector(7 downto 0);
--	signal exponent_difference_out : std_logic_vector(7 downto 0);
--	signal borrow_out : std_logic;
--	signal small_num_out, big_num_out : std_logic_vector(23 downto 0);
--	signal sign_big_number_out, sign_small_number_out : std_logic;
--	signal small_number_shifted_out : std_logic_vector (23 downto 0);
--	signal big_number_complemented_out, small_number_complemented_out : std_logic_vector(28 downto 0);
--	signal sum_of_complemented_out : std_logic_vector (28 downto 0);
--	signal sum_sm_out : std_logic_vector (28 downto 0);
--	signal exp_nominated_out : std_logic_vector (7 downto 0);
--	signal sub_normalized_out : std_logic_vector (28 downto 0);
--	signal exp_normalized_out : std_logic_vector (7 downto 0);
--	signal subsm_rounded_out : std_logic_vector (28 downto 0);
--	signal fexp_rounded_out : std_logic_vector (7 downto 0);
--	signal subsm_rerounded_out : std_logic_vector (28 downto 0);
--	signal fexp_rerounded_out : std_logic_vector (7 downto 0);
	-- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          number_1 => number_1,
          number_2 => number_2,
          result => result);
--			 n1_out => n1_out,
--			 n2_out => n2_out,
--			 full_fraction_1_out => full_fraction_1_out, 
--			 full_fraction_2_out => full_fraction_2_out,
--			 salu_input_1_out => salu_input_1_out,
--			 salu_input_2_out => salu_input_2_out,
--			 exponent_difference_out => exponent_difference_out,
--			 borrow_out => borrow_out,
--			 small_num_out => small_num_out,
--			 big_num_out => big_num_out,
--			 sign_big_number_out => sign_big_number_out,
--			 sign_small_number_out => sign_small_number_out,
--			 small_number_shifted_out => small_number_shifted_out,
--			 big_number_complemented_out => big_number_complemented_out,
--			 small_number_complemented_out => small_number_complemented_out,
--			 sum_of_complemented_out => sum_of_complemented_out,
--			 sum_sm_out => sum_sm_out,
--			 exp_nominated_out => exp_nominated_out,
--			 sub_normalized_out =>sub_normalized_out,
--			 exp_normalized_out => exp_normalized_out,
--			 subsm_rounded_out => subsm_rounded_out,
--			 fexp_rounded_out => fexp_rounded_out,
--			 subsm_rerounded_out => subsm_rerounded_out,
--			 fexp_rerounded_out => fexp_rerounded_out
        


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	  
		
		-- Normalized and positive
		number_1 <= '0' & "10000010" & "00111000000000000000000";
		number_2 <= '0' & "01111110" & "00100000000000000000000";
		wait for 100 ns;
		
		number_1 <= '0' & "10000000" & "00100000000000000000000";
		number_2 <= '0' & "10000110" & "00001100001000000000000";
		wait for 100 ns;
		
		-- normalized and one negative input second
		number_1 <= '0' & "10000110" & "00001110100010010011100"; -- 135.268
		number_2 <= '1' & "10000101" & "00111010010001000011001"; -- -78.5666
		wait for 100 ns;
		
		-- normalized and negative input first
		number_1 <= '1' & "10000010" & "10000111100011010101000"; -- -12.236
		number_2 <= '0' & "10000101" & "01000000111010111000011"; -- 80.23
		wait for 100 ns;
		
		-- normalized and two negative inputs
		number_1 <= '1' & "10000100" & "00000110010111000010100"; -- -32.795
		number_2 <= '1' & "10001000" & "11110101010010001011010"; -- -1002.568
		wait for 100 ns;
		
		-- two denormalized positive inputs
		number_1 <= '0' & "00000000" & "00001111111110011101110";
		number_2 <= '0' & "00000000" & "00000010110101110011110";
		wait for 100 ns;
		
		-- two denormalized , one negative
		number_1 <= '1' & "00000000" & "00010010111101110011110"; -- -8.70864956624e-40
		number_2 <= '0' & "00000000" & "01010010111101110111110"; -- 3.80964567523e-39
		wait for 100 ns;
		
		-- one normalized , one denormalized , both positive
		number_1 <= '0' & "01000001" & "00010010110100010001100";
		number_2 <= '0' & "00000000" & "10010010110100010001101";
		wait for 100 ns;
		
		-- one normalized , one denormalized (denorm - norm)
		number_1 <= '0' & "00000000" & "01000000000010001101000";
		number_2 <= '1' & "01000010" & "01000000000010001101000";
      wait;
   end process;

END;
