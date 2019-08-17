------------------------------------------------------------------------------
-- Package to Create Random Accress Buffers for various types               --
------------------------------------------------------------------------------
--                                                                          --
-- This program is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------
-- Copyright (C) 2019 L. Dries                                              --
-- Buffer.adb Version 1.00 dd. 14-01-2019  Author L Dries                   --
------------------------------------------------------------------------------1

package body Buffer is

   procedure Set_Buffer( inp : item; nr:integer := 0) is
      El  : Buffer_Pointer := LastBuffer;
      El1 : Buffer_Pointer;
      ok  : boolean;
   begin
      if nr = 0 then
         if El = null then
            El := new Block_Buffer;
            FirstBuffer := El;
            El.next := null;
            LastBuffer := El;
            El.previous := null;
         else
            El1 := El;
            El := new Block_Buffer;
            El1.next := El;
            LastBuffer := El;
            El.next := null;
            El.previous := El1;
         end if;
         El.buf := inp;
         Renumber;
      else
         ok := false;
         El1 := FirstBuffer;
         while not ok loop
            if El1.nr = nr then
               ok := true;
            else
               El1 := El1.next;
               if El1 = null then
                  raise BUFFER_ITEM_OUT_OF_RANGE;
               end if;
            end if;
         end loop;
         El1.buf := inp;
      end if;
   end;

   procedure Insert_Buffer ( inp : item; bp: integer; Dir: Buffer_Dir := after) is
      El  : Buffer_Pointer := FirstBuffer;
      El1 : Buffer_Pointer;
   begin
      if Nr_Items < bp then
         Set_Buffer(inp);
      else
         while bp /= El.nr loop
            El := El.next;
         end loop;
         El1 := new Block_Buffer;
         El1.buf := inp;
         if Dir = after then
            El1.previous := El;
            El1.next := El.next;
            El.next:= El1;
            if El1.next /= null then
               El1.next.previous := El1;
            else
               LastBuffer := El1;
            end if;
         else
            El1.previous := El.previous;
            El1.next := El;
            El.previous := El1;
            if El1.previous /= null then
               El1.previous.next := El1;
            else
               FirstBuffer := El1;
            end if;
            Renumber;
         end if;
      end if;
   end;

   function Get_Buffer( nr : integer) return Item is
      El : Buffer_Pointer := FirstBuffer;
      X  : item;
   begin
      if nr <= Nr_Items then
         while nr > El.nr loop
             El := El.next;
         end loop;
         X := El.buf;
      end if;
      return X;
   end;

   procedure Remove_Buffer( nr : integer) is
      El  : Buffer_Pointer;
      Elb : Buffer_Pointer;
      Ela : Buffer_Pointer;
   begin
      if nr <= Nr_Items then
         El := FirstBuffer;
         while El.nr /= nr loop
            El := El.next;
         end loop;
         Elb := El.previous;
         Ela := El.next;
         if Elb /= null then
            Elb.next := Ela;
         else
            Firstbuffer := El.next;
         end if;
         if Ela /= null then
            Ela.previous := Elb;
         else
            LastBuffer := El.previous;
         end if;
         if Nr_Items = 1 then
            Nr_Items := 0;
            FirstBuffer := null;
            LastBuffer := null;
         else
            Renumber;
         end if;
      end if;
   end;

   procedure Clear_Buffer is
      El  : Buffer_Pointer;
      El1 : Buffer_Pointer;
   begin
      El := FirstBuffer;
      while El /= null loop
         El1 := El.next;
         El.previous := null;
         El.next := null;
         El := El1;
      end loop;
      El := null;
      FirstBuffer := null;
      LastBuffer := null;
      Nr_Items := 0;
   end;

   function Length return integer is
   begin
      return nr_Items;
   end;

   procedure Renumber is
      El : Buffer_Pointer;
      n  : integer := 0;
   begin
      El := FirstBuffer;
      while El /= null loop
         n := n + 1;
         El.nr := n;
         El:= El.next;
      end loop;
      Nr_Items := n;
   end;

end Buffer;
