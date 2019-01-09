library ieee;
use ieee.std_logic_1164.all;

entity lfsr8 is
  port (clk : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        seed : in std_logic_vector(7 downto 0);
        random : out std_logic_vector(7 downto 0));
end lfsr8;

architecture funcional of lfsr8 is
  signal lfsr_reg : std_logic_vector(7 downto 0);
begin

  process(clk, reset)
  begin
    if(reset='1') then
      lfsr_reg <= (others=>'0');
    elsif(clk'event and clk='1') then
      if(load='1') then
        lfsr_reg <= seed;
      else
        lfsr_reg(0) <= lfsr_reg(7);
        lfsr_reg(1) <= lfsr_reg(0);
        lfsr_reg(2) <= lfsr_reg(1) xnor lfsr_reg(7);
        lfsr_reg(3) <= lfsr_reg(2) xnor lfsr_reg(7);
        lfsr_reg(4) <= lfsr_reg(3) xnor lfsr_reg(7);
        lfsr_reg(5) <= lfsr_reg(4);
        lfsr_reg(6) <= lfsr_reg(5);
        lfsr_reg(7) <= lfsr_reg(6);
      end if;
    end if;
  end process;

  random <= lfsr_reg;

end architecture;


library ieee;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture funcional of test is
  signal clk : std_logic :='0';
  signal reset : std_logic;
  signal random : std_logic_vector(7 downto 0);
  signal load : std_logic;
  signal seed : std_logic_vector(7 downto 0);

begin

  UUT : entity work.lfsr8(funcional) port map(clk, reset, load, seed, random);
  
  clk <= not(clk) after 10 ns;
  reset <= '1', '0' after 40 ns;
  seed <= "01100110";
  load <= '0', '1' after 300 ns, '0' after 340 ns;

end architecture;
