library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEM_WB_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic; 
         i_memToReg   : in std_logic;
         o_memToReg   : out std_logic;
         i_halt       : in std_logic;
         i_regWrite   : in std_logic;
         i_loadWord   : in std_logic;
         i_rt         : in std_logic_vector(N-1 downto 0);
         i_rd         : in std_logic_vector(4 downto 0);
	 i_regDest    : in std_logic_vector(1 downto 0);
         i_ALU_Out    : in std_logic_vector(N-1 downto 0);
         i_LoadUnit_Out : in std_logic_vector(N-1 downto 0);
         i_DMEM_Out : in std_logic_vector(N-1 downto 0);
         i_overflow   : in std_logic;
         i_jal        : in std_logic;
 	 i_pc4        : in std_logic_vector(N-1 downto 0);
         i_addr_rt     : in std_logic_vector(4 downto 0);
	 o_rt         : out std_logic_vector(N-1 downto 0);
         o_rd         : out std_logic_vector(4 downto 0);
         o_loadWord   : out std_logic;
         o_regWrite   : out std_logic;
         o_halt       : out std_logic;
         o_regDest : out std_logic_vector(1 downto 0);
	 o_ALU_Out : out std_logic_vector(N-1 downto 0);
         o_LoadUnit_Out : out std_logic_vector(N-1 downto 0);
         o_overflow   : out std_logic;
	 o_jal        : out std_logic;
	 o_pc4        : out std_logic_vector(N-1 downto 0);
      	 o_addr_rt     : out std_logic_vector(4 downto 0);
         o_DMEM_Out : out std_logic_vector(N-1 downto 0)
         );
end MEM_WB_Registers;

architecture structural of MEM_WB_Registers is

   component Pipeline_Register is  
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  
         iSTALL : in std_logic;
         iFLUSH : in std_logic;
         i_D    : in std_logic;
         o_Q    : out std_logic);
  end component;

   component Pipeline_Register_N is 
   generic(N : integer := 32); 
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  
         iSTALL : in std_logic;
         iFLUSH : in std_logic;
         i_D    : in std_logic_vector(N-1 downto 0);
         o_Q    : out std_logic_vector(N-1 downto 0));
  end component;

  begin

     HALT_SIGNAL: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_halt,
               o_Q   => o_halt);

    LDWORD: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_loadWord,
               o_Q   => o_loadWord);

    MEM_TO_REG: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_memToReg,
               o_Q   => o_memToReg);

    REGWRITE: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_regWrite,
               o_Q   => o_regWrite);

      REG_DEST: Pipeline_Register_N
      generic map(N => 2)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_regDest,
               o_Q   => o_regDest);

      R_RT: Pipeline_Register_N
      generic map(N => 32)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_rt,
               o_Q   => o_rt);

    RD_DEST: Pipeline_Register_N
      generic map(N => 5)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_rd,
               o_Q   => o_rd);

      ALU_OUT: Pipeline_Register_N
      generic map(N => 32)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_ALU_Out,
               o_Q   => o_ALU_Out);

      DMEM_OUT: Pipeline_Register_N
      generic map(N => 32)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_DMEM_Out,
               o_Q   => o_DMEM_Out);

      LOADUNIT_OUT: Pipeline_Register_N
      generic map(N => 32)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_LoadUnit_Out,
               o_Q   => o_LoadUnit_Out);

     OVERFLOW: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_overflow,
               o_Q   => o_overflow);
       
      JAL: Pipeline_Register
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_jal,
               o_Q   => o_jal);
      
      PC4: Pipeline_Register_N
      generic map(N => 32)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_pc4,
               o_Q   => o_pc4);

     ADDRT: Pipeline_Register_N
      generic map(N => 5)
      port map(iCLK  => iCLK,
               iRST  => iRST,
               iSTALL => '0',
               iFLUSH => '0',
               i_D   => i_addr_rt,
               o_Q   => o_addr_rt);

end structural;
