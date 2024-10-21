library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input: in std_logic_vector(3 downto 0);    -- Valor binario a ser mostrado
        display: out std_logic_vector(7 downto 0); -- Leds do Display de 7 seg.
    );
end entity;

architecture behavioral of trava is

begin

    process(input)
    begin
        case input is
            when "0000" =>
                display <= ""; 
            when "0001" =>
                display <= ""; 
            when "0010" =>
                display <= ""; 
            when "0011" =>
                display <= ""; 
            when "0100" =>
                display <= ""; 
            when "0101" =>
                display <= ""; 
            when "0110" =>
                display <= ""; 
            when "0111" =>
                display <= ""; 
            when "1000" =>
                display <= ""; 
            when "1001" =>
                display <= ""; 
            when "1010" =>
                display <= ""; 
            when "1011" =>
                display <= ""; 
            when "1100" =>
                display <= ""; 
            when "1101" =>
                display <= ""; 
            when "1110" =>
                display <= ""; 
            when "1111" =>
                display <= ""; 
        end case;
    end process;

end architecture;