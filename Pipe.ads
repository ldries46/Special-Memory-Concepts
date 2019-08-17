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

generic
   type Item is private;
   Null_Item : in Item;
package Pipe is

   type Block_Pipe is limited private;
   type Pipe_Pointer is limited private;

   -----------------------------------------------------------------------------
   -- The procedure Pushes a value Typ of the type Item in the pipe adding one
   -- length to the pipe
   -----------------------------------------------------------------------------
   procedure Push ( Typ : Item );

   -----------------------------------------------------------------------------
   -- The function reads the first pushed value from the pipe but let the pipe
   -- intact.
   -----------------------------------------------------------------------------
   function Get return Item;

   -----------------------------------------------------------------------------
   -- The procedure reduces the length of the pipe by one
   -----------------------------------------------------------------------------
   procedure Remove;

   -----------------------------------------------------------------------------
   -- The function pops a value of the type Item from the pipe reducing the
   -- length of the pipe by one in the proces.
   -----------------------------------------------------------------------------
   function Pop return Item;

   -----------------------------------------------------------------------------
   -- The procedure Clears the pipe completely
   -----------------------------------------------------------------------------
   procedure Clear;

   -----------------------------------------------------------------------------
   -- The function gets the Pipe Length
   -----------------------------------------------------------------------------
   function Get_Length return integer;

private
   type Pipe_Pointer is access Block_Pipe;
   type Block_Pipe is record
      typ      : Item;
      previous : Pipe_Pointer := null;
      next     : Pipe_Pointer := null;
   end record;

   FirstPP     : Pipe_Pointer := null;
   LastPP      : Pipe_Pointer := null;
   Length      : integer := 0;
end Pipe;
