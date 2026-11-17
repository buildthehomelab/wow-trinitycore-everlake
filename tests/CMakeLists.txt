# This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(tests)

CollectAndAddSourceFiles(
  tests
  ${CMAKE_CURRENT_SOURCE_DIR})

# Tests of code that lives in the Playerbot V2 module's own sources (they call functions defined in the module's .cpp files, or include
# headers that exist only under src/modules/PlayerbotV2). A build without the module has neither, so they are not compiled there.
if(NOT BUILD_PLAYERBOT_V2)
  set(TESTS_MODULE_ONLY_SOURCES
    ClassicTalentCode.cpp
    ClassicDrinkSay.cpp)
  foreach(_test_source ${TESTS_MODULE_ONLY_SOURCES})
    set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/game/${_test_source} PROPERTIES HEADER_FILE_ONLY TRUE)
  endforeach()
endif()

target_link_libraries(tests
  PRIVATE
    trinity-core-interface
    game
    Catch2::Catch2WithMain)

target_include_directories(tests
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

catch_discover_tests(tests)

set_target_properties(tests
    PROPERTIES
      FOLDER
        "tests")
