library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava is
    generic (
        senha              : natural range 0 to 255; -- Número usado como senha para destravar
        tempo_para_desarme : natural range 0 to 255  -- Em segundos
    );

    port (
        clock              : in std_logic;                     -- Entrada de clock 1hz para contagem do tempo
        reset              : in std_logic;                     -- Reset do tempo
        input              : in std_logic_vector(7 downto 0);  -- Chaves para destravar
        segundos           : out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        travado            : out std_logic                     -- Sinal de led: 1 para travado, 0 para destravado
    );

end entity;

architecture behavioral of trava is

begin
    process(reset, clock, input)
        variable remaining_time : natural   := tempo_para_desarme;
        variable is_locked      : std_logic := '1';
        variable input_decimal  : natural;
    begin
        if reset = '1' then
            remaining_time := tempo_para_desarme;
            is_locked      := '1';
            
        elsif rising_edge(clock) then
            if is_locked = '1' and remaining_time > 0 then
                remaining_time := remaining_time - 1;
                report "Tempo restante: " &natural'image(remaining_time);
            end if;
            
        end if;
            
        if input'event then
            report "Nova entrada";
            if is_locked = '1' and remaining_time > 0 then
                input_decimal := to_integer(unsigned(input));
                report "Senha informada: " &integer'image(input_decimal);

                if input_decimal = senha then
                    report "Conseguiu!";
                    is_locked := '0';
                end if;
            elsif remaining_time <= 0 then
                report "Tempo esgotado!";
            end if;

        end if;
        
        travado  <= is_locked;
        segundos <= std_logic_vector(to_unsigned(remaining_time, 8));
    end process;
    
end architecture;