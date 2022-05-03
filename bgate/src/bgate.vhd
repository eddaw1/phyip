library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounced_button is
    -- ramp up for 10ns*(2^21-1) or 0.02s. Seems to be about right for the transitions
    -- between the off state and the on state for the push buttons for the BASYS board.
    Generic ( COUNTWIDTH : integer := 21;
              DENOISEWIDTH : integer := 8;
              PREWIDTH : integer := 8);
    Port ( clk : in STD_LOGIC;
           button_in : in STD_LOGIC;
           gate_out : out STD_LOGIC);
end debounced_button;

architecture Behavioral of debounced_button is
  signal cyclecounter_d, cyclecounter_q : UNSIGNED (COUNTWIDTH-1 downto 0) 
                                          := to_unsigned(0,COUNTWIDTH);
  signal bstore_d, bstore_q : STD_LOGIC_VECTOR(DENOISEWIDTH+PREWIDTH-1 downto 0);
  signal all_zeros_pre : STD_LOGIC_VECTOR(PREWIDTH-1 downto 0) := (others => '0');
  signal all_ones_den, all_zeros_den : STD_LOGIC_VECTOR(DENOISEWIDTH-1 downto 0);
  signal prebuf : STD_LOGIC_VECTOR(PREWIDTH-1 downto 0);
  signal swbuf : STD_LOGIC_VECTOR(DENOISEWIDTH-1 downto 0);
begin
  process(clk, cyclecounter_d, bstore_d) begin
    if(clk'event and clk='1') then
      cyclecounter_q <= cyclecounter_d;
      bstore_q <= bstore_d;
    end if;
  end process;
  
  -- set up constants for comparison
  all_zeros_pre <= (others => '0');
  all_ones_den <= (others => '1');
  all_zeros_den <= (others => '0');
  -- set up pre switch state and switch state buffers
  prebuf <= bstore_q(PREWIDTH-1 downto 0);
  swbuf <= bstore_q(DENOISEWIDTH+PREWIDTH-1 downto PREWIDTH);
  -- cyclecounter counts up if its current value is greater than zero.
  -- If it is currently zero, it stays zero unless the button just got pressed,
  -- or just got released (in either case, btnC is equal to not bstore_q, otherwise
  -- btnC is equal to bstore_q, so the first conditional detects presses or releases.
  -- In these cases it increments to 1.
  -- its default behaviour is to stay zero, when it is already zero.
  cyclecounter_d <= cyclecounter_q + 1 when (cyclecounter_q=to_unsigned(0,COUNTWIDTH)) and 
                                           ((swbuf /= all_zeros_den) and (swbuf /= all_ones_den)) and
                                           (prebuf = all_zeros_pre) else
                    cyclecounter_q + 1 when cyclecounter_q/=to_unsigned(0,COUNTWIDTH) else
                    to_unsigned(0,COUNTWIDTH);
  -- register to remember the current state of the button for next cycle
  bstore_d(0) <= button_in;
  bstore_d(DENOISEWIDTH+PREWIDTH-1 downto 1) <= bstore_q(DENOISEWIDTH+PREWIDTH-2 downto 0);
  -- gate output that goes high for exatly one cycle
  gate_out <= '1' when ((swbuf /= all_zeros_den) and (swbuf /= all_ones_den)) and 
                       (prebuf = all_zeros_pre) and
                       cyclecounter_q=to_unsigned(0,COUNTWIDTH)
         else '0';

end Behavioral;
