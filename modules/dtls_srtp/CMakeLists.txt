project(dtls_srtp)

set(SRCS dtls_srtp.c dtls.c srtp.c)

if(STATIC)
  add_library(${PROJECT_NAME} STATIC ${SRCS})
  target_link_libraries(${PROJECT_NAME} PRIVATE baresip)
else()
  add_library(${PROJECT_NAME} MODULE ${SRCS})
endif()

