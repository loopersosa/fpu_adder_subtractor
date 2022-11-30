
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_adding_temp IS
END test_adding_temp;
 
ARCHITECTURE behavior OF test_adding_temp IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT addin_temp
    PORT(
         small_number_complemented : IN  std_logic_vector(28 downto 0);
         big_number_complemented : IN  std_logic_vector(28 downto 0);
         sum_of_complemented : OUT  std_logic_vector(28 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal small_number_complemented : std_logic_vector(28 downto 0) := (others => '0');
   signal big_number_complemented : std_logic_vector(28 downto 0) := (others => '0');

 	--Outputs
   signal sum_of_complemented : std_logic_vector(28 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: addin_temp PORT MAP (
          small_number_complemented => small_number_complemented,
          big_number_complemented => big_number_complemented,
          sum_of_complemented => sum_of_complemented
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		small_number_complemented <= "00110111110100100000000000000";
		big_number_complemented   <= "00000111110101010110000000000";


      wait;
   end process;

END;
