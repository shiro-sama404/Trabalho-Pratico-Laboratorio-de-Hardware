library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trava is
    generic (
        senha: natural range 0 to 255;             -- Número usado como senha para destravar
        tempo_para_desarme: natural range 0 to 255 -- Em segundos
    );

    port (
        clock: in std_logic;                        -- Entrada de clock 1hz para contagem do tempo
        reset: in std_logic;                        -- Reset do tempo
        input: in std_logic_vector(7 downto 0);     -- Chaves para destravar
        segundos: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        trava: out std_logic                        -- Sinal de led: 1 para travado, 0 para destravado
    );

end entity;

architecture behavioral of trava is

begin

    process(reset, clock, input)
        variable input_decimal : natural;
        variable time_mapper   : tempo_para_desarme;
    begin

        if reset = '1' then
            segundos <= std_logic_vector(to_unsigned(time_mapper, 8));
            trava <= '1';

        elsif input'event then

            if trava = '1' and segundos > 0 then

                input_decimal := to_integer(unsigned(input));

                if input_decimal = senha then
                    trava <= '0';
                end if;

            end if;

        elsif clock'event and clock = '1' then

            if trava = '1' and segundos > 0 then
                segundos <= std_logic_vector(unsigned(time_mapper) - 1);
            end if;

        end if;

    end process;
    
end architecture;
