#!/bin/sh

# [概要]
# ビルドして、ipaファイルを生成する
#
# [使い方]
# 第1引数 ... ターゲット名
# 第2引数 ... ipaファイル名(拡張子不要)
# 第3引数 ... Product Name(Build Settingsに書かれている)
# 第4引数 ... アプリのプロビジョニングファイルのフルパス
#
# [使用例]
# $./ipa_out.sh xxxx_target_name xxxx_ipa_file_name xxxx_product_name /Users/user/Library/MobileDevice/Provisioning\ Profiles/xxxx.mobileprovision
# (引数がなければデフォルトの値が使われる)
#----------------------------------------------------------------------------------

#SDK
SDK="iphoneos5.0"

# コンフィグレーション(「Debug」、「Release」、「Ad hoc」)
CONFIGURATION="Release"

# ベースディレクトリ
BASE_DIR="xxxx"

# Xcodeのプロジェクト名
PROJ_FILE_PATH="Projects/xxxx.xcodeproj"

# ターゲット名
TARGET_NAME="xxxx"

#「Build Settings」にある、プロダクト名
PRODUCT_NAME="xxxx"

# ipa出力先ディレクトリ名
OUT_IPA_DIR="out_ip"

# app出力先ディレクトリ名
OUT_APP_DIR="out_app"

# ipaファイル名 
IPA_FILE_NAME="xxxx"

# ライセンス取得時の開発者名
DEVELOPPER_NAME="iPhone Distribution: xxxx"

# アプリのプロビジョニングファイルのパス
PROVISIONING_PATH="${HOME}/Library/MobileDevice/Provisioning\ Profiles/xxxx.mobileprovision"

# Set Args
if [ "$1" != "" ] ; then
	TARGET_NAME=$1
fi
if [ "$2" != "" ] ; then
	IPA_FILE_NAME=$2
fi
if [ "$3" != "" ] ; then
	PRODUCT_NAME=$3
fi
if [ "$4" != "" ] ; then
	PROVISIONING_PATH=$4
fi

# Make output ipa file directory
# -------------------------
if [ ! -d ${OUT_IPA_DIR} ]; then
	mkdir "${OUT_IPA_DIR}"
fi

# Build
# -------------------------
xcodebuild clean -project "${PROJ_FILE_PATH}"
xcodebuild -project "${PROJ_FILE_PATH}" -sdk "${SDK}" -configuration "${CONFIGURATION}" -target "${TARGET_NAME}" install DSTROOT="${OUT_APP_DIR}"

# Create ipa File
# -------------------------
xcrun -sdk "${SDK}" PackageApplication "${PWD}/${BASE_DIR}/${OUT_APP_DIR}/Applications/${PRODUCT_NAME}.app" -o "${PWD}/${OUT_IPA_DIR}/${IPA_FILE_NAME}.ipa" -embed "${PROVISIONING_PATH}"


# Delete output app directory
# -------------------------
rm -rf "${PWD}/${BASE_DIR}/${OUT_APP_DIR}"
