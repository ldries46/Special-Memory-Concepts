-----------------------------------------------------------------------
--             Stack A package to create a general stack            --
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

generic
   type Item is private;
   Null_Item : in Item;
package Stack is

   type Block_Stack is limited private;
   type Stack_Pointer is limited private;

   -----------------------------------------------------------------------------
   -- The procedure Pushes a value Typ of the type Item on the stack adding one
   -- level to the stack
   -----------------------------------------------------------------------------
   procedure Push ( Typ : Item );

   -----------------------------------------------------------------------------
   -- The function reads the last pushed value from the stack but let the stack
   -- intact.
   -----------------------------------------------------------------------------
   function Get return Item;

   -----------------------------------------------------------------------------
   -- The procedure reduces the level of the stack by one
   -----------------------------------------------------------------------------
   procedure Remove;

   -----------------------------------------------------------------------------
   -- The function pops a value of the type Item from the stack reducing the
   -- level of the stack by one in the proces.
   -----------------------------------------------------------------------------
   function Pop return Item;

   -----------------------------------------------------------------------------
   -- The procedure Clears the stack completely
   -----------------------------------------------------------------------------
   procedure Clear;

   -----------------------------------------------------------------------------
   -- The function gets the Stack Depth
   -----------------------------------------------------------------------------
   function Get_Depth return integer;

private
   type Stack_Pointer is access Block_Stack;
   type Block_Stack is record
      typ      : Item;
      previous : Stack_Pointer := null;
      next     : Stack_Pointer := null;
   end record;

   FirstSP     : Stack_Pointer := null;
   LastSP      : Stack_Pointer := null;
   Depth       : integer := 0;
end Stack;
