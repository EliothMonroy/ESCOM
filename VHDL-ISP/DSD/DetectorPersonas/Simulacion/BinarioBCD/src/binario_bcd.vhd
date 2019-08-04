library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity bin_bcd is
    PORT(
        salida: inout  STD_LOGIC_VECTOR(7 downto 0);
        displays: out STD_LOGIC_VECTOR(7 downto 0)
    );
end bin_bcd;
-- basado del código encontrado en: http://www.estadofinito.com/binario-bcd-7seg/
architecture convertir of bin_bcd is
begin
    convertidor: process(salida)
        variable aux: STD_LOGIC_VECTOR(15 downto 0);
    begin
        -- Inicializamos todos los datos en cero.
        aux := (others => '0');
        -- Cargamos los datos por primera vez.
        aux(7 downto 0) := salida;
        -- Por cada bit habrá que hacer un corrimiento a la izquierda
        for i in 0 to 7 loop
            -- Unidades (4 bits).
            if aux(11 downto 8) > 4 then
                aux(11 downto 8) := aux(11 downto 8) + 3;
            end if;
            -- Decenas (4 bits).
            if aux(15 downto 12) > 4 then
                aux(15 downto 12) := aux(15 downto 12) + 3;
            end if;
            -- Corrimiento a la iauxquierda.
            aux(15 downto 1) := aux(14 downto 0);
        end loop;
        -- Pasando datos de variable aux, correspondiente a BCD.
        displays <= aux(15 downto 8);
    end process convertidor;
end convertir;