library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava is
    generic (
        senha              : natural range 0 to 255 := 0;      -- Número usado como senha para destravar
        tempo_para_desarme : natural range 0 to 255 := 0       -- Em segundos
    );

    port (
        clock              : in  std_logic;                    -- Entrada de clock 1hz para contagem do tempo
        reset              : in  std_logic;                    -- Reset do tempo
        input              : in  std_logic_vector(7 downto 0); -- Chaves para destravar
        segundos           : out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        travado            : out std_logic                     -- Sinal de led: 1 para travado, 0 para destravado
    );

end entity;

architecture behavioral of trava is

begin
    process(reset, clock, input)
        variable remaining_time : natural   := tempo_para_desarme;
    begin
		  
        if reset = '1' then
            remaining_time := tempo_para_desarme;
            travado        <= '1';
            
        elsif rising_edge(clock) then
            if remaining_time > 0 then
                if to_integer(unsigned(input)) /= senha then
                    remaining_time := remaining_time - 1;
                    travado <= '1';
                else
                    travado <= '0';
                end if;
            end if;
        end if;

        segundos <= std_logic_vector(to_unsigned(remaining_time, 8));
    end process;
    
end architecture;
