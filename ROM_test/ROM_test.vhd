library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ROM_test is
	
	port
	(
		CLOCK : in std_logic;
		SW : in std_logic_vector(7 downto 0);
		HEX0, HEX1 : out std_logic_vector(6 downto 0)
	);
end ROM_test;
	
	


architecture behavioral of ROM_test is

component deco7segV3 is
	port(
		-- Input ports
			SW : in std_logic_vector(3 downto 0);
		-- Output ports
			HEX : out std_logic_vector (6 downto 0)
		);
	end component;
	
	component rom_128x8_sync is
		port(
			clock : in std_logic;
			address : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal data_out : std_logic_vector(7 downto 0);
	signal data_out1: std_logic_vector(3 downto 0) := data_out(3 downto 0);
	signal data_out2 : std_logic_vector(3 downto 0) := data_out(7 downto 4);

	begin
	
		rom : rom_128x8_sync port map (CLOCK, SW, data_out);
		S0 : deco7segV3 port map (data_out1, HEX0);
		S1 : deco7segV3 port map (data_out2, HEX1);



end behavioral;
