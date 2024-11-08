library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_binto7seg is
end entity;

architecture testbench of tb_binto7seg is
    signal input   : std_logic_vector(3 downto 0); -- Valor binário a ser mostrado
    signal display : std_logic_vector(7 downto 0); -- Leds do Display de 7 seg.

    -- Matriz com os valores esperados para cada entrada de 0 a 15
    type display_array is array (0 to 15) of std_logic_vector(7 downto 0);

    constant expected_display: display_array := (
        "11111100",  -- 0
        "01100000",  -- 1
        "11011010",  -- 2
        "11110010",  -- 3
        "01100110",  -- 4
        "10110110",  -- 5
        "10111110",  -- 6
        "11100000",  -- 7
        "11111100",  -- 8
        "11100110",  -- 9
        "11101110",  -- A
        "00111110",  -- b
        "10011100",  -- C
        "01111010",  -- d
        "10011110",  -- E
        "10001110"   -- F
    );

begin
    -- Instância da entidade binto7seg
    seg7: entity work.binto7seg(behavioral)
        port map (input, display);

    -- Processo de estímulos
    stim_proc: process
    begin
        report "Começo do teste";

        -- Testar todos os valores de 0 a 15
        for i in 0 to 15 loop
            input <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;

            -- Verifica se o valor do display está correto
            assert display = expected_display(i) report "Erro!!! Numero: '" & integer'image(i) & "' nao mapeado corretamente!" severity error;
        end loop;

        report "Fim do teste";
        wait;
    end process;
end architecture;