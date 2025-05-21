library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Simplified_MIPS is
    port (
        clk          : in std_logic;
        reset        : in std_logic;
        reg_write    : in std_logic;
        mem_read     : in std_logic;
        mem_write    : in std_logic;
        alu_src      : in std_logic;
        mem_to_reg   : in std_logic;
        reg_dst      : in std_logic;
        opcode       : in std_logic_vector(5 downto 0);
        rs, rt, rd   : in std_logic_vector(4 downto 0);
        imm16        : in std_logic_vector(15 downto 0);
        reg_data     : out std_logic_vector(31 downto 0)
    );
end entity Simplified_MIPS;

architecture Structural of Simplified_MIPS is
    component Extender
        port (
            input_16bit  : in std_logic_vector(15 downto 0);
            sign_extend  : in std_logic;
            output_32bit : out std_logic_vector(31 downto 0)
        );
    end component;

    component DataMemory
        port (
            clk          : in std_logic;
            address      : in std_logic_vector(31 downto 0);
            write_data   : in std_logic_vector(31 downto 0);
            read_data    : out std_logic_vector(31 downto 0);
            mem_read     : in std_logic;
            mem_write    : in std_logic
        );
    end component;

    signal alu_result : std_logic_vector(31 downto 0);
    signal mem_data   : std_logic_vector(31 downto 0);
    signal reg_data1  : std_logic_vector(31 downto 0);
    signal reg_data2  : std_logic_vector(31 downto 0);
    signal immediate  : std_logic_vector(31 downto 0);
    signal reg_data_internal : std_logic_vector(31 downto 0) := (others => '0');

begin
    -- Extender instance
    Extender_inst: Extender
        port map (
            input_16bit  => imm16,
            sign_extend  => alu_src,
            output_32bit => immediate
        );

    -- DataMemory instance
    DataMemory_inst: DataMemory
        port map (
            clk         => clk,
            address     => alu_result,
            write_data  => reg_data2,
            read_data   => mem_data,
            mem_read    => mem_read,
            mem_write   => mem_write
        );

    -- ALU and other operations
    -- (Assuming some ALU operations and reg_file are implemented elsewhere)
    -- Add relevant code to connect control signals and data paths.

    -- Output selection
    process(mem_to_reg, alu_result, mem_data)
    begin
        if mem_to_reg = '1' then
            reg_data_internal <= mem_data;
        else
            reg_data_internal <= alu_result;
        end if;
        reg_data <= reg_data_internal;
    end process;
end architecture Structural;
