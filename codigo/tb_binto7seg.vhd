library ieee;
use ieee.std_logic_1164.all;

entity tb_binto7seg is
end entity;

architecture testbench of tb_binto7seg is
    signal input: in std_logic_vector(3 downto 0);    -- Valor binario a ser mostrado
    signal display: out std_logic_vector(7 downto 0); -- Leds do Display de 7 seg.

begin

    lock: entity work.binto7seg
        port map (input, display);

    stim_proc: process
    begin
        wait;
    end process;
end architecture;