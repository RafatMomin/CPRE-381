library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is

  port(iCLK             : in std_logic;
       iA               : in std_logic;
       iB               : in std_logic;
       iC               : in std_logic;
       oC               : out std_logic;
       oS               : out std_logic);

end fulladder;

architecture structure of fulladder is

   component xorg2
    port(i_A        :in std_logic;
         i_B        :in std_logic;
         o_F        :out std_logic);
  end component;

   component andg2
    port(i_A        :in std_logic;
         i_B        :in std_logic;
         o_F        :out std_logic);
   end component;

  component org2
    port(i_A        :in std_logic;
         i_B        :in std_logic;
         o_F        :out std_logic);
  end component;

   signal s_X    : std_logic;
   signal s_Y    : std_logic;
   signal s_Z    : std_logic;

begin
  xor_one: xorg2
    port MAP(
         i_A => iA,
         i_B => iB,
         o_F => s_X);

  and_one: andg2
    port MAP(
         i_A => iC,
         i_B => s_X,
         o_F => s_Y);

  and_two: andg2
    port MAP(
         i_A => iA,
         i_B => iB,
         o_F => s_Z);

  or_one: org2
    port MAP(
         i_A => s_Y,
         i_B => s_Z,
         o_F => oC);

  xor_two: xorg2
    port MAP (
         i_A => s_X,
         i_B => iC,
         o_F => oS);


end structure;
