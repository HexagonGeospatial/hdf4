#-------------------------------------------------------------------------------
MACRO (SET_GLOBAL_VARIABLE name value)
  SET (${name} ${value} CACHE INTERNAL "Used to pass variables between directories" FORCE)
ENDMACRO (SET_GLOBAL_VARIABLE)

#-------------------------------------------------------------------------------
MACRO (EXTERNAL_JPEG_LIBRARY compress_type lib_url jpeg_pic)
  # May need to build JPEG with PIC on x64 machines with gcc
  # Need to use CMAKE_ANSI_CFLAGS define so that compiler test works

  IF (${compress_type} MATCHES "SVN")
    EXTERNALPROJECT_ADD (JPEG
        SVN_REPOSITORY ${lib_url}
        # [SVN_REVISION rev] 
        INSTALL_COMMAND ""
        CMAKE_ARGS
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DCMAKE_BUILD_TYPE:STRING="Release"
            -DCMAKE_ANSI_CFLAGS:STRING="${jpeg_pic}"
    ) 
  ELSEIF (${compress_type} MATCHES "TGZ")
    EXTERNALPROJECT_ADD (JPEG
        URL ${lib_url}
        URL_MD5 ""
        INSTALL_COMMAND ""
        CMAKE_ARGS
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DCMAKE_BUILD_TYPE:STRING="Release"
            -DCMAKE_ANSI_CFLAGS:STRING="${jpeg_pic}"
    ) 
  ENDIF (${compress_type} MATCHES "SVN")
  EXTERNALPROJECT_GET_PROPERTY (JPEG BINARY_DIR SOURCE_DIR) 

  SET (JPEG_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/libjpeg${CMAKE_STATIC_LIBRARY_SUFFIX}")
  SET (JPEG_INCLUDE_DIR_GEN "${BINARY_DIR}")
  SET (JPEG_INCLUDE_DIR "${SOURCE_DIR}/src")
  SET (JPEG_FOUND 1)
  SET (JPEG_LIBRARIES ${JPEG_LIBRARY})
  SET (JPEG_INCLUDE_DIRS ${JPEG_INCLUDE_DIR_GEN} ${JPEG_INCLUDE_DIR})
ENDMACRO (EXTERNAL_JPEG_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (PACKAGE_JPEG_LIBRARY compress_type)
  ADD_CUSTOM_TARGET (JPEG-GenHeader-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${JPEG_INCLUDE_DIR_GEN}/jconfig.h ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${JPEG_INCLUDE_DIR_GEN}/jconfig.h to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  SET (EXTERNAL_HEADER_LIST ${EXTERNAL_HEADER_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/jconfig.h)
  ADD_CUSTOM_TARGET (JPEG-Library-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${JPEG_LIBRARY} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${JPEG_LIBRARY} to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  GET_FILENAME_COMPONENT(JPEG_LIB_NAME ${JPEG_LIBRARY} NAME)
  SET (EXTERNAL_LIBRARY_LIST ${EXTERNAL_LIBRARY_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${JPEG_LIB_NAME})
  IF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
    ADD_DEPENDENCIES (JPEG-GenHeader-Copy JPEG)
    ADD_DEPENDENCIES (JPEG-Library-Copy JPEG)
  ENDIF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
ENDMACRO (PACKAGE_JPEG_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (EXTERNAL_SZIP_LIBRARY compress_type lib_url libtype encoding)
  IF (${compress_type} MATCHES "SVN")
    EXTERNALPROJECT_ADD (SZIP
        SVN_REPOSITORY ${lib_url}
        # [SVN_REVISION rev] 
        INSTALL_COMMAND ""
        CMAKE_ARGS
            -DBUILD_SHARED_LIBS:BOOL=${libtype}
            -DSZIP_ENABLE_ENCODING:BOOL=${encoding}
    ) 
  ELSEIF (${compress_type} MATCHES "TGZ")
    EXTERNALPROJECT_ADD (SZIP
        URL ${lib_url}
        URL_MD5 ""
        INSTALL_COMMAND ""
        CMAKE_ARGS
            -DBUILD_SHARED_LIBS:BOOL=${libtype}
            -DSZIP_ENABLE_ENCODING:BOOL=${encoding}
    ) 
  ENDIF (${compress_type} MATCHES "SVN")
  EXTERNALPROJECT_GET_PROPERTY (SZIP BINARY_DIR SOURCE_DIR) 

  IF (${libtype} MATCHES "SHARED")
    IF (WIN32 AND NOT MINGW)
      SET (SZIP_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}szip${CMAKE_IMPORT_LIBRARY_SUFFIX}")
    ELSE (WIN32 AND NOT MINGW)
      SET (SZIP_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}szip${CMAKE_SHARED_LIBRARY_SUFFIX}")
    ENDIF (WIN32 AND NOT MINGW)
  ELSE (${libtype} MATCHES "SHARED")
      SET (SZIP_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/libszip${CMAKE_STATIC_LIBRARY_SUFFIX}")
  ENDIF (${libtype} MATCHES "SHARED")
  SET (SZIP_INCLUDE_DIR_GEN "${BINARY_DIR}")
  SET (SZIP_INCLUDE_DIR "${SOURCE_DIR}/src")
  SET (SZIP_FOUND 1)
  SET (SZIP_LIBRARIES ${SZIP_LIBRARY})
  SET (SZIP_INCLUDE_DIRS ${SZIP_INCLUDE_DIR_GEN} ${SZIP_INCLUDE_DIR})
ENDMACRO (EXTERNAL_SZIP_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (PACKAGE_SZIP_LIBRARY compress_type libtype)
  ADD_CUSTOM_TARGET (SZIP-GenHeader-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SZIP_INCLUDE_DIR_GEN}/SZconfig.h ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${SZIP_INCLUDE_DIR_GEN}/SZconfig.h to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  SET (EXTERNAL_HEADER_LIST ${EXTERNAL_HEADER_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/SZconfig.h)
  ADD_CUSTOM_TARGET (SZIP-Library-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SZIP_LIBRARY} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${SZIP_LIBRARY} to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  GET_FILENAME_COMPONENT(SZIP_LIB_NAME ${SZIP_LIBRARY} NAME)
  SET (EXTERNAL_LIBRARY_LIST ${EXTERNAL_LIBRARY_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${SZIP_LIB_NAME})
  IF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
    ADD_DEPENDENCIES (SZIP-GenHeader-Copy SZIP)
    ADD_DEPENDENCIES (SZIP-Library-Copy SZIP)
  ENDIF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
  IF (WIN32 AND NOT CYGWIN)
    IF (${libtype} MATCHES "SHARED")
      SET (EXTERNAL_LIBRARYDLL_LIST ${EXTERNAL_LIBRARYDLL_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${SZIP_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX})
      ADD_CUSTOM_TARGET (SZIP-Dll-Copy ALL
          COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SZIP_BIN_PATH}/${SZIP_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
          COMMENT "Copying ${SZIP_BIN_PATH}/${SZIP_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
      )
      IF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
        ADD_DEPENDENCIES (SZIP-Dll-Copy SZIP)
      ENDIF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
    ENDIF (${libtype} MATCHES "SHARED")
  ENDIF (WIN32 AND NOT CYGWIN)
ENDMACRO (PACKAGE_SZIP_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (EXTERNAL_ZLIB_LIBRARY compress_type lib_url libtype)
  IF (${compress_type} MATCHES "SVN")
    EXTERNALPROJECT_ADD (ZLIB
        SVN_REPOSITORY ${lib_url}
        # [SVN_REVISION rev] 
        INSTALL_COMMAND ""
        CMAKE_ARGS -DBUILD_SHARED_LIBS:BOOL=${libtype}
    ) 
  ELSEIF (${compress_type} MATCHES "TGZ")
    EXTERNALPROJECT_ADD (ZLIB
        URL ${lib_url}
        URL_MD5 ""
        INSTALL_COMMAND ""
        CMAKE_ARGS -DBUILD_SHARED_LIBS:BOOL=${libtype}
    ) 
  ENDIF (${compress_type} MATCHES "SVN")
  EXTERNALPROJECT_GET_PROPERTY (ZLIB BINARY_DIR SOURCE_DIR) 

  IF (${libtype} MATCHES "SHARED")
    IF (WIN32 AND NOT MINGW)
      SET (ZLIB_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}zlib1${CMAKE_IMPORT_LIBRARY_SUFFIX}")
    ELSE (WIN32 AND NOT MINGW)
      SET (ZLIB_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}z${CMAKE_SHARED_LIBRARY_SUFFIX}")
    ENDIF (WIN32 AND NOT MINGW)
  ELSE (${libtype} MATCHES "SHARED")
    IF (WIN32 AND NOT MINGW)
      IF (HDF_LEGACY_NAMING)
        SET (ZLIB_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/zlib${CMAKE_STATIC_LIBRARY_SUFFIX}")
      ELSE (HDF_LEGACY_NAMING)
        SET (ZLIB_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/libzlib${CMAKE_STATIC_LIBRARY_SUFFIX}")
      ENDIF (HDF_LEGACY_NAMING)
    ELSE (WIN32 AND NOT MINGW)
      SET (ZLIB_LIBRARY "${BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/libz${CMAKE_STATIC_LIBRARY_SUFFIX}")
    ENDIF (WIN32 AND NOT MINGW)
  ENDIF (${libtype} MATCHES "SHARED")
  SET (ZLIB_INCLUDE_DIR_GEN "${BINARY_DIR}")
  SET (ZLIB_INCLUDE_DIR "${SOURCE_DIR}/src")
  SET (ZLIB_FOUND 1)
  SET (ZLIB_LIBRARIES ${ZLIB_LIBRARY})
  SET (ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR_GEN} ${ZLIB_INCLUDE_DIR})
ENDMACRO (EXTERNAL_ZLIB_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (PACKAGE_ZLIB_LIBRARY compress_type libtype)
  ADD_CUSTOM_TARGET (ZLIB-GenHeader-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ZLIB_INCLUDE_DIR_GEN}/zconf.h ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${ZLIB_INCLUDE_DIR_GEN}/zconf.h to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  SET (EXTERNAL_HEADER_LIST ${EXTERNAL_HEADER_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/zconf.h)
  ADD_CUSTOM_TARGET (ZLIB-Library-Copy ALL
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ZLIB_LIBRARY} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
      COMMENT "Copying ${ZLIB_LIBRARY} to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
  )
  GET_FILENAME_COMPONENT(ZLIB_LIB_NAME ${ZLIB_LIBRARY} NAME)
  SET (EXTERNAL_LIBRARY_LIST ${EXTERNAL_LIBRARY_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${ZLIB_LIB_NAME})
  IF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
    ADD_DEPENDENCIES (ZLIB-GenHeader-Copy ZLIB)
    ADD_DEPENDENCIES (ZLIB-Library-Copy ZLIB)
  ENDIF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
  IF (WIN32 AND NOT CYGWIN)
    IF (${libtype} MATCHES "SHARED")
      SET (EXTERNAL_LIBRARYDLL_LIST ${EXTERNAL_LIBRARYDLL_LIST} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${ZLIB_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX})
      ADD_CUSTOM_TARGET (ZLIB-Dll-Copy ALL
          COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ZLIB_BIN_PATH}/${ZLIB_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
          COMMENT "Copying ${ZLIB_BIN_PATH}/${ZLIB_DLL_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
      )
      IF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
        ADD_DEPENDENCIES (ZLIB-Dll-Copy ZLIB)
      ENDIF (${compress_type} MATCHES "SVN" OR ${compress_type} MATCHES "TGZ")
    ENDIF (${libtype} MATCHES "SHARED")
  ENDIF (WIN32 AND NOT CYGWIN)
ENDMACRO (PACKAGE_ZLIB_LIBRARY)

#-------------------------------------------------------------------------------
MACRO (IDE_GENERATED_PROPERTIES SOURCE_PATH HEADERS SOURCES)
  #set(source_group_path "Source/AIM/${NAME}")
  STRING (REPLACE "/" "\\\\" source_group_path ${SOURCE_PATH})
  source_group (${source_group_path} FILES ${HEADERS} ${SOURCES})

  #-- The following is needed if we ever start to use OS X Frameworks but only
  #--  works on CMake 2.6 and greater
  #SET_PROPERTY (SOURCE ${HEADERS}
  #       PROPERTY MACOSX_PACKAGE_LOCATION Headers/${NAME}
  #)
ENDMACRO (IDE_GENERATED_PROPERTIES)

#-------------------------------------------------------------------------------
MACRO (IDE_SOURCE_PROPERTIES SOURCE_PATH HEADERS SOURCES)
  #  INSTALL (FILES ${HEADERS}
  #       DESTINATION include/R3D/${NAME}
  #       COMPONENT Headers       
  #  )

  STRING (REPLACE "/" "\\\\" source_group_path ${SOURCE_PATH}  )
  source_group (${source_group_path} FILES ${HEADERS} ${SOURCES})

  #-- The following is needed if we ever start to use OS X Frameworks but only
  #--  works on CMake 2.6 and greater
  #SET_PROPERTY (SOURCE ${HEADERS}
  #       PROPERTY MACOSX_PACKAGE_LOCATION Headers/${NAME}
  #)
ENDMACRO (IDE_SOURCE_PROPERTIES)

#-------------------------------------------------------------------------------
MACRO (TARGET_NAMING target libtype)
  IF (WIN32 AND NOT MINGW)
    IF (${libtype} MATCHES "SHARED")
      IF (HDF_LEGACY_NAMING)
        SET_TARGET_PROPERTIES (${target} PROPERTIES OUTPUT_NAME "dll")
        SET_TARGET_PROPERTIES (${target} PROPERTIES PREFIX "${target}")
      ELSE (HDF_LEGACY_NAMING)
        SET_TARGET_PROPERTIES (${target} PROPERTIES OUTPUT_NAME "${target}dll")
      ENDIF (HDF_LEGACY_NAMING)
    ENDIF (${libtype} MATCHES "SHARED")
  ENDIF (WIN32 AND NOT MINGW)
ENDMACRO (TARGET_NAMING)

#-------------------------------------------------------------------------------
MACRO (HDF_SET_LIB_OPTIONS libtarget libname libtype)
  # message (STATUS "${libname} libtype: ${libtype}")
  IF (${libtype} MATCHES "SHARED")
    IF (WIN32 AND NOT MINGW)
      IF (HDF_LEGACY_NAMING)
        SET (LIB_RELEASE_NAME "${libname}dll")
        SET (LIB_DEBUG_NAME "${libname}ddll")
      ELSE (HDF_LEGACY_NAMING)
        SET (LIB_RELEASE_NAME "${libname}")
        SET (LIB_DEBUG_NAME "${libname}_D")
      ENDIF (HDF_LEGACY_NAMING)
    ELSE (WIN32 AND NOT MINGW)
      SET (LIB_RELEASE_NAME "${libname}")
      SET (LIB_DEBUG_NAME "${libname}_debug")
    ENDIF (WIN32 AND NOT MINGW)
  ELSE (${libtype} MATCHES "SHARED")
    IF (WIN32 AND NOT MINGW)
      IF (HDF_LEGACY_NAMING)
        SET (LIB_RELEASE_NAME "${libname}")
        SET (LIB_DEBUG_NAME "${libname}d")
      ELSE (HDF_LEGACY_NAMING)
        SET (LIB_RELEASE_NAME "lib${libname}")
        SET (LIB_DEBUG_NAME "lib${libname}_D")
      ENDIF (HDF_LEGACY_NAMING)
    ELSE (WIN32 AND NOT MINGW)
      # if the generator supports configuration types or if the CMAKE_BUILD_TYPE has a value
      IF (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
        SET (LIB_RELEASE_NAME "${libname}")
        SET (LIB_DEBUG_NAME "${libname}_debug")
      ELSE (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
        SET (LIB_RELEASE_NAME "lib${libname}")
        SET (LIB_DEBUG_NAME "lib${libname}_debug")
      ENDIF (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
    ENDIF (WIN32 AND NOT MINGW)
  ENDIF (${libtype} MATCHES "SHARED")
  
  SET_TARGET_PROPERTIES (${libtarget}
      PROPERTIES
      DEBUG_OUTPUT_NAME          ${LIB_DEBUG_NAME}
      RELEASE_OUTPUT_NAME        ${LIB_RELEASE_NAME}
      MINSIZEREL_OUTPUT_NAME     ${LIB_RELEASE_NAME}
      RELWITHDEBINFO_OUTPUT_NAME ${LIB_RELEASE_NAME}
  )
  
  #----- Use MSVC Naming conventions for Shared Libraries
  IF (MINGW AND ${libtype} MATCHES "SHARED")
    SET_TARGET_PROPERTIES (${libtarget}
        PROPERTIES
        IMPORT_SUFFIX ".lib"
        IMPORT_PREFIX ""
        PREFIX ""
    )
  ENDIF (MINGW AND ${libtype} MATCHES "SHARED")

ENDMACRO (HDF_SET_LIB_OPTIONS)

#-------------------------------------------------------------------------------
MACRO (TARGET_FORTRAN_WIN_PROPERTIES target addlinkflags)
  IF (WIN32)
    IF (MSVC)
      SET_TARGET_PROPERTIES (${target}
          PROPERTIES
              COMPILE_FLAGS "/dll"
              LINK_FLAGS "/SUBSYSTEM:CONSOLE ${addlinkflags}"
      ) 
    ENDIF (MSVC)
  ENDIF (WIN32)
ENDMACRO (TARGET_FORTRAN_WIN_PROPERTIES)
