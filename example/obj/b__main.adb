pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__containers_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings__maps__constants_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__exceptions_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__object_reader_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__traceback__symbolic_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "ada__tags_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__streams_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "gnat_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "interfaces__c__strings_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__file_control_block_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "system__finalization_root_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "ada__finalization_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__file_io_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__storage_pools_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "system__finalization_masters_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "system__storage_pools__subpools_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "ada__strings__unbounded_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__task_info_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "system__task_primitives__operations_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__calendar__delays_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__real_time_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__text_io_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__pool_global_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "system__pool_size_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "gnat__sockets_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gnat__sockets__thin_common_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "gnat__sockets__thin_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "system__tasking__initialization_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "system__tasking__protected_objects_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "system__tasking__protected_objects__entries_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "system__tasking__queuing_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "system__tasking__stages_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "agnostic_io_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "socket_aio_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "text_pipe_aio_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E227 := E227 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "text_pipe_aio__finalize_spec");
      begin
         F1;
      end;
      E199 := E199 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "socket_aio__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "agnostic_io__finalize_spec");
      begin
         E149 := E149 - 1;
         F3;
      end;
      E217 := E217 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gnat__sockets__finalize_body");
      begin
         E162 := E162 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gnat__sockets__finalize_spec");
      begin
         F6;
      end;
      E181 := E181 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__pool_size__finalize_spec");
      begin
         F7;
      end;
      E157 := E157 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__pool_global__finalize_spec");
      begin
         F8;
      end;
      E138 := E138 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__text_io__finalize_spec");
      begin
         F9;
      end;
      E187 := E187 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__strings__unbounded__finalize_spec");
      begin
         F10;
      end;
      E173 := E173 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__storage_pools__subpools__finalize_spec");
      begin
         F11;
      end;
      E151 := E151 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__finalization_masters__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__file_io__finalize_body");
      begin
         E144 := E144 - 1;
         F13;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           False, False, False, True, True, True, True, False, 
           False, False, False, False, True, True, False, True, 
           True, False, True, True, True, True, False, False, 
           False, False, False, True, False, False, True, False, 
           True, False, False, True, False, True, False, True, 
           False, False, False, True, False, False, False, False, 
           False, True, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           False, True, False, False, False, False, False, True, 
           True, False, False, False),
         Count => (0, 0, 0, 0, 0, 1, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E027 := E027 + 1;
      Ada.Containers'Elab_Spec;
      E042 := E042 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Strings'Elab_Spec;
      E057 := E057 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E063 := E063 + 1;
      Interfaces.C'Elab_Spec;
      E047 := E047 + 1;
      System.Exceptions'Elab_Spec;
      E029 := E029 + 1;
      System.Object_Reader'Elab_Spec;
      E083 := E083 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E052 := E052 + 1;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E041 := E041 + 1;
      E010 := E010 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E132 := E132 + 1;
      Ada.Streams'Elab_Spec;
      E140 := E140 + 1;
      Gnat'Elab_Spec;
      E160 := E160 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E177 := E177 + 1;
      System.File_Control_Block'Elab_Spec;
      E148 := E148 + 1;
      System.Finalization_Root'Elab_Spec;
      E147 := E147 + 1;
      Ada.Finalization'Elab_Spec;
      E145 := E145 + 1;
      System.File_Io'Elab_Body;
      E144 := E144 + 1;
      System.Storage_Pools'Elab_Spec;
      E155 := E155 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E151 := E151 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E173 := E173 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E187 := E187 + 1;
      System.Task_Info'Elab_Spec;
      E118 := E118 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E112 := E112 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E006 := E006 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E103 := E103 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E138 := E138 + 1;
      System.Pool_Global'Elab_Spec;
      E157 := E157 + 1;
      System.Pool_Size'Elab_Spec;
      E181 := E181 + 1;
      Gnat.Sockets'Elab_Spec;
      E171 := E171 + 1;
      E165 := E165 + 1;
      Gnat.Sockets'Elab_Body;
      E162 := E162 + 1;
      System.Tasking.Initialization'Elab_Body;
      E207 := E207 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E215 := E215 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E217 := E217 + 1;
      System.Tasking.Queuing'Elab_Body;
      E221 := E221 + 1;
      System.Tasking.Stages'Elab_Body;
      E225 := E225 + 1;
      Agnostic_Io'Elab_Spec;
      E149 := E149 + 1;
      Socket_Aio'Elab_Spec;
      Socket_Aio'Elab_Body;
      E199 := E199 + 1;
      Text_Pipe_Aio'Elab_Spec;
      Text_Pipe_Aio'Elab_Body;
      E227 := E227 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/oswald/programming/ada/agnostic_io/obj/agnostic_io.o
   --   /home/oswald/programming/ada/agnostic_io/obj/socket_aio.o
   --   /home/oswald/programming/ada/agnostic_io/obj/text_pipe_aio.o
   --   /home/oswald/programming/ada/agnostic_io/example/obj/main.o
   --   -L/home/oswald/programming/ada/agnostic_io/example/obj/
   --   -L/home/oswald/programming/ada/agnostic_io/example/obj/
   --   -L/home/oswald/programming/ada/agnostic_io/obj/
   --   -L/usr/lib/gcc/x86_64-linux-gnu/10/adalib/
   --   -shared
   --   -lgnarl-10
   --   -lgnat-10
   --   -lrt
   --   -lpthread
   --   -ldl
--  END Object file/option list   

end ada_main;