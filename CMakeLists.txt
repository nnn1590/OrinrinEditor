cmake_minimum_required(VERSION 3.13)
# VS2005のサポートはCMake 3.12以降
# VS2008のサポートはCMake 3.30以降
# VS2010のサポートはCMake 3.25以降
# で打ち切られている。
# より新しいバージョンのVS、例えばVS2015を同時にインストールしてCMAKE_GENERATOR_TOOLSETをセットすれば
# 旧バージョン向けのソリューションが作れるらしいが、
# それは容量食うしVS2015の最低要件が必須になってしまう
# (つまりVS2005は動くが2015が動かない環境でビルドできなくなってしまう)ので
# できるならこれらのバージョンをそのまま使えるようにしたい
# そのためにはCMake最小バージョンを古いバージョンに固執する必要がある
# いまんとこ3.13だがそのうち最低でも3.11にバックポートする

project("OrinrinEditor" "CXX")

set(SRC "src")

# 共通CFLAGSとプリプロセッサー定義
if (MSVC)
	# MSVCでは文字エンコードを変えたやつを使う
	# 最近のMSVCなら/utf-8とか/source-charset:utf-8とかがあるけど
	# 少なくともVS2010には存在しなかったため、外部ツールで事前に変換しとく
	# scripts/create_src_cp932.sh参照
	set(SRC "src_cp932")
else()
	add_compile_options(
		-Wall -Wextra -Wno-unused-parameter
		-ffunction-sections -fdata-sections -Wl,--gc-sections
	)
endif()

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
	${SRC}/OrinrinEditor.rc
	${SRC}/BrushTemplate.cpp
	${SRC}/ContextCtrl.cpp
	${SRC}/DocAdjustant.cpp
	${SRC}/DocCore.cpp
	${SRC}/DocFileCtrl.cpp
	${SRC}/DocInsDelCtrl.cpp
	${SRC}/DocInverseCtrl.cpp
	${SRC}/DocMiscellaneous.cpp
	${SRC}/DocOperateLog.cpp
	${SRC}/DocPreview.cpp
	${SRC}/DocSearchCtrl.cpp
	${SRC}/DocSelect.cpp
	${SRC}/DraughtBoard.cpp
	${SRC}/FrameCtrl.cpp
	${SRC}/HoverTip.cpp
	${SRC}/LayerBox.cpp
	${SRC}/LineTemplate.cpp
	${SRC}/MaaCatalogue.cpp
	${SRC}/MaaItems.cpp
	${SRC}/MaaSqlManipulate.cpp
	${SRC}/MaaTemplate.cpp
	${SRC}/MaaTreeView.cpp
	${SRC}/MiniTemplate.cpp
	${SRC}/MoziScript.cpp
	${SRC}/OrinrinEditor.cpp
	${SRC}/PageCtrl.cpp
	${SRC}/SplitBar.cpp
	${SRC}/stdafx.cpp
	${SRC}/ToolBar.cpp
	${SRC}/TraceCtrl.cpp
	${SRC}/UnicodePalette.cpp
	${SRC}/UserDefinition.cpp
	${SRC}/VerticalScript.cpp
	${SRC}/ViewCaret.cpp
	${SRC}/ViewCentral.cpp
	${SRC}/ViewKeyButton.cpp
	${SRC}/ViewSelect.cpp
	${SRC}/ViewTrace.cpp
)

set_target_properties(
	"OrinrinEditor"
	PROPERTIES
	WIN32_EXECUTABLE ON
)

target_link_libraries(
	"OrinrinEditor"
	PUBLIC
	shell32 comdlg32 comctl32 imm32 sqlite3 shlwapi ole32
)

target_link_directories(
	"OrinrinEditor"
	PUBLIC
	"${CMAKE_SOURCE_DIR}/external/sqlite3/lib/${TOOLCHAIN_PREFIX}"
)

if (MSVC)
	target_link_options(
		"OrinrinEditor"
		PUBLIC
		"/MANIFEST:NO"
	)
else()
	target_link_options(
		"OrinrinEditor"
		PUBLIC
		"-municode" "-mwindows" "-mwin32"
		"-static-libgcc" "-static-libstdc++"
	)
endif()

target_include_directories(
	"OrinrinEditor"
	PRIVATE
	"${CMAKE_SOURCE_DIR}/external/sqlite3/src"
)

################################
# Viewer

add_executable(
	"OrinrinViewer"
	${SRC}/OrinrinViewer.rc
	${SRC}/DraughtBoard.cpp
	${SRC}/HoverTip.cpp
	${SRC}/MaaCatalogue.cpp
	${SRC}/MaaItems.cpp
	${SRC}/MaaSqlManipulate.cpp
	${SRC}/MaaTemplate.cpp
	${SRC}/MaaTreeView.cpp
	${SRC}/OrinrinViewer.cpp
	${SRC}/SplitBar.cpp
	${SRC}/stdafx.cpp
)

set_target_properties(
	"OrinrinViewer"
	PROPERTIES
	WIN32_EXECUTABLE ON
)

target_compile_definitions(
	"OrinrinViewer"
	PRIVATE
	_ORRVW
)

target_link_directories(
	"OrinrinViewer"
	PUBLIC
	"${CMAKE_SOURCE_DIR}/external/sqlite3/lib/${TOOLCHAIN_PREFIX}"
)

target_link_libraries(
	"OrinrinViewer"
	PUBLIC
	shell32 comdlg32 comctl32 imm32 sqlite3 shlwapi ole32
)

if (MSVC)
	target_link_options(
		"OrinrinViewer"
		PUBLIC
		"/MANIFEST:NO"
	)
else()
	target_link_options(
		"OrinrinViewer"
		PUBLIC
		"-municode" "-mwindows" "-mwin32"
		"-static-libgcc" "-static-libstdc++"
	)
endif()

target_include_directories(
	"OrinrinViewer"
	PRIVATE
	"${CMAKE_SOURCE_DIR}/external/sqlite3/src"
)

################################
# Collector

add_executable(
	"OrinrinCollector"
	${SRC}/OrinrinCollector.rc
	${SRC}/OrinrinCollector.cpp
	${SRC}/stdafx.cpp
)

set_target_properties(
	"OrinrinCollector"
	PROPERTIES
	WIN32_EXECUTABLE ON
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

if (MSVC)
	target_link_options(
		"OrinrinCollector"
		PUBLIC
		"/MANIFEST:NO"
	)
else()
	target_link_options(
		"OrinrinCollector"
		PUBLIC
		"-municode" "-mwindows" "-mwin32"
		"-static-libgcc" "-static-libstdc++"
	)
endif()
