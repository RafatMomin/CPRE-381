library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Extender is
  port(iX   : in std_logic_vector(15 downto 0);
       iSel : in std_logic;
       oX   : out std_logic_vector(31 downto 0));
end Extender;

architecture dataflow of Extender is
begin

  oX <= (31 downto 16 => '0') & iX when iSel = '0' else
        (31 downto 16 => iX(15)) & iX;

end dataflow;
