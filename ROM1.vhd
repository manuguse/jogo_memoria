library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM1;

architecture arc_ROM1 of ROM1 is
begin

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "1001" & "1111" & "1111" & "0010" & "1010" & "0001" & "1111" & "1111" when address = "0000" else
--9      des      des      2      A      1      des      des

"1111" & "1111" & "1111" & "1111" & "0101" & "1100" & "0001" & "1000" when address = "0001" else
--des      des      des      des      5      C      1      8

"1011" & "1111" & "1100" & "1111" & "1111" & "1001" & "0011" & "1111" when address = "0010" else
--B      des      C      des      des      9      3      des

"0001" & "1111" & "0111" & "1100" & "1111" & "1111" & "1111" & "0110" when address = "0011" else
--1      des      7      C      des      des      des      6

"1111" & "0111" & "0110" & "1111" & "1111" & "1111" & "1101" & "1110" when address = "0100" else
--des      7      6      des      des      des      D      E

"1111" & "1011" & "1100" & "1111" & "1111" & "0111" & "1111" & "0110" when address = "0101" else
--des      B      C      des      des      7      des      6

"1101" & "1111" & "0100" & "1111" & "1111" & "1010" & "0110" & "1111" when address = "0110" else
--D      des      4      des      des      A      6      des

"1111" & "1110" & "0110" & "1111" & "1001" & "1111" & "0101" & "1111" when address = "0111" else
--des      E      6      des      9      des      5      des

"0011" & "1101" & "1111" & "1111" & "1010" & "0111" & "1111" & "1111" when address = "1000" else
--3      D      des      des      A      7      des      des

"1111" & "1111" & "1111" & "1001" & "0000" & "0111" & "1111" & "0001" when address = "1001" else
--des      des      des      9      0      7      des      1

"1111" & "1111" & "1111" & "1111" & "1001" & "0111" & "1100" & "1000" when address = "1010" else
--des      des      des      des      9      7      C      8

"0100" & "1001" & "1101" & "0010" & "1111" & "1111" & "1111" & "1111" when address = "1011" else
--4      9      D      2      des      des      des      des

"1101" & "1111" & "0010" & "1111" & "1111" & "1111" & "0100" & "0110" when address = "1100" else
--D      des      2      des      des      des      4      6

"1111" & "1010" & "1111" & "1111" & "1111" & "1110" & "1100" & "0111" when address = "1101" else
--des      A      des      des      des      E      C      7

"1101" & "1111" & "1111" & "1001" & "1010" & "1111" & "1011" & "1111" when address = "1110" else
--D      des      des      9      A      des      B      des

"0111" & "0001" & "0100" & "1111" & "0110" & "1111" & "1111" & "1111";
--7      1      4      des      6      des      des      des
			 
end arc_ROM1;