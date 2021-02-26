library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sixteencounter is
    Port ( pushit : in STD_LOGIC;
           clk : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (15 downto 0));
end sixteencounter;

architecture Behavioral of sixteencounter is
  signal count_d, count_q : UNSIGNED (15 downto 0)
                            := to_unsigned(0,16);
begin
  process(clk, count_d) begin
    if(clk'event and clk='1') then
      count_q <= count_d;
    end if;
  end process;
  
  count_d <= count_q + 1 when pushit='1' else count_q;
  count <= STD_LOGIC_VECTOR(count_q);

end Behavioral;
