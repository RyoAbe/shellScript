#!/bin/sh

# [概要]
#
# [使い方]
# 第1引数 ... アプリケーションURL
# 第2引数 ... APP IDの識別子(Bundle Identifier)
# 第3引数 ... アラートタイトル
# 第4引数 ... plistファイル名

# [使用例]
# $./plist_out.sh http://xxxx.co.jp/xxxx.ipa jp.co.xxxx アラートタイトル xxxx_plist_file
# (引数がなければデフォルトの値が使われる)
#------------------------------------------------------------------------------------

# アプリケーションURL
APPLICATIN_URL="http://xxxx.co.jp/xxxx.ipa"

# APP IDの識別子
BUNDLE_IDENTIFIER="jp.co.xxxx"

# 端末からDL用リンク押下時にアラートで表示される
TITLE="アラートタイトル"

# plist出力先ディレクトリ名
OUT_PLIST_DIR="out_plist_dir"

# plistファイル名 
PLIST_FILE_NAME="xxxx_plist_file"

# Set Args
if [ "$1" != "" ] ; then
	APPLICATIN_URL=$1
fi
if [ "$2" != "" ] ; then
	BUNDLE_IDENTIFIER=$2
fi
if [ "$3" != "" ] ; then
	TITLE=$3
fi
if [ "$3" != "" ] ; then
	PLIST_FILE_NAME=$4
fi

FORMAT_PLIST="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
					<string>%s</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<string>%s</string>
				<key>bundle-version</key>
				<string>0.1</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>%s</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>\n"

OUT_PLIST=$(printf "${FORMAT_PLIST}" "${APPLICATIN_URL}" "${BUNDLE_IDENTIFIER}" "${TITLE}")
echo "${OUT_PLIST}"



# Create plist
echo "${OUT_PLIST}" > "${PWD}/${OUT_PLIST_DIR}/${PLIST_FILE_NAME}.plist"
