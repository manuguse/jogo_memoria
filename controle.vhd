library ieee;
use ieee.std_logic_1164.all;

entity controle is port(
   enter, reset, CLOCK: in std_logic;
	end_game, end_time, end_round, end_FPGA: in std_logic;
	R1, R2, E1, E2, E3, E4, E5: out std_logic
	);
end controle;

architecture bhv of controle is
    type STATES is (init,setup, play_fpga, play_user, count_round, check, waitt, result);
    signal EA, PE: states;

    begin

        p1: process(CLOCK, reset)
        begin
            if reset = '1' then
                PE <= init;
            elsif (clock'event and clock = '1') then
                EA <= PE;
            end if;
        end process;

        p2: process(EA, PE, end_game, end_time, end_round, end_FPGA, enter)
        begin
            case EA is

            when init =>
                PE <= setup;
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                R1 <= '1';
                R2 <= '1';

            when setup =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '1';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                if enter = '1' then
                    PE <= play_fpga;
                else
                    PE <= setup;
                end if;

            when play_fpga =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '1';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                if end_FPGA = '1' then
                    PE <= play_user;
                else
                    PE <= play_fpga;
                end if;
            
            when play_user =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '1';
                E4 <= '0';
                E5 <= '0';
                if end_time = '1'  then
                    PE <= result;
					 else
                if enter = '1' then
                    PE <= count_round;
                else	PE <= play_user;
					 end if;
					end if;
            
            when count_round =>
                R1 <= '1';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '1';
                E5 <= '0';
                PE <= check;

            when check =>
                if (end_round = '1' or end_game = '1') then
                    PE <= result;
                else
                    PE <= waitt;
                end if;

            when waitt =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                if enter = '1' then
                    PE <= play_fpga;
                else
                    PE <= waitt;
                end if;

            when result =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '1';
                if enter = '1' then
                    PE <= init;
                else
                    PE <= result;
                end if;
            end case;
        end process;
    end bhv;
