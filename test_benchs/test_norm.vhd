
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_norm IS
END test_norm;
 
ARCHITECTURE behavior OF test_norm IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT norm
    PORT(
         fexp : IN  std_logic_vector(7 downto 0);
         sumsm : IN  std_logic_vector(28 downto 0);
         sub_norm : OUT  std_logic_vector(28 downto 0);
         fexp_norm : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal fexp : std_logic_vector(7 downto 0) := (others => '0');
   signal sumsm : std_logic_vector(28 downto 0) := (others => '0');

 	--Outputs
   signal sub_norm : std_logic_vector(28 downto 0);
   signal fexp_norm : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: norm PORT MAP (
          fexp => fexp,
          sumsm => sumsm,
          sub_norm => sub_norm,
          fexp_norm => fexp_norm
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	 
		
		-- normalze
		sumsm <= "00000100011110000111100101011";
		fexp <= "00011100";
		
		-- denormalize big
		wait for 100 ns;
		fexp <= "00110101";
		sumsm <= "00001000011110000111100101011";
wait for 100 ns;
		
		-- denormalize small
		sumsm <= "00000000011110000111100101011";
		fexp <= "00011100";
		
		-- useless
wait for 100 ns;
		sumsm <= "00001100011110000111100101011";
		fexp <= "00011100";		

      -- insert stimulus here 

      wait;
   end process;

END;
