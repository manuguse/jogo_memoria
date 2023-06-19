library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM3;

architecture arc_ROM3 of ROM3 is
begin

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "1010" & "1111" & "0100" & "0000" & "1101" & "1110" & "1000" & "1111" when address = "0000" else
--A      des      4      0      D      E      8      des

"0010" & "0000" & "0100" & "0110" & "0011" & "1110" & "1111" & "1111" when address = "0001" else
--2      0      4      6      3      E      des      des

"0000" & "1110" & "1111" & "1010" & "0100" & "1111" & "0011" & "1101" when address = "0010" else
--0      E      des      A      4      des      3      D

"0001" & "1111" & "0111" & "0011" & "1100" & "0010" & "1111" & "0100" when address = "0011" else
--1      des      7      3      C      2      des      4

"1100" & "1101" & "0110" & "1111" & "0100" & "0101" & "0111" & "1111" when address = "0100" else
--C      D      6      des      4      5      7      des

"1111" & "0100" & "1111" & "0011" & "1010" & "0001" & "1101" & "0101" when address = "0101" else
--des      4      des      3      A      1      D      5

"0010" & "1101" & "0110" & "1111" & "1111" & "1110" & "1100" & "0000" when address = "0110" else
--2      D      6      des      des      E      C      0

"1111" & "0011" & "0101" & "1001" & "1111" & "0100" & "1010" & "0010" when address = "0111" else
--des      3      5      9      des      4      A      2

"0000" & "1111" & "1111" & "0101" & "0110" & "0011" & "0001" & "1110" when address = "1000" else
--0      des      des      5      6      3      1      E

"1111" & "1001" & "1000" & "1111" & "0010" & "0101" & "0011" & "0100" when address = "1001" else
--des      9      8      des      2      5      3      4

"1100" & "1111" & "0001" & "0101" & "1001" & "1111" & "1000" & "1011" when address = "1010" else
--C      des      1      5      9      des      8      B

"0110" & "1111" & "1001" & "1110" & "1101" & "0111" & "1111" & "0000" when address = "1011" else
--6      des      9      E      D      7      des      0

"0110" & "0101" & "1111" & "0100" & "1011" & "1111" & "0111" & "1100" when address = "1100" else
--6      5      des      4      B      des      7      C

"1101" & "1110" & "0001" & "1010" & "1100" & "0100" & "1111" & "1111" when address = "1101" else
--D      E      1      A      C      4      des      des

"1100" & "0010" & "0001" & "1111" & "0011" & "0111" & "0110" & "1111" when address = "1110" else
--C      2      1      des      3      7      6      des

"0100" & "0111" & "0110" & "1111" & "1111" & "0011" & "1011" & "0101";
--4      7      6      des      des      3      B      5
			 
end arc_ROM3;