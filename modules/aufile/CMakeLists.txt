project(aufile)

set(SRCS aufile.c aufile_play.c aufile_src.c)

if(STATIC)
  add_library(${PROJECT_NAME} STATIC ${SRCS})
  target_link_libraries(${PROJECT_NAME} PRIVATE baresip)
else()
  add_library(${PROJECT_NAME} MODULE ${SRCS})
endif()

