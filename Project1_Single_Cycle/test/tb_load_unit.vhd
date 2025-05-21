library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity tb_load_unit is
    -- No ports for a testbench
end tb_load_unit;

architecture behavior of tb_load_unit is
    -- Component declaration for the Unit Under Test (UUT)
    component load_unit
        port (
            mem_data   : in std_logic_vector(31 downto 0);  -- 32-bit memory output
            addr       : in std_logic_vector(1 downto 0);   -- Byte offset
            load_type  : in std_logic_vector(1 downto 0);   -- 00: lb, 01: lh, 10: lbu, 11: lhu
            q          : out std_logic_vector(31 downto 0)  -- Processed output
        );
    end component;

    -- Inputs
    signal mem_data  : std_logic_vector(31 downto 0) := (others => '0');
    signal addr      : std_logic_vector(1 downto 0) := (others => '0');
    signal load_type : std_logic_vector(1 downto 0) := (others => '0');

    -- Outputs
    signal q         : std_logic_vector(31 downto 0);

    -- Load type constants
    constant LB  : std_logic_vector(1 downto 0) := "00";
    constant LH  : std_logic_vector(1 downto 0) := "01";
    constant LBU : std_logic_vector(1 downto 0) := "10";
    constant LHU : std_logic_vector(1 downto 0) := "11";
    
    -- Test case record type
    type test_case_record is record
        mem_data  : std_logic_vector(31 downto 0);
        addr      : std_logic_vector(1 downto 0);
        load_type : std_logic_vector(1 downto 0);
        expected_q : std_logic_vector(31 downto 0);
    end record;
    
    -- Array of test cases
    type test_case_array is array (natural range <>) of test_case_record;
    
    -- Define test cases
    constant test_cases : test_case_array := (
        -- Test Case 1: Load byte (signed) from offset 0 with negative value
        (X"80ABCDEF", "00", LB, X"FFFFFF80"),
        
        -- Test Case 2: Load byte (signed) from offset 1
        (X"12ABCDEF", "01", LB, X"FFFFFFAB"),
        
        -- Test Case 3: Load byte (signed) from offset 2
        (X"1234CDEF", "10", LB, X"FFFFFFCD"),
        
        -- Test Case 4: Load byte (signed) from offset 3
        (X"12345678", "11", LB, X"00000012"),
        
        -- Test Case 5: Load halfword (signed) from offset 0 with negative value
        (X"80ABCDEF", "00", LH, X"FFFF80AB"),
        
        -- Test Case 6: Load halfword (signed) from offset 2
        (X"1234CDEF", "10", LH, X"00001234"),
        
        -- Test Case 7: Load byte unsigned from offset 0 with would-be negative value
        (X"80ABCDEF", "00", LBU, X"00000080"),
        
        -- Test Case 8: Load byte unsigned from offset 1
        (X"12ABCDEF", "01", LBU, X"000000AB"),
        
        -- Test Case 9: Load byte unsigned from offset 2
        (X"1234CDEF", "10", LBU, X"000000CD"),
        
        -- Test Case 10: Load byte unsigned from offset 3
        (X"12345678", "11", LBU, X"00000012"),
        
        -- Test Case 11: Load halfword unsigned from offset 0 with would-be negative value
        (X"80ABCDEF", "00", LHU, X"000080AB"),
        
        -- Test Case 12: Load halfword unsigned from offset 2
        (X"1234CDEF", "10", LHU, X"00001234"),
        
        -- Test Case 13: Edge case - all bits set in memory
        (X"FFFFFFFF", "00", LB, X"FFFFFFFF"),
        
        -- Test Case 14: Edge case - all bits set in memory with halfword
        (X"FFFFFFFF", "00", LH, X"FFFFFFFF"),
        
        -- Test Case 15: Edge case - all zeros in memory
        (X"00000000", "11", LBU, X"00000000")
    );

    -- Helper function to convert a std_logic_vector to a string representing hex
    function vec_to_hex(vec : std_logic_vector) return string is
        variable result : string(1 to vec'length/4);
        variable v : std_logic_vector(vec'length-1 downto 0) := vec;
        variable digit : std_logic_vector(3 downto 0);
        variable nibble : integer;
    begin
        for i in result'range loop
            digit := v((vec'length-1) - (i-1)*4 downto (vec'length) - i*4);
            nibble := to_integer(unsigned(digit));
            case nibble is
                when 0 => result(i) := '0';
                when 1 => result(i) := '1';
                when 2 => result(i) := '2';
                when 3 => result(i) := '3';
                when 4 => result(i) := '4';
                when 5 => result(i) := '5';
                when 6 => result(i) := '6';
                when 7 => result(i) := '7';
                when 8 => result(i) := '8';
                when 9 => result(i) := '9';
                when 10 => result(i) := 'A';
                when 11 => result(i) := 'B';
                when 12 => result(i) := 'C';
                when 13 => result(i) := 'D';
                when 14 => result(i) := 'E';
                when 15 => result(i) := 'F';
                when others => result(i) := 'X';
            end case;
        end loop;
        return result;
    end function;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: load_unit port map (
        mem_data  => mem_data,
        addr      => addr,
        load_type => load_type,
        q         => q
    );

    -- Stimulus process
    stim_proc: process
        variable test_case_idx : integer := 0;
        variable error_count : integer := 0;
    begin
        -- Print test header
        report "Starting Load Unit test bench" severity note;
        report "------------------------------" severity note;
        
        -- Loop through all test cases
        for i in test_cases'range loop
            -- Apply test case inputs
            mem_data <= test_cases(i).mem_data;
            addr <= test_cases(i).addr;
            load_type <= test_cases(i).load_type;
            
            -- Wait for combinational logic to settle
            wait for 10 ns;
            
            -- Verify output
            if q /= test_cases(i).expected_q then
                report "Test case " & integer'image(i) & " FAILED" severity error;
                report "mem_data: 0x" & vec_to_hex(test_cases(i).mem_data) severity error;
                report "addr: " & integer'image(to_integer(unsigned(test_cases(i).addr))) severity error;
                report "load_type: " & integer'image(to_integer(unsigned(test_cases(i).load_type))) severity error;
                report "Expected: 0x" & vec_to_hex(test_cases(i).expected_q) severity error;
                report "Got: 0x" & vec_to_hex(q) severity error;
                error_count := error_count + 1;
            else
                report "Test case " & integer'image(i) & " PASSED" severity note;
            end if;
            
            wait for 10 ns;  -- Add a small delay between test cases
        end loop;
        
        -- Report test results
        if error_count = 0 then
            report "All tests PASSED!" severity note;
        else
            report "Tests completed with " & integer'image(error_count) & " errors." severity error;
        end if;
        
        -- End simulation
        wait;
    end process;
end behavior;