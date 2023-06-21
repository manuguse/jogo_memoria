library ieee;
use ieee.std_logic_1164.all; 

entity comp_erro is port (
    E0, E1: in std_logic_vector(14 downto 0);
    diferente: out std_logic
);
end comp_erro;

architecture comp_erro of comp_erro is
begin 
    process(E0, E1)
    begin
    if E0 = E1 then
        diferente <= '0';
    else
        diferente <= '1';
    end if;
    end process;
end comp_erro;