-----------------------------------------------------------------------
--             Pipe A package to create a general Pipe               --
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

package body Pipe is

   procedure Push ( Typ : Item ) is
   begin
      if FirstPP = null then
         FirstPP := new Block_Pipe;
         LastPP := FirstPP;
      else
         declare
            NewPP : Pipe_Pointer;
         begin
            NewPP := FirstPP;
            while NewPP.next /= null loop
               NewPP := NewPP.next;
            end loop;
            NewPP.next := new Block_Pipe;
            NewPP.next.previous := NewPP;
            LastPP := NewPP.next;
         end;
      end if;
      Length := Length + 1;
      LastPP.typ := Typ;
   end Push;

   function Get return Item is
   begin
      if FirstPP = null then
         return Null_Item;
      else
         return FirstPP.typ;
      end if;
   end Get;

   procedure Remove is
      OldPP : Pipe_Pointer;
   begin
      OldPP := FirstPP;
      if FirstPP = LastPP then
         FirstPP := null;
      else
         FirstPP := OldPP.next;
      end if;
      Length := Length - 1;
      if Length < 0 then
         Length := 0;
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
      while FirstPP /= null loop
         Remove;
      end loop;
   end Clear;

   function Get_Length return integer is
   begin
      return Length;
   end Get_Length;

end Pipe;
