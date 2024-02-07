#!/bin/zsh

function calc_filename () {
	SRC="${1}"
	HASH=$(md5 -q "${SRC}")
	EXT="${${SRC##*.}:l}"

	DATE=$(ffprobe -v quiet -print_format json -show_format "${SRC}" | jq -r ".format.tags.creation_time // empty")
	if [ -z "$DATE" ]; then
		DATE=$(ffprobe -v quiet -print_format json -show_format "${SRC}" | jq -r '.format.tags["com.apple.quicktime.creationdate"] // empty')
	fi

	if [ -z "$DATE" ]; then
		printf "movies/no_exif/${HASH}.${EXT}"
	else
		printf "movies/${${${DATE%%[+.]*}//[:-]}//T/_}_${HASH}.${EXT}"
	fi
}

SRC_DIR="${1}"
DST_DIR="${2}"

if [ -z "${SRC_DIR}" ]; then
	echo "Usage: ${0} <src_dir> [dst_dir]"
	exit 1
fi

find "${SRC_DIR}" -type f \( -iname "*.mov" -o -iname "*.mp4" \) | while read SRC; do
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
