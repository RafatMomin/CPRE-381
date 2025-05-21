library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IF_ID_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_IMem : in std_logic_vector(N-1 downto 0);
         i_PC_4 : in std_logic_vector(N-1 downto 0);
         o_IMem : out std_logic_vector(N-1 downto 0);
         o_PC_4 : out std_logic_vector(N-1 downto 0));
end IF_ID_Registers;

architecture structural of IF_ID_Registers is

  component Pipeline_Register_N is 
   generic(N : integer := 32); 
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_D    : in std_logic_vector(N-1 downto 0);
         o_Q    : out std_logic_vector(N-1 downto 0));
end component;

  begin

    IM: Pipeline_Register_N
      generic map(N => N)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               i_D   => i_IMem,
               o_Q   => o_IMem);

    ADD4: Pipeline_Register_N
      generic map(N => N)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               i_D   => i_PC_4,
               o_Q   => o_PC_4);

end structural;

