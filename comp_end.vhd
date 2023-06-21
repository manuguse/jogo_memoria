library IEEE;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comp_end is port (
    E0: in std_logic_vector(14 downto 0);
    endgame: out std_logic
);
end comp_end;

architecture comp_end of comp_end is
begin 
    process(E0)
    begin
    if E0 = "000000000000000" then
        endgame <= '1';
    else
        endgame <= '0';
    end if;
    end process;
end comp_end;