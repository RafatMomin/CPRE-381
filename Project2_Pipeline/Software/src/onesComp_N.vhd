library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(iX         : in std_logic_vector(N-1 downto 0);
       oO          : out std_logic_vector(N-1 downto 0));

end onesComp_N;

architecture structural of onesComp_N is

  component onesComp is
    port(iX                   : in std_logic;
         oO                   : out std_logic);
  end component;

begin

G_NBit_OC: for i in 0 to N-1 generate
    OC: onesComp port map(
              iX       => iX(i),      -- All instances share the same select input.
              oO       => oO(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_OC;

end structural;