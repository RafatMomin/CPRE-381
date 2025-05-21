library IEEE;
use IEEE.std_logic_1164.all;

entity Hazard_Detection_Unit is
  port(
    -- ID?stage sources
    i_ID_Rs_Addr    : in  std_logic_vector(4 downto 0);
    i_ID_Rt_Addr    : in  std_logic_vector(4 downto 0);

    -- EX?stage write address (after RT_RD_MUX/JALMux)
    i_ID_EX_Rd_Addr : in  std_logic_vector(4 downto 0);
    i_ID_EX_MemRead : in  std_logic;             

    -- Control signals from ID
    i_ID_Branch     : in  std_logic;
    i_BranchTaken   : in  std_logic;
    i_ID_Jump       : in  std_logic;
    i_ID_JR         : in  std_logic;

    -- Outputs
    o_PC_Stall      : out std_logic;
    o_IF_ID_Stall   : out std_logic;
    o_ID_EX_Flush   : out std_logic;
    o_IF_ID_Flush   : out std_logic
  );
end Hazard_Detection_Unit;

architecture Behavioral of Hazard_Detection_Unit is
begin
  process(
    i_ID_Rs_Addr, i_ID_Rt_Addr,
    i_ID_EX_Rd_Addr, i_ID_EX_MemRead,
    i_ID_Branch, i_BranchTaken,
    i_ID_Jump, i_ID_JR
  ) begin
    -- defaults
    o_PC_Stall    <= '0';
    o_IF_ID_Stall <= '0';
    o_ID_EX_Flush <= '0';
    o_IF_ID_Flush <= '0';

    -- 1) Load_use hazard
    if (i_ID_EX_MemRead = '1')
       and ((i_ID_EX_Rd_Addr = i_ID_Rs_Addr)
         or (i_ID_EX_Rd_Addr = i_ID_Rt_Addr)) then
      o_PC_Stall    <= '1';
      o_IF_ID_Stall <= '1';
      o_ID_EX_Flush <= '1';

    -- 2) Control hazard: branch taken, jump, or jr
    elsif (i_ID_Branch = '1' and i_BranchTaken = '1')
       or (i_ID_Jump = '1')
       or (i_ID_JR   = '1') then
      o_IF_ID_Flush <= '1';
      o_ID_EX_Flush <= '1';
    end if;
  end process;
end Behavioral;
