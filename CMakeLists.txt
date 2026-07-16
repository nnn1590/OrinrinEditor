cmake_minimum_required(VERSION 3.13)

project("OrinrinEditor" "CXX")

# 共通CFLAGSとプリプロセッサー定義
add_compile_options(
	-Wall -Wextra -Wno-unused-parameter
	-ffunction-sections -fdata-sections -Wl,--gc-sections
)

add_compile_definitions(
	WIN32 _WINDOWS
	UNICODE _UNICODE
	WIN32_LEAN_AND_MEAN
	STRICT
	STRSAFE_NO_DEPRECATE
)

################################
# Editor

add_executable(
	"OrinrinEditor"
	src/OrinrinEditor.rc
	src/BrushTemplate.cpp
	src/ContextCtrl.cpp
	src/DocAdjustant.cpp
	src/DocCore.cpp
	src/DocFileCtrl.cpp
	src/DocInsDelCtrl.cpp
	src/DocInverseCtrl.cpp
	src/DocMiscellaneous.cpp
	src/DocOperateLog.cpp
	src/DocPreview.cpp
	src/DocSearchCtrl.cpp
	src/DocSelect.cpp
	src/DraughtBoard.cpp
	src/FrameCtrl.cpp
	src/HoverTip.cpp
	src/LayerBox.cpp
	src/LineTemplate.cpp
	src/MaaCatalogue.cpp
	src/MaaItems.cpp
	src/MaaSqlManipulate.cpp
	src/MaaTemplate.cpp
	src/MaaTreeView.cpp
	src/MiniTemplate.cpp
	src/MoziScript.cpp
	src/OrinrinEditor.cpp
	src/PageCtrl.cpp
	src/SplitBar.cpp
	src/stdafx.cpp
	src/ToolBar.cpp
	src/TraceCtrl.cpp
	src/UnicodePalette.cpp
	src/UserDefinition.cpp
	src/VerticalScript.cpp
	src/ViewCaret.cpp
	src/ViewCentral.cpp
	src/ViewKeyButton.cpp
	src/ViewSelect.cpp
	src/ViewTrace.cpp
)

target_link_libraries(
	"OrinrinEditor"
	PUBLIC
	shell32 comdlg32 comctl32 imm32 sqlite3 shlwapi ole32
)

target_link_options(
	"OrinrinEditor"
	PUBLIC
	"-L${CMAKE_SOURCE_DIR}/external/sqlite3/lib/${TOOLCHAIN_PREFIX}"
	"-municode" "-mwindows" "-mwin32"
	"-static-libgcc" "-static-libstdc++"
)

target_include_directories(
	"OrinrinEditor"
	PRIVATE
	"${CMAKE_SOURCE_DIR}/external/sqlite3/src"
)

################################
# Viewer

add_executable(
	"OrinrinViewer"
	src/OrinrinViewer.rc
	src/DraughtBoard.cpp
	src/HoverTip.cpp
	src/MaaCatalogue.cpp
	src/MaaItems.cpp
	src/MaaSqlManipulate.cpp
	src/MaaTemplate.cpp
	src/MaaTreeView.cpp
	src/OrinrinViewer.cpp
	src/SplitBar.cpp
	src/stdafx.cpp
)

target_compile_definitions(
	"OrinrinViewer"
	PRIVATE
	_ORRVW
)

target_link_libraries(
	"OrinrinViewer"
	PUBLIC
	shell32 comdlg32 comctl32 imm32 sqlite3 shlwapi ole32
)

target_link_options(
	"OrinrinViewer"
	PUBLIC
	"-municode" "-mwindows" "-mwin32"
	"-static-libgcc" "-static-libstdc++"
	"-L${CMAKE_SOURCE_DIR}/external/sqlite3/lib/${TOOLCHAIN_PREFIX}"
)

target_include_directories(
	"OrinrinViewer"
	PRIVATE
	"${CMAKE_SOURCE_DIR}/external/sqlite3/src"
)

################################
# Collector

add_executable(
	"OrinrinCollector"
	src/OrinrinCollector.rc
	src/OrinrinCollector.cpp
	src/stdafx.cpp
)

target_compile_definitions(
	"OrinrinCollector"
	PRIVATE
	_ORCOLL
)

target_link_libraries(
	"OrinrinCollector"
	PUBLIC
	shell32 comdlg32 comctl32 shlwapi
)

target_link_options(
	"OrinrinCollector"
	PUBLIC
	"-municode" "-mwindows" "-mwin32"
	"-static-libgcc" "-static-libstdc++"
)
