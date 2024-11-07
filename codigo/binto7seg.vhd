library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input   : in std_logic_vector(3 downto 0); -- Valor binario a ser mostrado
        display : out std_logic_vector(7 downto 0) -- Leds do Display de 7 seg.
    );
end entity;

architecture behavioral of binto7seg is
begin

    process(input)
    begin
        case input is
            when "0000" =>
                display <= "11111100"; -- 0
            when "0001" =>
                display <= "01100000"; -- 1
            when "0010" =>
                display <= "11011010"; -- 2
            when "0011" =>
                display <= "11110010"; -- 3
            when "0100" =>
                display <= "01100110"; -- 4
            when "0101" =>
                display <= "10110110"; -- 5
            when "0110" =>
                display <= "10111110"; -- 6
            when "0111" =>
                display <= "11100000"; -- 7
            when "1000" =>
                display <= "11111100"; -- 8
            when "1001" =>
                display <= "11100110"; -- 9
            when "1010" =>
                display <= "11101110"; -- A
            when "1011" =>
                display <= "00111110"; -- b
            when "1100" =>
                display <= "10011100"; -- C
            when "1101" =>
                display <= "01111010"; -- d
            when "1110" =>
                display <= "10011110"; -- E
            when "1111" =>
                display <= "10001110"; -- F
            when others =>
                display <= "00000000"; -- padrão
        end case;

    end process;
end architecture;