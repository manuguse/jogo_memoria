library ieee;
use ieee.std_logic_1164.all; 

entity comp_erro is port (
    E0, E1: in std_logic_vector(14 downto 0);
    diferente: out std_logic
);
end comp_erro;

architecture erro of comp_erro is
begin 

diferente <= '0' when (E0 xor E1) = "000000000000000" else '1';
--    process(E0, E1)
--    begin
--    if E0 = E1 then
--        diferente <= '0';
--    else
--        diferente <= '1';
--    end if;
--    end process;
end erro;