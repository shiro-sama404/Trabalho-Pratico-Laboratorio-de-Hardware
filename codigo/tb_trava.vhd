library ieee;
use ieee.std_logic_1164.all;

entity tb_trava is
end entity;

architecture testbench of tb_trava is
    signal senha: natural range 0 to 255; -- Número usado como senha para destravar
    signal tempo_para_desarme: natural range 0 to 255 -- Em segundos
    signal clock: std_logic; -- Entrada de clock 1hz para contagem do tempo
    signal reset: std_logic; -- Reset do tempo
    signal input: std_logic_vector(7 downto 0); -- Chaves para destravar
    signal segundos: std_logic_vector(7 downto 0); -- Tempo para desbloqueio
    signal trava: std_logic  -- Sinal de led: 1 para travado, 0 para destravado

begin

    lock: entity work.trava
        generic map (senha, tempo_para_desarme)
        port map (clock, reset, input, segundos, trava);

    stim_proc: process
    begin
        wait;
    end process;
end architecture;