library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input   : in  std_logic_vector(3 downto 0); -- Valor binário a ser mostrado
        display : out std_logic_vector(7 downto 0)  -- Leds do Display de 7 seg.
    );
end entity;

architecture behavioral of binto7seg is
begin

    process(input)
    begin
        case input is
            when "0000" =>
                display <= "00000011"; -- 0
            when "0001" =>
                display <= "10011111"; -- 1
            when "0010" =>
				display <= "00100101"; -- 2
            when "0011" =>
                display <= "00001101"; -- 3
            when "0100" =>
                display <= "10011001"; -- 4
            when "0101" =>
                display <= "01001001"; -- 5
            when "0110" =>
                display <= "01000001"; -- 6
            when "0111" =>
                display <= "00011111"; -- 7
            when "1000" =>
                display <= "00000001"; -- 8
            when "1001" =>
                display <= "00011001"; -- 9
            when "1010" =>
                display <= "00010001"; -- A
            when "1011" =>
                display <= "11000001"; -- b
            when "1100" =>
                display <= "01100011"; -- C
            when "1101" =>
                display <= "10000101"; -- d
            when "1110" =>
                display <= "01100001"; -- E
            when "1111" =>
                display <= "01110001"; -- F
            when others =>
                display <= "11111111"; -- padrão (apagado)
        end case;

    end process;
end architecture;
