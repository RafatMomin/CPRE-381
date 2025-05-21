library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity load_unit is
    port (
        mem_data   : in std_logic_vector(31 downto 0);  -- 32-bit memory output
        addr       : in std_logic_vector(1 downto 0);   -- Byte offset
        load_type  : in std_logic_vector(1 downto 0);   -- 00: lb, 01: lh, 10: lbu, 11: lhu
        q          : out std_logic_vector(31 downto 0)  -- Processed output
    );
end load_unit;

architecture behavioral of load_unit is
    -- Internal signals
    signal byte_selected : std_logic_vector(7 downto 0);
    signal half_selected : std_logic_vector(15 downto 0);
    
begin
    -- Byte selection based on address
    with addr select
        byte_selected <= mem_data(7 downto 0)   when "00",
                         mem_data(15 downto 8)  when "01",
                         mem_data(23 downto 16) when "10",
                         mem_data(31 downto 24) when others;
    
    -- Halfword selection based on address
    with addr(1) select
        half_selected <= mem_data(15 downto 0)  when '0',
                         mem_data(31 downto 16) when others;
    
    process(mem_data, addr, load_type, byte_selected, half_selected)
    begin
        case load_type is
            when "00" =>   -- lb: load byte (sign extended)
                q <= std_logic_vector(resize(signed(byte_selected), 32));
                
            when "01" =>   -- lh: load halfword (sign extended)
                q <= std_logic_vector(resize(signed(half_selected), 32));
                
            when "10" =>   -- lbu: load byte unsigned (zero extended)
                q <= std_logic_vector(resize(unsigned(byte_selected), 32));
                
            when "11" =>   -- lhu: load halfword unsigned (zero extended)
                q <= std_logic_vector(resize(unsigned(half_selected), 32));
                
            when others => -- Default case (shouldn't happen)
                q <= mem_data;
        end case;
    end process;
    
end behavioral;
