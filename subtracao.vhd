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

    begin
        resultado <= E0 - E1;

end subtracao;