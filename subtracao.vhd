library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity subtracao is port(
    E0: in std_logic_vector(3 downto 0);
    E1: in std_logic;
    resultado: out std_logic_vector(3 downto 0)
);
end subtracao;

architecture subtracao of subtracao is
	signal e1_4bits: std_logic_vector(3 downto 0);
    begin
		e1_4bits <= e1&e1&e1&e1;
        resultado <= E0 + e1_4bits;

end subtracao;