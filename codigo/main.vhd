library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trava is

    port (
        clock   : in std_logic;                        -- Entrada de clock 50mhz para contagem do tempo
        reset   : in std_logic;                        -- Reset do tempo
        input   : in std_logic_vector(7 downto 0);     -- Chaves para destravar
        display : out std_logic;                       -- display
        trava   : out std_logic;                       -- Sinal de led: 1 para travado, 0 para destravado
    );

end entity;

architecture behavioral of trava is

    signal senha              : natural range 0 to 255 := 180; -- Número usado como senha para destravar
    signal tempo_para_desarme : natural range 0 to 255 := 10   -- Em segundos
    signal segundos           : std_logic_vector(7 downto 0);  -- Tempo para desbloqueio
    signal clk_50             : std_logic;                     -- clock divido para 1hz

begin

    clk_div   : entity work.clk_div(behavioral)
         generic map(50000000)
         port    map(clock, clk_50);
    
    binto7seg : entity work.binto7seg(behavioral)
         port    map(segundos, display);

    trava     : entity work.trava(behavioral)
         generic map(senha, tempo_para_desarme)
         port    map(clk_50, reset, input, segundos, trava);

end architecture;