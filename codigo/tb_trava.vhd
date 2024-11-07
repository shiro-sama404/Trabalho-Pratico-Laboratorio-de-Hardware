library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trava is
end entity;

architecture test of tb_trava is

    constant senha              : natural range 0 to 255 := 84; -- Número usado como senha para destravar
    constant tempo_para_desarme : natural range 0 to 255 := 10; -- Em segundos

    signal   clock              : std_logic := '0';             -- Entrada de clock 1hz para contagem do tempo
    signal   reset              : std_logic := '0';             -- Reset do tempo
    signal   input              : std_logic_vector(7 downto 0); -- Chaves para destravar

    signal   segundos           : std_logic_vector(7 downto 0); -- Tempo para desbloqueio
    signal   travado            : std_logic;                    -- Sinal de led: 1 para travado, 0 para destravado

begin
    lock: entity work.trava(behavioral)
        generic map (senha, tempo_para_desarme)
        port map (clock, reset, input, segundos, travado);

    -- Geração do clock
    clk_gen : process
    begin
        -- Ciclo de clock de 1 segundo
        while true loop
            clock <= not clock;
            wait for 0.5 sec;
            clock <= not clock;
            wait for 0.5 sec;
        end loop;
        wait;
    end process clk_gen;

    -- Processo de estímulos
    stim_proc : process
        procedure reset_fsm is
        begin
            report "Resetou";

            reset <= '1';
            wait for 1 sec;
            reset <= '0';
            wait for 1 sec;
        end procedure;
    begin
        -- Tentar desbloquear com senha certa fora do tempo de desarme
        reset_fsm;
        wait for 10 sec;

        input <= std_logic_vector(to_unsigned(senha, 8));
        wait for 10 ns;
        assert travado = '1' report "Trava desbloqueada com senha certa fora do tempo de desarme" severity error;
        
        -- Tentar desbloquear com senha errada dentro do tempo de desarme
        reset_fsm;

        input <= std_logic_vector(to_unsigned(111, 8));
        wait for 10 ns;
        assert travado = '1' report "Trava desbloqueada com senha errada dentro do tempo de desarme" severity error;
        
        -- Tentar desbloquear com senha certa dentro do tempo de desarme
        reset_fsm;

        input <= std_logic_vector(to_unsigned(senha, 8));
        wait for 10 ns;
        assert travado = '0' report "Trava bloqueada com senha certa dentro do tempo de desarme" severity error;

        wait;
    end process;
end architecture;