#!/usr/bin/env bash

# @file
# @brief src配下の全ファイルをUTF-8からCP932に変換したsrc_cp932を生成します
# @details 現時点でソースコードはBOMなしUTF-8でエンコードされていますがこの状態だとMSVCがうまく処理できないことがあります。
#          そのためここでCP932のソースコードを生成します。
#          最近のMSVCなら/utf-8とか/source-charset:utf-8とかがありますが少なくともVS2010には存在しなかったためこうしてます。
#          なおMinGW-w64 GCCはそのままでもうまく処理できるためそれを用いてビルドする分には不要です。
#          最初はBOM付きUTF-8に変換していましたがリソース周りでコンパイルエラーになったためCP932に変換するようにしています。
# @author NNN1590
# @date   2026/07/14

# Orinrin Editor : AsciiArt Story Editor for Japanese Only
# Copyright (C) 2011 - 2014 Orinrin/SikigamiHNQ
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.

set -e
declare BASE_DIR
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${0}}")"; pwd)"
readonly BASE_DIR
cd "${BASE_DIR}/../src"

declare -r NEW_SRC="${BASE_DIR}/../src_cp932"

# ディレクトリ作成
find . -type d -print0 | xargs -0 -I'{}' mkdir -p "${NEW_SRC}/{}"

# CP932に変換
declare from_filename=""
find . -type f -print0 | while IFS= read -r -d '' i; do
	echo "Processing ${i} ..."
	from_filename="${i}"

	# リソースファイルならcode_page指定を修正する
	if [[ "$i" =~ \.rc$ ]]; then
		from_filename="${NEW_SRC}/${i}.new"
		sed -E -e 's/#[ \t]*pragma[ \t]+code_page[ \t]*\([ \t]*65001[ \t]*\)/#pragma code_page (932)/g' "${i}" > "${from_filename}"
	fi

	iconv -f utf8 -t cp932 < "${from_filename}" > "${NEW_SRC}/${i}"
done

# Git管理から省いておく
echo '*' > "${NEW_SRC}/.gitignore"

echo 'Done!'
