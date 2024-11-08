library ieee;
use ieee.std_logic_1164.all;

entity tb_clkdiv is
end entity;

architecture test of tb_clkdiv is
    constant cycle_times       : natural    := 50e6;
    constant cycle_duration    : time       := 20 ns;
    constant expected_duration : time       := 1 sec;

    signal   clk_1             : std_logic;
    signal   clk_50            : std_logic  := '1';
begin
    clkdiv    : entity work.clkdiv(behavioral)
                generic map (cycle_times)
                port    map (clk_50, clk_1);

    clk_gen   : process
    begin
        -- Ciclo de clock de 50 MHz (20 ns)
        while true loop
            wait for cycle_duration;
            clk_50 <= not clk_50;
        end loop;
        wait;    
    end process clk_gen;

    stim_proc : process
    begin
        report "Comeco do teste";

        wait until clk_50 = '0';

        for i in 0 to 1 loop
            wait for expected_duration;
            assert clk_1 = '1' report "Esperava-se 1" severity note;

            wait for expected_duration;
            assert clk_1 = '0' report "Esperava-se 0" severity note;
        end loop;

        report "Fim do teste";
        wait;
    end process;

end architecture;