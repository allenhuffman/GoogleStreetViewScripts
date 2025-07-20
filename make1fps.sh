#!/bin/bash
#
# This script processes one or more video files, reducing their frame rate to
# 1 frame per second (fps) and compressing them using the H.265 codec.
# It outputs the processed videos with "_1fps" appended to their original
# names.
#
#
# 2025-07-20 - Created by Bing CoPilot, refined by Allen C. Huffman.
#
# Video Filtering:
# -vf "fps=1": Applies a video filter that reduces the frame rate to 1 frame
#   per second. Great for timelapse-like effects or drastically shrinking file
#   size.
#
# Codec & Compression
#
# -c:v libx265: Uses the H.265 (HEVC) video codec, which is highly efficient
#   at compressing video with good quality retention.
# -preset medium: Balances encoding speed vs compression.
#   Faster presets = less compression;
#   slower = smaller files but more CPU usage.
# -crf 25: Sets the Constant Rate Factor — a quality level for H.265.
#   Lower = better quality (but bigger size), higher = more compression.
#   25 is moderate: decent quality and compact output.
#
# Audio & Metadata
#
# -an: Removes the audio stream from the output.
# -tag:v hvc1: Tags the output to ensure it's recognized correctly on
#   platforms like Apple (which prefers hvc1 for HEVC).
# -map_metadata 0: Copies metadata from the input to the output.
# -movflags use_metadata_tags: Ensures metadata is written in a compatible way
#   for .mp4 containers.
#

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <video_file1> [video_file2] ..."
    exit 1
fi

# Loop through all provided file arguments
for input in "$@"; do
    [ -f "$input" ] || { echo "❌ Skipping: $input (not a file)"; continue; }

    [[ "$input" =~ _1fps\.mp4$ ]] && { echo "⏩ Skipping: $input"; continue; }

    output="${input%.*}_1fps.mp4"

    echo "🎥 Processing: $input → $output"

    ffmpeg -i "$input" -vf "fps=1" \
        -c:v libx265 -preset medium -crf 25 \
        -an -tag:v hvc1 -map_metadata 0 \
        -movflags use_metadata_tags "$output"

    echo "✅ Done: $output"
done

echo "All files processed."

# End of make1fps.sh
