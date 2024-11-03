library ieee;
use ieee.std_logic_1164.all;

entity clk_div is

    generic (
        max: natural;             -- Frequência do clock que será dividido para 1hz
    );

    port (
        clk_in   : in std_logic;   -- Entrada de clock
        clk_out : out std_logic;   -- Saída: clock dividido
    );

end entity;

architecture behavioral of clk_div is

    signal clk_div : std_logic := '0'; -- Sinal auxiliar para a saída

begin

    process(clk_in)
        variable clk_map : natural := 0; -- Mapeamento do clock de entrada
    begin

        if clk_map < max then
            clk_map := clk_map + 1;
        else
            clk_map := 0;
            clk_div <= not clk_div;
        end if;

    end process;

    clk_out < clk_div;

end architecture;