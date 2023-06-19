library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM1a;

architecture arc_ROM1a of ROM1a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000011000000110" when address = "0000" else
"001000100100010" when address = "0001" else
"001101000001000" when address = "0010" else
"001000011000010" when address = "0011" else
"110000011000000" when address = "0100" else
"001100011000000" when address = "0101" else
"010010001010000" when address = "0110" else
"100001001100000" when address = "0111" else
"010010010001000" when address = "1000" else
"000001010000011" when address = "1001" else
"001001110000000" when address = "1010" else
"010001000010100" when address = "1011" else
"010000001010100" when address = "1100" else
"101010010000000" when address = "1101" else
"010111000000000" when address = "1110" else
"000000011010010";
			 
end arc_ROM1a;