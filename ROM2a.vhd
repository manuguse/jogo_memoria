library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM2a;

architecture arc_ROM2a of ROM2a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000101001101000" when address = "0000" else
"001001000110010" when address = "0001" else
"000101100010100" when address = "0010" else
"100010011000100" when address = "0011" else
"100110000000101" when address = "0100" else
"100101001000010" when address = "0101" else
"000001011010001" when address = "0110" else
"001100001000110" when address = "0111" else
"100011010010000" when address = "1000" else
"100011000001010" when address = "1001" else
"001011000001100" when address = "1010" else
"100000110000110" when address = "1011" else
"001000010101010" when address = "1100" else
"011100000100001" when address = "1101" else
"110100000000101" when address = "1110" else
"001011001100000";
			 
end arc_ROM2a;