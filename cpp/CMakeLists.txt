add_executable(cpptest cpptest.cpp)

file(GLOB encrypt_sources RELATIVE "${PROJECT_SOURCE_DIR}/encrypt" "*.v")
verilate(cpptest SOURCES ${PROJECT_SOURCE_DIR}/encrypt/aes_1cc.v INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/encrypt THREADS 4 VERILATOR_ARGS -Wno-UNOPTFLAT -Wno-LITENDIAN -Wno-IMPLICIT TRACE_FST)
verilate(cpptest SOURCES ${PROJECT_SOURCE_DIR}/decrypt/inverse_aes_1cc.v INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/decrypt THREADS 4 VERILATOR_ARGS -Wno-UNOPTFLAT -Wno-LITENDIAN -Wno-IMPLICIT TRACE_FST)