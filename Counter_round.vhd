library ieee;
use ieee.std_logic_1164.all; 

entity Counter_round is port(

    R2, E4, CLOCK_50: in  std_logic;
    end_round: out std_logic;
    x: out std_logic_vector(3 downto 0));

end Counter_round;
