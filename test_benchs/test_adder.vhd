--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:33:20 11/22/2022
-- Design Name:   
-- Module Name:   F:/coding/FPU/FPP/Test_adder.vhd
-- Project Name:  FPP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FA_8bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_adder IS
END Test_adder;
 
ARCHITECTURE behavior OF Test_adder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FA_8bit
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         y : IN  std_logic_vector(7 downto 0);
         sum : OUT  std_logic_vector(7 downto 0);
         co : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');
   signal y : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sum : std_logic_vector(7 downto 0);
   signal co : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FA_8bit PORT MAP (
          x => x,
          y => y,
          sum => sum,
          co => co
        );

   -- Clock process definitions

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here
		x <= "11001001";
		y <= "00110000";

      wait;
   end process;

END;
