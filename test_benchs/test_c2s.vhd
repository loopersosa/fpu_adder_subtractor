
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY test2_c2s IS
END test2_c2s;
 
ARCHITECTURE behavior OF test2_c2s IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT c2s
    PORT(
         sum : IN  std_logic_vector(28 downto 0);
         sumsm : OUT  std_logic_vector(28 downto 0);
         sign : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sum : std_logic_vector(28 downto 0) := (others => '0');

 	--Outputs
   signal sumsm : std_logic_vector(28 downto 0);
   signal sign : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: c2s PORT MAP (
          sum => sum,
          sumsm => sumsm,
          sign => sign
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		sum <= "00000000011110000111100101011";
		wait for 100 ns;
		sum <= "10000000011110000111100101011";


      wait;
   end process;

END;
