----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2021 13:39:15
-- Design Name: 
-- Module Name: exp_average - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity exp_average is
    Generic( COUNTWIDTH : integer := 16;
             NBITSSHIFT : integer := 10
           );
    Port ( clk : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (COUNTWIDTH-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (COUNTWIDTH-1 downto 0));
end exp_average;

architecture Behavioral of exp_average is
  signal ystore_d, ystore_q: STD_LOGIC_VECTOR( COUNTWIDTH-1 downto 0 );
  signal ymem, xin, yout : STD_LOGIC_VECTOR( COUNTWIDTH-1 downto 0 );
  signal ymemsigned, xinsigned, ynext, ydiff, yav : SIGNED( COUNTWIDTH-1 downto 0);
begin
  process(clk, ystore_d) begin
    if(clk'event and clk='1') then
      ystore_q <= ystore_d;
    end if;
  end process;
  -- put input in a buffer with a single zero in the MSB so it can be cast to signed
  xin(COUNTWIDTH-1) <= '0';
  xin(COUNTWIDTH-2 downto 0) <= data_in(COUNTWIDTH-1 downto 1);
  -- cast xin to signed
  xinsigned <= signed(xin);
  -- put storage data in a buffer with single zero in MSB so it can be cast to signed
  ymem(COUNTWIDTH-1) <= '0';
  ymem(COUNTWIDTH-2 downto 0) <= ystore_q(COUNTWIDTH-1 downto 1);
  -- cast ymem to signed
  ymemsigned <= signed(ymem);
  -- compute averaged output
  ydiff <= xinsigned - ymemsigned;
  yav <= shift_right(ydiff,NBITSSHIFT)+ymemsigned;
  -- convert averaged output back to std logic vector
  yout <= std_logic_vector(yav);
  ystore_d(COUNTWIDTH-1 downto 1) <=yout(COUNTWIDTH-2 downto 0);
  ystore_d(0) <= '0';
  
  data_out <= ystore_q;
end Behavioral;
