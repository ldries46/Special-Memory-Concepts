-----------------------------------------------------------------------
--             Stack A package to create a general stack             --
--                                                                   --
--                   Copyright (C) 2019 L. Dries                     --
--                                                                   --
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 3 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
--                                                                   --
-----------------------------------------------------------------------


package body Stack is

   procedure Push ( Typ : Item ) is
   begin
      if FirstSP = null then
         FirstSP := new Block_Stack;
         LastSP := FirstSP;
      else
         declare
            NewSP : Stack_Pointer;
         begin
            NewSP := FirstSP;
            while NewSP.next /= null loop
               NewSP := NewSP.next;
            end loop;
            NewSP.next := new Block_Stack;
            NewSP.next.previous := NewSP;
            LastSP := NewSP.next;
         end;
      end if;
      Depth := Depth + 1;
      LastSP.typ := Typ;
   end Push;

   function Get return Item is
   begin
      if LastSP = null then
         return Null_Item;
      else
         return LastSP.typ;
      end if;
   end Get;

   procedure Remove is
      OldSP : Stack_Pointer;
   begin
      OldSP := LastSP;
      if FirstSP = LastSP then
         FirstSP := null;
      end if;
      if LastSP /= null then
         LastSP := OldSP.previous;
         if LastSP /= null then
            LastSP.next := null;
         end if;
         Depth := Depth - 1;
         if Depth < 0 then
            Depth := 0;
         end if;
      end if;
   end Remove;

   function Pop return Item is
      value : Item;
   begin
      value := Get;
      Remove;
      return value;
   end Pop;

   procedure Clear is
   begin
      while LastSP /= null loop
         Remove;
      end loop;
   end Clear;

   function Get_Depth return integer is
   begin
      return Depth;
   end;

end Stack;
