#!/bin/zsh

function calc_filename () {
	SRC="${1}"
	HASH=$(md5 -q "${SRC}")
	EXT="${${SRC##*.}:l}"

	DATE=$(identify -quiet -format "%[exif:DateTimeOriginal]" "${SRC}")
	if [ -z "$DATE" ]; then
		DATE=$(identify -quiet -format "%[exif:DateTimeDigitized]" "${SRC}")
	fi
	if [ -z "$DATE" ]; then
		DATE=$(identify -quiet -format "%[exif:DateTime]" "${SRC}")
	fi

	if [ -z "$DATE" ]; then
		printf "no_exif/${HASH}.${EXT}"
	else
		printf "${DATE%%:*}/${${DATE//:}// /_}_${HASH}.${EXT}"
	fi
}

SRC_DIR="${1}"
DST_DIR="${2}"

if [ -z "${SRC_DIR}" ]; then
	echo "Usage: ${0} <src_dir> [dst_dir]"
	exit 1
fi

find "${SRC_DIR}" -type f \( -iname "*.heic" \) | while read SRC; do
	DST="${DST_DIR}/$(calc_filename "${SRC}")"
	if [ -z "${DST_DIR}" ]; then
		echo "plan: ${SRC} -> ${DST}"
		continue
	fi

	OUT_DIR=$(dirname "${DST}")
	if [ ! -d "${OUT_DIR}" ]; then
		mkdir -p "${OUT_DIR}"
	fi

	if [ -f "${DST}" ]; then
		echo "skip: ${SRC} -> ${DST} (already exists)"
	else
		echo "move: ${SRC} -> ${DST}"
		mv "${SRC}" "${DST}"
	fi
done
