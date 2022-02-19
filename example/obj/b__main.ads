pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: Community 2020 (20200818-93)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#64502b3c#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#67c8d842#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#23d4d899#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#f435a12e#;
   pragma Export (C, u00005, "ada__exceptionsB");
   u00006 : constant Version_32 := 16#bb2e31f9#;
   pragma Export (C, u00006, "ada__exceptionsS");
   u00007 : constant Version_32 := 16#35e1815f#;
   pragma Export (C, u00007, "ada__exceptions__last_chance_handlerB");
   u00008 : constant Version_32 := 16#cfec26ee#;
   pragma Export (C, u00008, "ada__exceptions__last_chance_handlerS");
   u00009 : constant Version_32 := 16#4635ec04#;
   pragma Export (C, u00009, "systemS");
   u00010 : constant Version_32 := 16#ae860117#;
   pragma Export (C, u00010, "system__soft_linksB");
   u00011 : constant Version_32 := 16#39005bef#;
   pragma Export (C, u00011, "system__soft_linksS");
   u00012 : constant Version_32 := 16#2d437d19#;
   pragma Export (C, u00012, "system__secondary_stackB");
   u00013 : constant Version_32 := 16#b79edb80#;
   pragma Export (C, u00013, "system__secondary_stackS");
   u00014 : constant Version_32 := 16#896564a3#;
   pragma Export (C, u00014, "system__parametersB");
   u00015 : constant Version_32 := 16#016728cf#;
   pragma Export (C, u00015, "system__parametersS");
   u00016 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00016, "system__storage_elementsB");
   u00017 : constant Version_32 := 16#6bf6a600#;
   pragma Export (C, u00017, "system__storage_elementsS");
   u00018 : constant Version_32 := 16#ce3e0e21#;
   pragma Export (C, u00018, "system__soft_links__initializeB");
   u00019 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00019, "system__soft_links__initializeS");
   u00020 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#c88a87ec#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00022, "system__exception_tableB");
   u00023 : constant Version_32 := 16#795caff4#;
   pragma Export (C, u00023, "system__exception_tableS");
   u00024 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00024, "system__exceptionsB");
   u00025 : constant Version_32 := 16#2e5681f2#;
   pragma Export (C, u00025, "system__exceptionsS");
   u00026 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00026, "system__exceptions__machineB");
   u00027 : constant Version_32 := 16#5c74e542#;
   pragma Export (C, u00027, "system__exceptions__machineS");
   u00028 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00028, "system__exceptions_debugB");
   u00029 : constant Version_32 := 16#5a783f72#;
   pragma Export (C, u00029, "system__exceptions_debugS");
   u00030 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00030, "system__img_intB");
   u00031 : constant Version_32 := 16#44ee0cc6#;
   pragma Export (C, u00031, "system__img_intS");
   u00032 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00032, "system__tracebackB");
   u00033 : constant Version_32 := 16#181732c0#;
   pragma Export (C, u00033, "system__tracebackS");
   u00034 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00034, "system__traceback_entriesB");
   u00035 : constant Version_32 := 16#466e1a74#;
   pragma Export (C, u00035, "system__traceback_entriesS");
   u00036 : constant Version_32 := 16#e162df04#;
   pragma Export (C, u00036, "system__traceback__symbolicB");
   u00037 : constant Version_32 := 16#46491211#;
   pragma Export (C, u00037, "system__traceback__symbolicS");
   u00038 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00038, "ada__containersS");
   u00039 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00039, "ada__exceptions__tracebackB");
   u00040 : constant Version_32 := 16#ae2d2db5#;
   pragma Export (C, u00040, "ada__exceptions__tracebackS");
   u00041 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00041, "interfacesS");
   u00042 : constant Version_32 := 16#e49bce3e#;
   pragma Export (C, u00042, "interfaces__cB");
   u00043 : constant Version_32 := 16#dbc36ce0#;
   pragma Export (C, u00043, "interfaces__cS");
   u00044 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00044, "system__bounded_stringsB");
   u00045 : constant Version_32 := 16#31c8cd1d#;
   pragma Export (C, u00045, "system__bounded_stringsS");
   u00046 : constant Version_32 := 16#0fdcf3be#;
   pragma Export (C, u00046, "system__crtlS");
   u00047 : constant Version_32 := 16#108b4f79#;
   pragma Export (C, u00047, "system__dwarf_linesB");
   u00048 : constant Version_32 := 16#345b739f#;
   pragma Export (C, u00048, "system__dwarf_linesS");
   u00049 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00049, "ada__charactersS");
   u00050 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00050, "ada__characters__handlingB");
   u00051 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00051, "ada__characters__handlingS");
   u00052 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00052, "ada__characters__latin_1S");
   u00053 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00053, "ada__stringsS");
   u00054 : constant Version_32 := 16#96df1a3f#;
   pragma Export (C, u00054, "ada__strings__mapsB");
   u00055 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00055, "ada__strings__mapsS");
   u00056 : constant Version_32 := 16#32cfc5a0#;
   pragma Export (C, u00056, "system__bit_opsB");
   u00057 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00057, "system__bit_opsS");
   u00058 : constant Version_32 := 16#18fa9e16#;
   pragma Export (C, u00058, "system__unsigned_typesS");
   u00059 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00059, "ada__strings__maps__constantsS");
   u00060 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00060, "system__address_imageB");
   u00061 : constant Version_32 := 16#e7d9713e#;
   pragma Export (C, u00061, "system__address_imageS");
   u00062 : constant Version_32 := 16#8631cc2e#;
   pragma Export (C, u00062, "system__img_unsB");
   u00063 : constant Version_32 := 16#870ea2e1#;
   pragma Export (C, u00063, "system__img_unsS");
   u00064 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00064, "system__ioB");
   u00065 : constant Version_32 := 16#d8771b4b#;
   pragma Export (C, u00065, "system__ioS");
   u00066 : constant Version_32 := 16#f790d1ef#;
   pragma Export (C, u00066, "system__mmapB");
   u00067 : constant Version_32 := 16#ee41b8bb#;
   pragma Export (C, u00067, "system__mmapS");
   u00068 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00068, "ada__io_exceptionsS");
   u00069 : constant Version_32 := 16#91eaca2e#;
   pragma Export (C, u00069, "system__mmap__os_interfaceB");
   u00070 : constant Version_32 := 16#1fc2f713#;
   pragma Export (C, u00070, "system__mmap__os_interfaceS");
   u00071 : constant Version_32 := 16#8c787ae2#;
   pragma Export (C, u00071, "system__mmap__unixS");
   u00072 : constant Version_32 := 16#11eb9166#;
   pragma Export (C, u00072, "system__os_libB");
   u00073 : constant Version_32 := 16#d872da39#;
   pragma Export (C, u00073, "system__os_libS");
   u00074 : constant Version_32 := 16#ec4d5631#;
   pragma Export (C, u00074, "system__case_utilB");
   u00075 : constant Version_32 := 16#79e05a50#;
   pragma Export (C, u00075, "system__case_utilS");
   u00076 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00076, "system__stringsB");
   u00077 : constant Version_32 := 16#2623c091#;
   pragma Export (C, u00077, "system__stringsS");
   u00078 : constant Version_32 := 16#c83ab8ef#;
   pragma Export (C, u00078, "system__object_readerB");
   u00079 : constant Version_32 := 16#82413105#;
   pragma Export (C, u00079, "system__object_readerS");
   u00080 : constant Version_32 := 16#914b0305#;
   pragma Export (C, u00080, "system__val_lliB");
   u00081 : constant Version_32 := 16#2a5b7ef4#;
   pragma Export (C, u00081, "system__val_lliS");
   u00082 : constant Version_32 := 16#d2ae2792#;
   pragma Export (C, u00082, "system__val_lluB");
   u00083 : constant Version_32 := 16#753413f4#;
   pragma Export (C, u00083, "system__val_lluS");
   u00084 : constant Version_32 := 16#269742a9#;
   pragma Export (C, u00084, "system__val_utilB");
   u00085 : constant Version_32 := 16#ea955afa#;
   pragma Export (C, u00085, "system__val_utilS");
   u00086 : constant Version_32 := 16#b578159b#;
   pragma Export (C, u00086, "system__exception_tracesB");
   u00087 : constant Version_32 := 16#62eacc9e#;
   pragma Export (C, u00087, "system__exception_tracesS");
   u00088 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00088, "system__wch_conB");
   u00089 : constant Version_32 := 16#5d48ced6#;
   pragma Export (C, u00089, "system__wch_conS");
   u00090 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00090, "system__wch_stwB");
   u00091 : constant Version_32 := 16#7059e2d7#;
   pragma Export (C, u00091, "system__wch_stwS");
   u00092 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00092, "system__wch_cnvB");
   u00093 : constant Version_32 := 16#52ff7425#;
   pragma Export (C, u00093, "system__wch_cnvS");
   u00094 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00094, "system__wch_jisB");
   u00095 : constant Version_32 := 16#d28f6d04#;
   pragma Export (C, u00095, "system__wch_jisS");
   u00096 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00096, "ada__streamsB");
   u00097 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00097, "ada__streamsS");
   u00098 : constant Version_32 := 16#f9576a72#;
   pragma Export (C, u00098, "ada__tagsB");
   u00099 : constant Version_32 := 16#b6661f55#;
   pragma Export (C, u00099, "ada__tagsS");
   u00100 : constant Version_32 := 16#796f31f1#;
   pragma Export (C, u00100, "system__htableB");
   u00101 : constant Version_32 := 16#c2f75fee#;
   pragma Export (C, u00101, "system__htableS");
   u00102 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00102, "system__string_hashB");
   u00103 : constant Version_32 := 16#60a93490#;
   pragma Export (C, u00103, "system__string_hashS");
   u00104 : constant Version_32 := 16#f4e097a7#;
   pragma Export (C, u00104, "ada__text_ioB");
   u00105 : constant Version_32 := 16#777d5329#;
   pragma Export (C, u00105, "ada__text_ioS");
   u00106 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00106, "interfaces__c_streamsB");
   u00107 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00107, "interfaces__c_streamsS");
   u00108 : constant Version_32 := 16#ec9c64c3#;
   pragma Export (C, u00108, "system__file_ioB");
   u00109 : constant Version_32 := 16#e1440d61#;
   pragma Export (C, u00109, "system__file_ioS");
   u00110 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00110, "ada__finalizationS");
   u00111 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00111, "system__finalization_rootB");
   u00112 : constant Version_32 := 16#09c79f94#;
   pragma Export (C, u00112, "system__finalization_rootS");
   u00113 : constant Version_32 := 16#bbaa76ac#;
   pragma Export (C, u00113, "system__file_control_blockS");
   u00114 : constant Version_32 := 16#46dc36ff#;
   pragma Export (C, u00114, "agnostic_ioS");
   u00115 : constant Version_32 := 16#57674f80#;
   pragma Export (C, u00115, "system__finalization_mastersB");
   u00116 : constant Version_32 := 16#4552acd4#;
   pragma Export (C, u00116, "system__finalization_mastersS");
   u00117 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00117, "system__img_boolB");
   u00118 : constant Version_32 := 16#b3ec9def#;
   pragma Export (C, u00118, "system__img_boolS");
   u00119 : constant Version_32 := 16#35d6ef80#;
   pragma Export (C, u00119, "system__storage_poolsB");
   u00120 : constant Version_32 := 16#3d430bb3#;
   pragma Export (C, u00120, "system__storage_poolsS");
   u00121 : constant Version_32 := 16#021224f8#;
   pragma Export (C, u00121, "system__pool_globalB");
   u00122 : constant Version_32 := 16#29da5924#;
   pragma Export (C, u00122, "system__pool_globalS");
   u00123 : constant Version_32 := 16#eca5ecae#;
   pragma Export (C, u00123, "system__memoryB");
   u00124 : constant Version_32 := 16#1f488a30#;
   pragma Export (C, u00124, "system__memoryS");
   u00125 : constant Version_32 := 16#b5988c27#;
   pragma Export (C, u00125, "gnatS");
   u00126 : constant Version_32 := 16#eecbc2f6#;
   pragma Export (C, u00126, "gnat__socketsB");
   u00127 : constant Version_32 := 16#41e8458e#;
   pragma Export (C, u00127, "gnat__socketsS");
   u00128 : constant Version_32 := 16#d2b5615a#;
   pragma Export (C, u00128, "gnat__sockets__linker_optionsS");
   u00129 : constant Version_32 := 16#5e4565d7#;
   pragma Export (C, u00129, "gnat__sockets__thinB");
   u00130 : constant Version_32 := 16#cf2213b4#;
   pragma Export (C, u00130, "gnat__sockets__thinS");
   u00131 : constant Version_32 := 16#ffaa9e94#;
   pragma Export (C, u00131, "ada__calendar__delaysB");
   u00132 : constant Version_32 := 16#d86d2f1d#;
   pragma Export (C, u00132, "ada__calendar__delaysS");
   u00133 : constant Version_32 := 16#c47dab26#;
   pragma Export (C, u00133, "ada__calendarB");
   u00134 : constant Version_32 := 16#31350a81#;
   pragma Export (C, u00134, "ada__calendarS");
   u00135 : constant Version_32 := 16#51f2d040#;
   pragma Export (C, u00135, "system__os_primitivesB");
   u00136 : constant Version_32 := 16#41c889f2#;
   pragma Export (C, u00136, "system__os_primitivesS");
   u00137 : constant Version_32 := 16#efb85c8a#;
   pragma Export (C, u00137, "gnat__os_libS");
   u00138 : constant Version_32 := 16#485b8267#;
   pragma Export (C, u00138, "gnat__task_lockS");
   u00139 : constant Version_32 := 16#05c60a38#;
   pragma Export (C, u00139, "system__task_lockB");
   u00140 : constant Version_32 := 16#27bfdb6a#;
   pragma Export (C, u00140, "system__task_lockS");
   u00141 : constant Version_32 := 16#01d87a0e#;
   pragma Export (C, u00141, "gnat__sockets__thin_commonB");
   u00142 : constant Version_32 := 16#f5bcf34a#;
   pragma Export (C, u00142, "gnat__sockets__thin_commonS");
   u00143 : constant Version_32 := 16#d5d8c501#;
   pragma Export (C, u00143, "system__storage_pools__subpoolsB");
   u00144 : constant Version_32 := 16#e136d7bf#;
   pragma Export (C, u00144, "system__storage_pools__subpoolsS");
   u00145 : constant Version_32 := 16#84042202#;
   pragma Export (C, u00145, "system__storage_pools__subpools__finalizationB");
   u00146 : constant Version_32 := 16#8bd8fdc9#;
   pragma Export (C, u00146, "system__storage_pools__subpools__finalizationS");
   u00147 : constant Version_32 := 16#69f6ee6b#;
   pragma Export (C, u00147, "interfaces__c__stringsB");
   u00148 : constant Version_32 := 16#f239f79c#;
   pragma Export (C, u00148, "interfaces__c__stringsS");
   u00149 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00149, "system__communicationB");
   u00150 : constant Version_32 := 16#5f55b9d6#;
   pragma Export (C, u00150, "system__communicationS");
   u00151 : constant Version_32 := 16#637ab3c9#;
   pragma Export (C, u00151, "system__pool_sizeB");
   u00152 : constant Version_32 := 16#1f80dd47#;
   pragma Export (C, u00152, "system__pool_sizeS");
   u00153 : constant Version_32 := 16#65de8d35#;
   pragma Export (C, u00153, "system__val_intB");
   u00154 : constant Version_32 := 16#f3ca8567#;
   pragma Export (C, u00154, "system__val_intS");
   u00155 : constant Version_32 := 16#5276dcb7#;
   pragma Export (C, u00155, "system__val_unsB");
   u00156 : constant Version_32 := 16#2dfce3af#;
   pragma Export (C, u00156, "system__val_unsS");
   u00157 : constant Version_32 := 16#c6ca4532#;
   pragma Export (C, u00157, "ada__strings__unboundedB");
   u00158 : constant Version_32 := 16#6552cb60#;
   pragma Export (C, u00158, "ada__strings__unboundedS");
   u00159 : constant Version_32 := 16#60da0992#;
   pragma Export (C, u00159, "ada__strings__searchB");
   u00160 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00160, "ada__strings__searchS");
   u00161 : constant Version_32 := 16#acee74ad#;
   pragma Export (C, u00161, "system__compare_array_unsigned_8B");
   u00162 : constant Version_32 := 16#ef369d89#;
   pragma Export (C, u00162, "system__compare_array_unsigned_8S");
   u00163 : constant Version_32 := 16#a8025f3c#;
   pragma Export (C, u00163, "system__address_operationsB");
   u00164 : constant Version_32 := 16#55395237#;
   pragma Export (C, u00164, "system__address_operationsS");
   u00165 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00165, "system__atomic_countersB");
   u00166 : constant Version_32 := 16#f269c189#;
   pragma Export (C, u00166, "system__atomic_countersS");
   u00167 : constant Version_32 := 16#5252521d#;
   pragma Export (C, u00167, "system__stream_attributesB");
   u00168 : constant Version_32 := 16#d573b948#;
   pragma Export (C, u00168, "system__stream_attributesS");
   u00169 : constant Version_32 := 16#3e25f63c#;
   pragma Export (C, u00169, "system__stream_attributes__xdrB");
   u00170 : constant Version_32 := 16#2f60cd1f#;
   pragma Export (C, u00170, "system__stream_attributes__xdrS");
   u00171 : constant Version_32 := 16#1e40f010#;
   pragma Export (C, u00171, "system__fat_fltS");
   u00172 : constant Version_32 := 16#3872f91d#;
   pragma Export (C, u00172, "system__fat_lfltS");
   u00173 : constant Version_32 := 16#42a257f7#;
   pragma Export (C, u00173, "system__fat_llfS");
   u00174 : constant Version_32 := 16#ed063051#;
   pragma Export (C, u00174, "system__fat_sfltS");
   u00175 : constant Version_32 := 16#7fa4fe77#;
   pragma Export (C, u00175, "system__os_constantsS");
   u00176 : constant Version_32 := 16#a6d8c69a#;
   pragma Export (C, u00176, "socket_aioB");
   u00177 : constant Version_32 := 16#b16c7d30#;
   pragma Export (C, u00177, "socket_aioS");
   u00178 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00178, "system__concat_2B");
   u00179 : constant Version_32 := 16#44953bd4#;
   pragma Export (C, u00179, "system__concat_2S");
   u00180 : constant Version_32 := 16#7c2b7812#;
   pragma Export (C, u00180, "text_pipe_aioB");
   u00181 : constant Version_32 := 16#69e45e0b#;
   pragma Export (C, u00181, "text_pipe_aioS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  ada.characters.handling%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  system.val_lli%b
   --  system.val_llu%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  gnat%s
   --  gnat.os_lib%s
   --  interfaces.c.strings%s
   --  interfaces.c.strings%b
   --  system.communication%s
   --  system.communication%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.fat_sflt%s
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.os_constants%s
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.storage_pools.subpools%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.task_lock%s
   --  system.task_lock%b
   --  gnat.task_lock%s
   --  system.val_uns%s
   --  system.val_uns%b
   --  system.val_int%s
   --  system.val_int%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.pool_size%s
   --  system.pool_size%b
   --  gnat.sockets%s
   --  gnat.sockets.linker_options%s
   --  gnat.sockets.thin_common%s
   --  gnat.sockets.thin_common%b
   --  gnat.sockets.thin%s
   --  gnat.sockets.thin%b
   --  gnat.sockets%b
   --  agnostic_io%s
   --  socket_aio%s
   --  socket_aio%b
   --  text_pipe_aio%s
   --  text_pipe_aio%b
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
