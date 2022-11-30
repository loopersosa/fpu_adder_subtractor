LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY snc_test IS
END snc_test;
 
ARCHITECTURE behavior OF snc_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SNC
    PORT(
         exp_norm2 : IN  std_logic_vector(7 downto 0);
         frac_norm2 : IN  std_logic_vector(28 downto 0);
         EXPONENT_F : OUT  std_logic_vector(7 downto 0);
         fraction_f : OUT  std_logic_vector(22 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal exp_norm2 : std_logic_vector(7 downto 0) := (others => '0');
   signal frac_norm2 : std_logic_vector(28 downto 0) := (others => '0');

 	--Outputs
   signal EXPONENT_F : std_logic_vector(7 downto 0);
   signal fraction_f : std_logic_vector(22 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SNC PORT MAP (
          exp_norm2 => exp_norm2,
          frac_norm2 => frac_norm2,
          EXPONENT_F => EXPONENT_F,
          fraction_f => fraction_f
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	

      -- insert stimulus here 
		-- Normalized
		exp_norm2 <="10001010";
		frac_norm2 <= "00000000011110000111100010100";
		
		wait for 20 ns;
		
		-- Denormalized
		exp_norm2 <= "00000000";
		frac_norm2 <= "00000000011110000111100010100";

      wait;
   end process;

END;
