library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;

entity Forwarding_Unit is
  port(
    -- source register addresses from ID/EX
    i_ID_EX_Rs_Addr   : in  std_logic_vector(4 downto 0);
    i_ID_EX_Rt_Addr   : in  std_logic_vector(4 downto 0);
    -- destination addresses from the two later stages
    i_EX_MEM_Rd_Addr  : in  std_logic_vector(4 downto 0);
    i_MEM_WB_Rd_Addr  : in  std_logic_vector(4 downto 0);
    -- write enable flags
    i_EX_MEM_RegWrite : in  std_logic;
    i_MEM_WB_RegWrite : in  std_logic;
    -- instruction type flags
    i_ID_EX_Shift     : in  std_logic;  
    i_ID_EX_ALUSrc    : in  std_logic;  
    -- outputs to select the four?way mux
    o_ForwardA        : out std_logic_vector(1 downto 0);
    o_ForwardB        : out std_logic_vector(1 downto 0)
  );
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is
begin
  process(
    i_ID_EX_Rs_Addr, i_ID_EX_Rt_Addr,
    i_EX_MEM_Rd_Addr, i_MEM_WB_Rd_Addr,
    i_EX_MEM_RegWrite, i_MEM_WB_RegWrite,
    i_ID_EX_Shift, i_ID_EX_ALUSrc
  ) begin
    -- default: no forwarding
    o_ForwardA <= "00";
    o_ForwardB <= "00";

    -- === operand A (Rs) ===
    -- shift instructions get their shamt straight through
    if i_ID_EX_Shift = '1' then
      o_ForwardA <= "11";
    else
      -- EX_EX hazard (highest priority)
      if i_EX_MEM_RegWrite = '1'
         and i_EX_MEM_Rd_Addr /= "00000"
         and i_EX_MEM_Rd_Addr = i_ID_EX_Rs_Addr then
        o_ForwardA <= "10";
      -- WB_EX hazard (next priority)
      elsif i_MEM_WB_RegWrite = '1'
         and i_MEM_WB_Rd_Addr /= "00000"
         and i_MEM_WB_Rd_Addr = i_ID_EX_Rs_Addr then
        o_ForwardA <= "01";
      end if;
    end if;

    -- === operand B (Rt or immediate) ===
    -- immediates override any forwarding
    if i_ID_EX_ALUSrc = '1' then
      o_ForwardB <= "11";
    else
      -- EX?EX hazard on Rt
      if i_EX_MEM_RegWrite = '1'
          and i_EX_MEM_Rd_Addr /= "00000"
          and i_EX_MEM_Rd_Addr = i_ID_EX_Rt_Addr then
        o_ForwardB <= "10";
      -- WB?EX hazard on Rt
      elsif i_MEM_WB_RegWrite = '1'
          and i_MEM_WB_Rd_Addr /= "00000"
          and i_MEM_WB_Rd_Addr = i_ID_EX_Rt_Addr then
        o_ForwardB <= "01";
      end if;
    end if;
  end process;
end Behavioral;

