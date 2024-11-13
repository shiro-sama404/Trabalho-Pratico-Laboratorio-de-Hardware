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
        "00000011",  -- 0
        "10011111",  -- 1
        "00100101",  -- 2
        "00001101",  -- 3
        "10011001",  -- 4
        "01001001",  -- 5
        "01000001",  -- 6
        "00011111",  -- 7
        "00000001",  -- 8
        "00011001",  -- 9
        "00010001",  -- A
        "11000001",  -- b
        "01100011",  -- C
        "10000101",  -- d
        "01100001",  -- E
        "01110001"   -- F
    );

begin
    -- Instância da entidade binto7seg
    seg7: entity work.binto7seg(behavioral)
        port map (input, display);

    -- Processo de estímulos
    stim_proc: process
    begin
        report "!======== Comeco do testbench ========!";

        -- Testar todos os valores de 0 a 15
        for i in 0 to 15 loop
            input <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;

            -- Verifica se o valor do display está correto
            assert display = expected_display(i) report "Erro!!! Numero: '" & integer'image(i) & "' nao mapeado corretamente!" severity error;
        end loop;

        report "!======== Fim do testbench ========!";
        wait;
    end process;
end architecture;