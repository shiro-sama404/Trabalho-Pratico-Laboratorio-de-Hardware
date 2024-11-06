library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_trava is
end entity;

architecture testbench of tb_trava is

    signal senha: natural range 0 to 255 := 84;             -- Número usado como senha para destravar
    signal tempo_para_desarme: natural range 0 to 255 := 10; -- Em segundos
    signal clock: std_logic;                                -- Entrada de clock 1hz para contagem do tempo
    signal reset: std_logic;                                -- Reset do tempo
    signal input: std_logic_vector(7 downto 0);             -- Chaves para destravar
    signal segundos: std_logic_vector(7 downto 0);          -- Tempo para desbloqueio
    signal trava: std_logic;                                 -- Sinal de led: 1 para travado, 0 para destravado

begin

    lock: entity work.trava
        generic map (senha, tempo_para_desarme)
        port map (clock, reset, input, segundos, trava);

    -- Geração do clock
    clk_process : process
    begin
        -- Ciclo de clock de 1 segundo
        while true loop
            clock <= '1';
            wait for 0.5 sec;  
            clock <= '0';
            wait for 0.5 sec;
        end loop;
    end process;

    -- Processo de estímulos
    stim_proc : process
    begin
        -- Início com reset
        reset <= '1';
        wait for 1 sec;
        reset <= '0';
        wait for 1 sec;

        -- Tenta desbloquear com senha errada dentro do tempo de desarme
        input <= std_logic_vector(to_unsigned(111, 8));
        wait for 10 ns;
        assert trava = '1' report "Trava desbloquada com senha errada dentro do tempo de desarme" severity error;
        wait for 9 sec;

        -- Tentar desbloquear com senha certa fora do tempo de desarme
        input <= std_logic_vector(to_unsigned(senha, 8));
        wait for 10 ns;
        assert trava = '1' report "Trava desbloquada com senha certa fora do tempo de desarme" severity error;

        -- reset
        reset <= '1';
        wait for 1 sec;
        reset <= '0';
        wait for 1 sec;

        -- Tentar desbloquear com senha certa dentro do tempo de desarme
        input <= std_logic_vector(to_unsigned(senha, 8));
        assert trava = '0' report "Trava bloqueada com senha certa dentro do tempo de desarme" severity error;
        wait for 2 sec;

        wait;
    end process;
end architecture;
