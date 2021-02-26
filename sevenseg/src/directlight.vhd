library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity directlight is
    Port ( clk : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end directlight;

architecture Behavioral of directlight is
  signal fastclk_d, fastclk_q : UNSIGNED (31 downto 0);
  signal fastclklogic : STD_LOGIC_VECTOR (31 downto 0);
  signal slowclk : STD_LOGIC_VECTOR (1 downto 0);
  signal currentword : STD_LOGIC_VECTOR (3 downto 0);
begin
  process(clk,fastclk_d) begin
    if(clk'event and clk='1') then
      fastclk_q <= fastclk_d;
    end if;
  end process;

  fastclk_d <= fastclk_q + 1;
  fastclklogic <= STD_LOGIC_VECTOR(fastclk_q);
  slowclk <= fastclklogic(16 downto 15);
  
  -- anode settings from slow clock
  an <= "1110" when slowclk="00" else 
        "1101" when slowclk="01" else
        "1011" when slowclk="10" else 
        "0111";
        
  -- input bits correctly connected to digit feed from slow clock
  currentword <= data_in(3 downto 0) when slowclk="00" else
                 data_in(7 downto 4) when slowclk="01" else
                 data_in(11 downto 8) when slowclk="10" else
                 data_in(15 downto 12);
                 
  -- write letters correctly given value of bits
  seg <= "1000000" when currentword="0000" else
         "1111001" when currentword="0001" else
         "0100100" when currentword="0010" else
         "0110000" when currentword="0011" else
         "0011001" when currentword="0100" else
         "0010010" when currentword="0101" else
         "0000010" when currentword="0110" else
         "1111000" when currentword="0111" else
         "0000000" when currentword="1000" else
         "0010000" when currentword="1001" else
         "0001000" when currentword="1010" else
         "0000011" when currentword="1011" else
         "1000110" when currentword="1100" else
         "0100001" when currentword="1101" else
         "0000110" when currentword="1110" else
         "0001110";
        
  dp <= '1';

end Behavioral;
