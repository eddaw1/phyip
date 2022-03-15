library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sixteencount is
    Port ( clk : in STD_LOGIC;
           gate_in : in STD_LOGIC;
           count_out : out STD_LOGIC_VECTOR (15 downto 0));
end sixteencount;

architecture Behavioral of sixteencount is
  signal count_d, count_q : UNSIGNED (15 downto 0) := to_unsigned(0,16);
begin
  process(clk, count_d) begin
    if(clk'event and clk='1') then
      count_q <= count_d;
    end if;
  end process;

count_d <= count_q when gate_in='0' else count_q + 1;
count_out<=std_logic_vector(count_q);

end Behavioral;
