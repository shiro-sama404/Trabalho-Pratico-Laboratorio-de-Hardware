library ieee;
use ieee.std_logic_1164.all;

entity clkdiv is
    generic (
        max     : natural                    -- Frequência do clock que será dividido para 1hz
    );

    port (
        clk_in  : in  std_logic;             -- Entrada de clock
        clk_out : out std_logic              -- Saída: clock dividido
    );

end entity;

architecture behavioral of clkdiv is
begin
    process(clk_in)
        variable aux     : std_logic := '0'; -- Sinal auxiliar para a saída
        variable counter : natural   :=  0 ; -- Mapeamento do clock de entrada
    begin
        if rising_edge(clk_in) then
            counter := counter + 1;

            if counter = max/2 then
                counter := 0;
                aux     := not aux;
                clk_out <= aux;
            end if;
        end if;
    end process;
end architecture;