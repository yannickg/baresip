project(av1)

set(SRCS av1.c encode.c decode.c)

if(STATIC)
    add_library(${PROJECT_NAME} STATIC ${SRCS})
else()
    add_library(${PROJECT_NAME} MODULE ${SRCS})
endif()

target_include_directories(${PROJECT_NAME} PRIVATE ${AOM_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} PRIVATE baresip ${AOM_LIBRARIES})
