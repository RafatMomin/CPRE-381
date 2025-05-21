library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder_N is
  generic(N : integer := 32);
  port( iCLK    :   in std_logic;
	iC     :   in std_logic;
        iA     :   in std_logic_vector(N-1 downto 0);
        iB     :   in std_logic_vector(N-1 downto 0);
        oC     :   out std_logic;
        overflow : out std_logic;
        oS     :   out std_logic_vector(N-1 downto 0));

end fullAdder_N;

architecture structural of fullAdder_N is

  component fullAdder is
    port(iCLK             : in std_logic;
         iA               : in std_logic;
         iB               : in std_logic;
         iC               : in std_logic;
         oC               : out std_logic;
         oS               : out std_logic);

end component;  

   component xorg2 is
     port(i_A   : in std_logic;
          i_B   : in std_logic;
          o_F   : out std_logic);

   end component;


signal s_C  :  std_logic_vector(N-1 downto 0);
signal finalCarry : std_logic;

begin

  startAdd: for i in 0 to 0 generate
    fullAdd: fullAdder port map(
	iCLK =>  iCLK,
	iC   =>  iC,
	iA   =>  iA(0),
	iB   =>  iB(0),
	oC   =>  s_C(0),
        oS   =>  oS(0));
   end generate startAdd;

  ripAddn: for i in 1 to N-2 generate
    fullAdd: fullAdder port map(
	iCLK =>  iCLK,
	iC   =>  s_C(i-1),
	iA   =>  iA(i),
	iB   =>  iB(i),
	oC   =>  s_C(i),
        oS   =>  oS(i));
   end generate ripAddn;

  
    fullAdd: fullAdder port map(
	iCLK =>  iCLK,
	iC   =>  s_C(N-2),
	iA   =>  iA(N-1),
	iB   =>  iB(N-1),
	oC   =>  finalCarry,
        oS   =>  oS(N-1));

   oC <= finalCarry;

   over: xorg2 port map(
     i_A => s_C(N-2),
     i_B => finalCarry,
     o_F => overflow);


end structural;

