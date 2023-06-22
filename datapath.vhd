library IEEE;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(
	-- Entradas de dados
	clk: in std_logic;
	SW: in std_logic_vector(17 downto 0);
	
	-- Entradas de controle
	R1, R2, E1, E2, E3, E4, E5: in std_logic;
	
	-- Saídas de dados
	hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0);
	ledr: out std_logic_vector(15 downto 0);
	
	-- Saídas de status
	end_game, end_time, end_round, end_FPGA: out std_logic
);

end entity;

architecture arc of datapath is
---------------------------SIGNALS-----------------------------------------------------------
--contadores
signal tempo, X: std_logic_vector(3 downto 0);
--FSM_clock
signal CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: std_logic;
--Logica combinacional
signal RESULT: std_logic_vector(7 downto 0);
--Registradores
signal SEL: std_logic_vector(3 downto 0);
signal USER: std_logic_vector(14 downto 0);
signal Bonus, Bonus_reg: std_logic_vector(3 downto 0);
--ROMs
signal CODE_aux: std_logic_vector(14 downto 0);
signal CODE: std_logic_vector(31 downto 0);
--COMP
signal erro: std_logic;
--NOR enables displays
signal E23, E25, E12: std_logic;

--signals implícitos--
signal t, C, L: std_logic_vector(6 downto 0);

--dec termometrico
signal stermoround, stermobonus, andtermo: std_logic_vector(15 downto 0);
--decoders HEX 7-0
signal sdecod7, sdec7, sdecod6, sdec6, sdecod5, sdecod4, sdec4, sdecod3, sdecod2, sdec2, sdecod1, sdecod0, sdec0: std_logic_vector(6 downto 0);
signal smuxhex7, smuxhex6, smuxhex5, smuxhex4, smuxhex3, smuxhex2, smuxhex1, smuxhex0: std_logic_vector(6 downto 0);
signal edec2, edec0: std_logic_vector(3 downto 0);
signal mux2_16out: std_logic_vector(15 downto 0);
--saida ROMs
signal srom0, srom1, srom2, srom3: std_logic_vector(31 downto 0);
signal srom0a, srom1a, srom2a, srom3a: std_logic_vector(14 downto 0);
--FSM_clock
signal E2orE3: std_logic;

---------------------------COMPONENTS-----------------------------------------------------------
component counter_time is 
port(
	R, E, clock: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	tc: out std_logic
);
end component;

component counter_round is
port(
	R, E, clock: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	tc: out std_logic
);
end component;

component decoder_termometrico is
 port(
	X: in  std_logic_vector(3 downto 0);
	S: out std_logic_vector(15 downto 0)
);
end component;

component FSM_clock_de2 is
port(
	reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

--component FSM_clock_emu is
--port(
	--reset, E: in std_logic;
	--clock: in std_logic;
	--CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
--);
--end component;

component decod7seg is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component d_code is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component mux2x1_7bits is
port(
	F1,F2: in std_logic_vector(6 downto 0);
	sel: in std_logic;
	F: out std_logic_vector(6 downto 0)
);
end component;

component mux2x1_16bits is
port(
	F1,F2: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	F: out std_logic_vector(15 downto 0)
);
end component;

component mux4x1_1bit is
port(
	F1,F2,F3,F4: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	F: out std_logic
);
end component;

component mux4x1_15bits is
port(
	F1,F2,F3,F4: in std_logic_vector(14 downto 0);
	sel: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(14 downto 0)
);
end component;

component mux4x1_32bits is
port(
	F1,F2,F3,F4: in std_logic_vector(31 downto 0);
	sel: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(31 downto 0)
);
end component;

component registrador_sel is 
port(
	D: in std_logic_vector(3 downto 0);  
	R, E, CLK: in std_logic;
	H: out std_logic_vector(3 downto 0)
);
end component;

component registrador_user is 
port(
	switch: in std_logic_vector(14 downto 0);  
	R, E, CLK: in std_logic;
	user: out std_logic_vector(14 downto 0)
);
end component;

component registrador_bonus is 
port(
	D: in std_logic_vector(3 downto 0);  
	R, E, CLK: in std_logic;
	H: out std_logic_vector(3 downto 0)
);
end component;

component COMP_erro is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end component;

component COMP_end is
port(
	E0: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end component;

component subtracao is
port(
	E0: in std_logic_vector(3 downto 0);
	E1: in std_logic;
	resultado: out std_logic_vector(3 downto 0)
);
end component;

component logica is 
port(
	x, bonus_reg: in std_logic_vector(3 downto 0);
    sel: in std_logic_vector(1 downto 0);
    result: out std_logic_vector(7 downto 0)
);
end component;

component ROM0 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM1 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM2 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM3 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM0a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM1a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM2a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM3a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

-- COMECO DO CODIGO ---------------------------------------------------------------------------------------

begin	

ct: counter_time port map(R1, E3, CLK_1Hz, tempo, end_time);
cr: counter_round port map(R2, E4, clk, x, end_round);
dt1: decoder_termometrico port map(bonus_reg, stermobonus);
dt2: decoder_termometrico port map(x, stermoround);
clock_de2: fsm_clock_de2 port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz);
--clock_emu: fsm_clock_emu port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz);

E2orE3 <= E2 or E3;

decod74: decod7seg port map(result(7 downto 4), sdec7);
decod30: decod7seg port map(result(3 downto 0), sdec6);
decodtempo: decod7seg port map(tempo, sdec4);
decod00sel32: decod7seg port map(edec2, sdec2);
decod00sel10: decod7seg port map(edec0, sdec0);

edec2 <= "00" & SEL(3 downto 2);
edec0 <= "00" & SEL(1 downto 0);

d_code31: d_code port map(code(31 downto 28), sdecod7);
d_code27: d_code port map(code(27 downto 24), sdecod6);
d_code23: d_code port map(code(23 downto 20), sdecod5);
d_code19: d_code port map(code(19 downto 16), sdecod4);
d_code15: d_code port map(code(15 downto 12), sdecod3);
d_code11: d_code port map(code(11 downto 8), sdecod2);
d_code7: d_code port map(code(7 downto 4), sdecod1);
d_code3: d_code port map(code(3 downto 0), sdecod0);

--- mux 2 bits
mux2_7: mux2x1_7bits port map(sdecod7, sdec7, E5, smuxhex7);
mux2_6: mux2x1_7bits port map(sdecod6, sdec6, E5, smuxhex6);
mux2_5: mux2x1_7bits port map(sdecod5, t, E3, smuxhex5);
mux2_4: mux2x1_7bits port map(sdecod4, sdec4, E3, smuxhex4);
mux2_3: mux2x1_7bits port map(sdecod3, C, E1, smuxhex3);
mux2_2: mux2x1_7bits port map(sdecod2, sdec2, E1, smuxhex2);
mux2_1: mux2x1_7bits port map(sdecod1, L, E1, smuxhex1);
mux2_0: mux2x1_7bits port map(sdecod0, sdec0, E1, smuxhex0);

--- mux 2x1 16 bits
mux2_16: mux2x1_16bits port map(andtermo, stermobonus, SW(17), mux2_16out);
andtermo <= stermoround and (not (E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1));

mux4_1: mux4x1_1bit port map(CLK_025Hz, CLK_033Hz, CLK_050Hz, CLk_1Hz, SEL(1 downto 0), end_fpga);

--- mux 15 bits
mux4_15_aux: mux4x1_15bits port map(srom0a, srom1a, srom2a, srom3a, SEL(3 downto 2), code_aux);

--- mux 32 bits
mux4_32_code: mux4x1_32bits port map(srom0, srom1, srom2, srom3, SEL(3 downto 2), code);
--- registradores
reg_sel: registrador_sel port map(SW(3 downto 0), R2, E1, clk, sel);
reg_user: registrador_user port map(SW(14 downto 0), R2, E3, clk, user);
reg_bonus: registrador_bonus port map(bonus, R2, E4, clk, bonus_reg);

erros: comp_erro port map(code_aux, user, erro);
c_end: comp_end port map(bonus_reg, end_game);

sub: subtracao port map(bonus_reg, erro, bonus);

logic: logica port map(x, bonus_reg, sel(1 downto 0), result);

aROM0: ROM0 port map(x, srom0); 
aROM1: ROM1 port map(x, srom1);
aROM2: ROM2 port map(x, srom2);
aROM3: ROM3 port map(x, srom3);

aROM0a: ROM0a port map(x, srom0a);
aROM1a: ROM1a port map(x, srom1a);
aROM2a: ROM2a port map(x, srom2a);
aROM3a: ROM3a port map(x, srom3a);

E23 <= not(E2 or E3);
E25 <= not(E2 or E5);
E12 <= not(E1 or E2);

hex7 <= E25&E25&E25&E25&E25&E25&E25 or smuxhex7;
hex6 <= E25&E25&E25&E25&E25&E25&E25 or smuxhex6;
hex5 <= E23&E23&E23&E23&E23&E23&E23 or smuxhex5;
hex4 <= E23&E23&E23&E23&E23&E23&E23 or smuxhex4;
hex3 <= E12&E12&E12&E12&E12&E12&E12 or smuxhex3;
hex2 <= E12&E12&E12&E12&E12&E12&E12 or smuxhex2;
hex1 <= E12&E12&E12&E12&E12&E12&E12 or smuxhex1;
hex0 <= E12&E12&E12&E12&E12&E12&E12 or smuxhex0;

ledr <= mux2_16out;

t <= "0000111"; -- deixei trocado com c
c <= "1000110"; -- deixei trocado com t
l <= "1000111";

--Conexoes e atribuicoes a partir daqui. Dica: usar os mesmos nomes e I/O ja declarados nos components. Todos os signals necessarios ja estao declarados.

end arc;
