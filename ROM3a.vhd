library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM3a;

architecture arc_ROM3a of ROM3a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "110010100010001" when address = "0000" else
"100000001011101" when address = "0001" else
"110010000011001" when address = "0010" else
"001000010011110" when address = "0011" else
"011000011110000" when address = "0100" else
"010010000111010" when address = "0101" else
"111000001000101" when address = "0110" else
"000011000111100" when address = "0111" else
"100000001101011" when address = "1000" else
"000001100111100" when address = "1001" else
"001101100100010" when address = "1010" else
"110001011000001" when address = "1011" else
"001100011110000" when address = "1100" else
"111010000010010" when address = "1101" else
"001000011001110" when address = "1110" else
"000100011111000";
			 
end arc_ROM3a;