# Microsoft Developer Studio Project File - Name="hdiff" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=hdiff - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "hdiff.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "hdiff.mak" CFG="hdiff - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "hdiff - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "hdiff - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "hdiff - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\..\..\mfhdf\hdiff\Release"
# PROP Intermediate_Dir "..\..\..\..\mfhdf\hdiff\Release\hdiff"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
F90=df.exe
# ADD BASE F90 /compile_only /include:"Release/" /nologo /warn:nofileopt
# ADD F90 /compile_only /include:".\hdiff\Release/" /nologo /warn:nofileopt
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "..\..\..\..\hdf\src" /I "..\..\..\..\mfhdf\libsrc" /I "..\..\..\..\mfhdf\xdr" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib $(HDF4_EXT_ZLIB) $(HDF4_EXT_SZIP) $(HDF4_EXT_JPEG) /nologo /subsystem:console /incremental:yes /machine:I386 /libpath:".\windows\lib\release\singlethreaded"

!ELSEIF  "$(CFG)" == "hdiff - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "hdiff___Win32_Debug"
# PROP BASE Intermediate_Dir "hdiff___Win32_Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\..\..\mfhdf\hdiff\Debug"
# PROP Intermediate_Dir "..\..\..\..\mfhdf\hdiff\Debug\hdiff"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
F90=df.exe
# ADD BASE F90 /check:bounds /compile_only /debug:full /include:"hdiff___Win32_Debug/" /nologo /warn:argument_checking /warn:nofileopt
# ADD F90 /browser /check:bounds /compile_only /debug:full /include:".\hdiff\Debug/" /nologo /warn:argument_checking /warn:nofileopt
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /W4 /Gm /GX /ZI /Od /I "..\..\..\..\hdf\src" /I "..\..\..\..\mfhdf\libsrc" /I "..\..\..\..\mfhdf\xdr" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 wsock32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib $(HDF4_EXT_ZLIB) $(HDF4_EXT_SZIP) $(HDF4_EXT_JPEG) /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libc.lib" /pdbtype:sept /libpath:".\windows\lib\debug\singlethreaded"

!ENDIF 

# Begin Target

# Name "hdiff - Win32 Release"
# Name "hdiff - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat;f90;for;f;fpp"
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_array.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_dim.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_gattr.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_gr.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_list.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_main.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_mattbl.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_misc.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_sds.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_table.c
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_vs.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl;fi;fd"
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_array.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_dim.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_list.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_mattbl.h
# End Source File
# Begin Source File

SOURCE=..\..\..\..\mfhdf\hdiff\hdiff_table.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project