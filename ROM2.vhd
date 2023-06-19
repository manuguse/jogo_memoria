library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM2;

architecture arc_ROM2 of ROM2 is
begin

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "0110" & "1111" & "1011" & "1111" & "1001" & "0101" & "0011" & "1111" when address = "0000" else
--6      des      B      des      9      5      3      des

"1001" & "0101" & "1111" & "0001" & "1111" & "1100" & "0100" & "1111" when address = "0001" else
--9      5      des      1      des      C      4      des

"1000" & "0010" & "1001" & "1111" & "1111" & "0100" & "1011" & "1111" when address = "0010" else
--8      2      9      des      des      4      B      des

"1111" & "0110" & "0010" & "0111" & "1010" & "1111" & "1110" & "1111" when address = "0011" else
--des      6      2      7      A      des      E      des

"0010" & "1111" & "1110" & "1010" & "1111" & "1011" & "1111" & "0000" when address = "0100" else
--2      des      E      A      des      B      des      0

"0001" & "1111" & "1111" & "1111" & "1001" & "0110" & "1110" & "1011" when address = "0101" else
--1      des      des      des      9      6      E      B

"0111" & "0000" & "1001" & "1111" & "0110" & "1111" & "0100" & "1111" when address = "0110" else
--7      0      9      des      6      des      4      des

"1111" & "1011" & "0010" & "0110" & "0001" & "1111" & "1100" & "1111" when address = "0111" else
--des      B      2      6      1      des      C      des

"0100" & "1111" & "1111" & "1111" & "1110" & "1010" & "0111" & "1001" when address = "1000" else
--4      des      des      des      E      A      7      9

"0001" & "1001" & "1111" & "1010" & "1111" & "1110" & "0011" & "1111" when address = "1001" else
--1      9      des      A      des      E      3      des

"1111" & "1001" & "0010" & "1100" & "0011" & "1111" & "1010" & "1111" when address = "1010" else
--des      9      2      C      3      des      A      des

"1111" & "1110" & "0001" & "1000" & "0111" & "0010" & "1111" & "1111" when address = "1011" else
--des      E      1      8      7      2      des      des

"1100" & "0001" & "0101" & "1111" & "0011" & "1111" & "0111" & "1111" when address = "1100" else
--C      1      5      des      3      des      7      des

"0101" & "1111" & "1100" & "1011" & "0000" & "1111" & "1101" & "1111" when address = "1101" else
--5      des      C      B      0      des      D      des

"0000" & "1111" & "0010" & "1111" & "1011" & "1110" & "1111" & "1101" when address = "1110" else
--0      des      2      des      B      E      des      D

"1111" & "0110" & "1111" & "1010" & "0101" & "1001" & "1111" & "1100";
--des      6      des      A      5      9      des      C
			 
end arc_ROM2;