#!/usr/bin/env bash

# @file
# @brief src配下の全ファイルにUTF-8 BOMを付加したsrc_bombを生成します
# @details 現時点でソースコードはBOMなしUTF-8でエンコードされていますがこの状態だとMSVCがうまく処理できないことがあります。
#          そのためここでBOM付きUTF-8のソースコードを生成します。
#          最近のMSVCなら/utf-8とか/source-charset:utf-8とかがありますが少なくともVS2010には存在しなかったためこうしてます。
#          なおMinGW-w64 GCCはそのままでもうまく処理できるためそれを用いてビルドする分には不要です。
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

# ディレクトリ作成
find . -type d -print0 | xargs -0 -I'{}' mkdir -p '../src_bomb/{}'

# BOM付加
find . -type f -print0 | while IFS= read -r -d '' i; do
	{ printf '\xef\xbb\xbf'; cat "$i"; } > "../src_bomb/$i"
done

# Git管理から省いておく
echo '*' > ../src_bomb/.gitignore
