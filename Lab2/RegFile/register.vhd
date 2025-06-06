library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegFile is
    Port (
        clk          : in STD_LOGIC;
        rst          : in STD_LOGIC;
        write_enable : in STD_LOGIC;
        read_addr1   : in STD_LOGIC_VECTOR (4 downto 0);
        read_addr2   : in STD_LOGIC_VECTOR (4 downto 0);
        write_addr   : in STD_LOGIC_VECTOR (4 downto 0);
        write_data   : in STD_LOGIC_VECTOR (31 downto 0);
        read_data1   : out STD_LOGIC_VECTOR (31 downto 0);
        read_data2   : out STD_LOGIC_VECTOR (31 downto 0)
    );
end RegFile;

architecture Structural of RegFile is
    type reg_array_type is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal reg_array : reg_array_type;

    -- Decoder and MUX signals
    signal write_enable_decoded : STD_LOGIC_VECTOR (31 downto 0);
begin
    -- Initialize Reg0 to all zeros
    process (rst)
    begin
        if rst = '1' then
            reg_array(0) <= (others => '0');
        end if;
    end process;

    -- Write process
    process (clk)
    begin
        if rising_edge(clk) then
            if write_enable = '1' then
                for i in 1 to 31 loop
                    if write_enable_decoded(i) = '1' then
                        reg_array(i) <= write_data;
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- Decoder logic
    process (write_addr)
    begin
        write_enable_decoded <= (others => '0');
        if write_enable = '1' then
            write_enable_decoded(conv_integer(unsigned(write_addr))) <= '1';
        end if;
    end process;

    -- Read process
    process (read_addr1, read_addr2, reg_array)
    begin
        read_data1 <= reg_array(conv_integer(unsigned(read_addr1)));
        read_data2 <= reg_array(conv_integer(unsigned(read_addr2)));
    end process;
end Structural;

