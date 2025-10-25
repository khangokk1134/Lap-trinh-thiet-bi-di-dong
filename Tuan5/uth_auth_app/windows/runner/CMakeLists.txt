# ✅ Dùng CMake 3.5 trở lên, tránh cảnh báo Deprecation
cmake_minimum_required(VERSION 3.5)

# ✅ Đặt project cho runner
project(runner LANGUAGES CXX)

# ✅ Dùng toolset v142 để tương thích với Firebase SDK build cũ
set(CMAKE_GENERATOR_TOOLSET v142)

# ✅ Đảm bảo dùng chuẩn C++17 trở lên
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# -------------------------------------------------------------
# Define the application target
# -------------------------------------------------------------
add_executable(${BINARY_NAME} WIN32
  "flutter_window.cpp"
  "main.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
  "Runner.rc"
  "runner.exe.manifest"
)

# ✅ Tắt cảnh báo debug symbol (PDB) từ Firebase
add_link_options(/ignore:4099)

# ✅ Bắt buộc dùng runtime /MD giống Firebase SDK
foreach(flag_var CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
                 CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE)
    string(REPLACE "/MT" "/MD" ${flag_var} "${${flag_var}}")
endforeach()

# -------------------------------------------------------------
# Các thiết lập chuẩn Flutter
# -------------------------------------------------------------
apply_standard_settings(${BINARY_NAME})

target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# ✅ Tránh xung đột macro với stdlib
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# -------------------------------------------------------------
# Liên kết các thư viện cần thiết
# -------------------------------------------------------------
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# -------------------------------------------------------------
# Gọi Flutter build tool
# -------------------------------------------------------------
add_dependencies(${BINARY_NAME} flutter_assemble)
