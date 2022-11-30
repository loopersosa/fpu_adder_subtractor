
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_round IS
END test_round;
 
ARCHITECTURE behavior OF test_round IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT round
    PORT(
         sumsm_shifted : IN  std_logic_vector(28 downto 0);
         fexp_corrected : IN  std_logic_vector(7 downto 0);
         sumsm_sh_rounded : OUT  std_logic_vector(28 downto 0);
         fexp_co : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sumsm_shifted : std_logic_vector(28 downto 0) := (others => '0');
   signal fexp_corrected : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sumsm_sh_rounded : std_logic_vector(28 downto 0);
   signal fexp_co : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: round PORT MAP (
          sumsm_shifted => sumsm_shifted,
          fexp_corrected => fexp_corrected,
          sumsm_sh_rounded => sumsm_sh_rounded,
          fexp_co => fexp_co
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here
		
		-- Round to even (ends in 10)
		sumsm_shifted <= "00000000011110000111100010011";
		fexp_corrected <= "10001010";
		wait for 100 ns;
		
		-- Not Rounded
		sumsm_shifted <= "00000000011110000111100010000";
		fexp_corrected <= "10001010";
		wait for 100 ns;
		
		-- Round to Even (ends in 10)
		sumsm_shifted <= "00000000011110000111100110000";
		fexp_corrected <= "10001010";
		wait for 100 ns;
		
		-- Round to Even (ends in 10)
		sumsm_shifted <= "00000000011110000111100010100";
		fexp_corrected <= "10001010";
		wait for 100 ns;
		
		-- Round to Even (ends in 10)
		sumsm_shifted <= "00000000011110000111100010100";
		fexp_corrected <= "10001010";
		

      wait;
   end process;

END;
