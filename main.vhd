library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is

    port (
        clock    : in  std_logic;                                            -- Entrada de clock 50mhz para contagem do tempo
        reset    : in  std_logic;                                            -- Reset do tempo
        input    : in  std_logic_vector(7 downto 0);                         -- Chaves para destravar
        display1 : out std_logic_vector(7 downto 0);                         -- display do mais significativo
        display2 : out std_logic_vector(7 downto 0);                         -- display do menos significativo
        travado  : out std_logic                                             -- Sinal de led: 1 para travado, 0 para destravado
    );

end entity;

architecture structural of main is

    constant cycles_fpga        : natural                       := 50000000; -- frequência do clock da fpga
    constant senha              : natural range 0 to 255        := 180     ; -- Número usado como senha para destravar
    constant tempo_para_desarme : natural range 0 to 255        := 10      ; -- Em segundos

    signal   segundos           : std_logic_vector(7 downto 0);              -- Tempo para desbloqueio
    signal   clk_50             : std_logic;                                 -- clock divido para 1hz

begin

    clk_div    : entity  work.clkdiv(behavioral)
                 generic map(cycles_fpga)
                 port    map(clock, clk_50);
    
    trava      : entity  work.trava(behavioral)
                 generic map(senha, tempo_para_desarme)
                 port    map(clk_50, reset, input, segundos, travado);

    binto7seg1 : entity  work.binto7seg(behavioral)
                 port    map(segundos(7 downto 4), display1);
    
    binto7seg2 : entity  work.binto7seg(behavioral)
                 port    map(segundos(3 downto 0), display2);

end architecture;
