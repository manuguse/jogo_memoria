library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Counter_time is port(

R, E, clock: in std_logic;
Q: out std_logic_vector(3 downto 0);
tc: out std_logic);

end Counter_time;

architecture counter of Counter_time is

    signal cont: std_logic_vector(3 downto 0) := "1010";

    begin
        process(R, E, clock)
        begin
            if (clock'event and clock = '1') then
                if (cont > "0000" and E = '1') then
                    cont <= cont - "0001";
                end if;
            end if;
        
            if(R = '1') then
                cont <= "1010";
            end if;
        end process;

    tc <= '1' when cont = "0000" else '0';
    Q <= cont;
end counter;
