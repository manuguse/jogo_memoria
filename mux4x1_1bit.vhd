library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux4x1_1bit is
port (F1,F2,F3,F4: in std_logic;
sel: in std_logic_vector(1 downto 0);
F: out std_logic);
end mux4x1_1bit;

architecture circuito of mux4x1_1bit is
begin
F <= F1 when sel = "00" else
	  F2 when sel = "01" else
	  F3 when sel = "10" else
	  F4; -- 11
end circuito;