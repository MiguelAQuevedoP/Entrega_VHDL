library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_128x8_sync is

	port
	(
			clock : in std_logic;
			address : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0)
	);
end rom_128x8_sync;

architecture behavioral of rom_128x8_sync is
	
	signal EN : std_logic;


	constant LDA_IMM : std_logic_vector (7 downto 0) := x"86";
	constant LDA_DIR : std_logic_vector (7 downto 0) := x"87";
	constant LDB_IMM : std_logic_vector (7 downto 0) := x"88";
	constant LDB_DIR : std_logic_vector (7 downto 0) := x"89";
	constant STA_DIR : std_logic_vector (7 downto 0) := x"96";
	constant STB_DIR : std_logic_vector (7 downto 0) := x"97";
	constant ADD_AB : std_logic_vector 	(7 downto 0) := x"42";
	constant BRA : std_logic_vector 		(7 downto 0) := x"20";
	constant BEQ : std_logic_vector 		(7 downto 0) := x"23";
	
	type ROM_type is array (0 to 127) of std_logic_vector(7 downto 0);
	
	constant ROM : ROM_type :=(0 => LDA_IMM,
										1 => x"AA",
										2 => STA_DIR,
										3 => x"E0",
										4 => BRA,
										5 => x"00",
										others => x"00");

begin
	enable : process(address)
		begin
		if((to_integer(unsigned(address)) >=0) and (to_integer(unsigned(address)) <=127)) then
			EN<='1';
			else
			EN<='0';
		end if;
	end process;
	
	MEMORY : process (clock)
	begin
		if (clock'event and clock='1') then
			data_out <= ROM (to_integer(unsigned(address)));
		end if;
	end process;
end behavioral;
