library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BarrelShifter is
    port (
        input      : in std_logic_vector(31 downto 0); -- Data to shift
        shift_amt  : in std_logic_vector(31 downto 0); -- Shift amount (only lower 5 bits used)
        ALUOp      : in std_logic_vector(3 downto 0);  -- ALU operation code
        output     : out std_logic_vector(31 downto 0) -- Shifted output
    );
end BarrelShifter;

architecture behavioral of BarrelShifter is
begin
    process(input, shift_amt, ALUOp)
        variable shift_val : integer range 0 to 31;
    begin
        -- Extract the shift amount (only 5 bits needed)
        shift_val := to_integer(unsigned(shift_amt(4 downto 0)));
        
        -- Perform the appropriate shift operation based on ALUOp
        case ALUOp is
            when "0111" => -- Shift Left Logical (SLL, SLLV)
                if shift_val = 0 then
                    output <= input;
                else
                    output <= std_logic_vector(shift_left(unsigned(input), shift_val));
                end if;
                
            when "1000" => -- Shift Right Logical (SRL, SRLV)
                if shift_val = 0 then
                    output <= input;
                else
                    output <= std_logic_vector(shift_right(unsigned(input), shift_val));
                end if;
                
            when "1001" => -- Shift Right Arithmetic (SRA, SRAV)
                if shift_val = 0 then
                    output <= input;
                else
                    output <= std_logic_vector(shift_right(signed(input), shift_val));
                end if;
                
            when others => -- For any other ALU operation
                output <= input;
        end case;
    end process;
end behavioral;
