library IEEE;
use IEEE.std_logic_1164.all;

entity Add_Sub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(iCLK             : in std_logic;
       iC               : in std_logic;
       iA               : in std_logic_vector(N-1 downto 0);
       iB               : in std_logic_vector(N-1 downto 0);
       oC               : out std_logic;
       overflow         : out std_logic;
       oS               : out std_logic_vector(N-1 downto 0));
end Add_Sub_N;

architecture structural of Add_Sub_N is

  component mux2t1_N is
  generic(N : integer := 32);
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

  end component;

  component fullAdder_N is
  generic(N : integer := 32);
   port(iCLK    : in std_logic;
        iA      : in std_logic_vector(N-1 downto 0);
	iB	: in std_logic_vector(N-1 downto 0);
	iC	: in std_logic;
	oC	: out std_logic;
        overflow : out std_logic;
	oS	: out std_logic_vector(N-1 downto 0));
  end component;

  component onesComp_N is
  generic(N : integer := 32);
  port(iX           : in std_logic_vector(N-1 downto 0);
       oO           : out std_logic_vector(N-1 downto 0));

  end component;

  signal s_T         : std_logic_vector(N-1 downto 0);
  signal s_W         : std_logic_vector(N-1 downto 0);

begin
   ones_Comp : onesComp_N
   generic map(N => N)
    port map(iX         => iB,  
       	     oO         => s_W);


  mux2t1N: mux2t1_N 
  generic map(N => N)
  port map( i_S      => iC,
            i_D0     => iB,
            i_D1     => s_W,
            o_O	     => s_T);

  fullAdderN: fullAdder_N 
  generic map(N => N)
  port map( iCLK        => iCLK,
            iA          => iA,
            iB		=> s_T,
	    iC		=> iC,
	    oC		=> oC,
            overflow    => overflow,
	    oS		=> oS);

end structural;
