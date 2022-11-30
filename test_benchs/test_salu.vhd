
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_salu IS
END test_salu;
 
ARCHITECTURE behavior OF test_salu IS 
 

 
    COMPONENT salu
    PORT(
         exponent_1 : IN  std_logic_vector(7 downto 0);
         exponent_2 : IN  std_logic_vector(7 downto 0);
         difference : OUT  std_logic_vector(7 downto 0);
         borrow : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal exponent_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal exponent_2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal difference : std_logic_vector(7 downto 0);
   signal borrow : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: salu PORT MAP (
          exponent_1 => exponent_1,
          exponent_2 => exponent_2,
          difference => difference,
          borrow => borrow
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	
		
		exponent_1 <= "10000010";
		exponent_2 <= "01111110";
		

      wait;
   end process;

END;
