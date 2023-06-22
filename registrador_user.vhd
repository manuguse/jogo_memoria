library IEEE;
use IEEE.Std_Logic_1164.all;

entity registrador_user is
port (switch: in std_logic_vector(14 downto 0);  
	  R, E, CLK: in std_logic;
	  user: out std_logic_vector(14 downto 0));
end registrador_user;

architecture registrador of registrador_user is
begin 
	process(CLK, R, E)
	begin
		if (R = '1') then user <= "000000000000000";
		elsif (CLK'event and CLK = '1') then
			if (E = '1') then user <= switch;
			end if;
		end if;
	end process;
end registrador;