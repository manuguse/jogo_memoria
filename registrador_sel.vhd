library IEEE;
use IEEE.Std_Logic_1164.all;

entity registrador_sel is
port (D: in std_logic_vector(3 downto 0);  
	  R, E, CLK: in std_logic;
	  H: out std_logic_vector(3 downto 0));
end registrador_sel;

architecture registrador of registrador_sel is
begin 
	process(CLK, D, R)
	begin
		if (R = '1') then H <= "0000";
		elsif (CLK'event and CLK = '1') then
			if (E = '1') then H <= D;
			end if;
		end if;
	end process;
end registrador;