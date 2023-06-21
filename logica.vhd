library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity logica is port(
    x, bonus_reg: in std_logic_vector(3 downto 0);
    sel: in std_logic_vector(1 downto 0);
    result: out std_logic_vector(7 downto 0)
);
end logica;

architecture resultado of logica is

    begin

    result <= sel&"00000" + ('0'&bonus_reg(2 downto 0))&"000" + ("00"&x(3 downto 2));
    
end resultado;