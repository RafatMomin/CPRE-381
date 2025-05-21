library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp is
   port(iX    :in std_logic;
        oO    :out std_logic);
end onesComp;

architecture structure of onesComp is

  component invg
    port(i_A   :in std_logic;
         o_F   :out std_logic);
  end component;


begin
  invg_bit:  invg port MAP(i_A   =>  iX,
                           o_F   =>  oO);

end structure;