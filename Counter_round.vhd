library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Counter_round is port(

R, E, clock: in std_logic;
Q: out std_logic_vector(3 downto 0);
tc: out std_logic);

end Counter_round;

architecture cr of counter_round is
    signal cont: std_logic_vector(3 downto 0);

        begin
            process(R, E, clock)
            begin
				if(R = '1') then
                  cont <= "0000";
						tc <= '0';
                elsif (clock'event and clock = '1') then
						if E = '1' then
						 cont <= cont + "0001";
                    if cont = "1111" then
							cont <= "1111";
							tc <= '1';
                    else 
							tc<= '0';
                    end if;
                end if;
				end if;    
            end process;
        Q <= cont;
end cr;