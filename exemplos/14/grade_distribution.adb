-- Grade Distribution
-- Input: A list of integer values that represent grades, followed by a negative number
-- Output: A distribution of grades, as a percentage for each of the categories 0-9, 10-19, ..., 90-100
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Grade_Distribution is
  Freq: array(1..10) of Integer := (others => 0);
  New_Grade: Natural;
  Index, Limit_1, Limit_2 : Integer;
begin
  Grade_Loop:
  loop
    begin
      -- A block for the negative input exception
      Get(New_Grade);
      exception
        -- For negative input
        when Constraint_Error =>
          exit Grade_Loop;
    end;
    Index := New_Grade / 10 + 1;
    begin
      -- A block for the subscript range handler
      Freq(Index) := Freq(Index) + 1;
      exception
        -- For index range erros
        when Constraint_Error =>
          if New_grade = 100 then
            Freq(10) := Freq(10) + 1;
          else
            Put("Error -- new grade:");
            Put(New_Grade);
            Put(" is out of range");
            New_Line;
          end if;
    end;
  end loop Grade_Loop;
  -- Output
  Put("Limits frequency");
  New_Line;
  New_Line;
  for Index in 0..9 loop
    Limit_1 := 10 * Index;
    Limit_2 := Limit_1 + 9;
    if Index = 9 then
      Limit_2 := 100;
    end if;
    Put(Limit_1);
    Put(Limit_2);
    Put(Freq(Index + 1));
    New_Line;
  end loop;
end Grade_Distribution;
