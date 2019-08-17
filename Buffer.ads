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
-- Buffer.ads Version 1.00 dd. 14-01-2019  Author L Dries                   --
------------------------------------------------------------------------------1

generic
   type Item is private;
package Buffer is

   type Block_Buffer is limited private;
   type Buffer_Pointer is limited private;
   type Buffer_Dir is (after, before);

   BUFFER_ITEM_OUT_OF_RANGE : exception;

--------------------------------------------------------------------------------
-- Fill a Buffer Element After the mentioned pointer
-- where the standard is at the end of the buffer
--------------------------------------------------------------------------------
   procedure Set_Buffer ( inp : item; nr:integer := 0);

--------------------------------------------------------------------------------
-- Fill a Buffer Element before or after then mentioned element nr
-- where the standard is after the mentioned element
--------------------------------------------------------------------------------
   procedure Insert_Buffer ( inp : item; bp: integer; Dir: Buffer_Dir := after);

--------------------------------------------------------------------------------
-- Get the value of the mentioned element
--------------------------------------------------------------------------------
   function Get_Buffer( nr : integer) return Item;

--------------------------------------------------------------------------------
-- Remove a Buffer Element
--------------------------------------------------------------------------------
   procedure Remove_Buffer( nr : integer);

--------------------------------------------------------------------------------
-- Clear the complete buffer
--------------------------------------------------------------------------------
   procedure Clear_Buffer;

--------------------------------------------------------------------------------
-- Find the nr of elemenets in the buffer
--------------------------------------------------------------------------------
   function Length return integer;


private
   type Buffer_Pointer is access Block_Buffer;
   type Block_Buffer is record
      nr       : integer;
      buf      : Item;
      previous : Buffer_Pointer := null;
      next     : Buffer_Pointer := null;
   end record;

   FirstBuffer : Buffer_Pointer := null;
   LastBuffer  : Buffer_Pointer := null;
   Nr_Items    : integer := 0;

--------------------------------------------------------------------------------
-- Renumber all the elements in the buffer
--------------------------------------------------------------------------------
   procedure Renumber;
end Buffer;
