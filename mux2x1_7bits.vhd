library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2x1_7bits is
port (F1,F2: in std_logic_vector(6 downto 0);
sel: in std_logic;
F: out std_logic_vector(6 downto 0)
);
end mux2x1_7bits;

architecture circuito of mux2x1_7bits is
begin
F <= F1 when sel = '0' else
	  F2 when sel = '1';
end circuito;