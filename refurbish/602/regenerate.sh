#!/bin/bash
# regenerate.sh <source dir> <target dir>
#
# Recreates the FX-601P/FX-602P and FX-501P/FX-502P tape recordings of
# <source dir> (e.g. casiowav) as clean WAV files in <target dir> with
# the same subdirectories and file names: list602 -w decodes a recording
# into a listing, prg602 creates a new WAV file from it with a lead-in
# of 5 seconds and a complete footer. The listing of the new file is
# compared with the listing of the recording.
#
# Needs list602 and prg602 in the PATH (sudo make install) or set
# BIN=/path/to/casutil/src.

SRC=${1:?usage: regenerate.sh <source dir> <target dir>}
DST=${2:?usage: regenerate.sh <source dir> <target dir>}
BIN=${BIN:+$BIN/}
LIST=${BIN}list602
PRG=${BIN}prg602

ok=0; warn=0; fail=0
while IFS= read -r -d '' wav; do
    rel=${wav#$SRC/}
    out=$DST/$rel
    base=${out%.wav}
    mkdir -p "$(dirname "$out")"

    # 1. decode the recording into a listing
    if ! "$LIST" -w "$wav" > "$base.prg" 2> "$base.log"; then
        echo "FAIL   $rel: list602 failed"; fail=$((fail + 1)); continue
    fi

    # 2. create a clean WAV file from the listing
    if ! "$PRG" "$base.prg" "$out" >> "$base.log" 2>&1; then
        echo "FAIL   $rel: prg602 failed, see ${base#$DST/}.log"
        fail=$((fail + 1)); continue
    fi

    # 3. compare the contents of both listings without the comments,
    #    which describe read errors, missing footers and ends
    if ! cmp -s <(grep -v -e '^#' -e '^$' "$base.prg" | sed 's/  *#.*$//') \
                <("$LIST" -w "$out" 2>/dev/null | grep -v -e '^#' -e '^$' | sed 's/  *#.*$//'); then
        if grep -q '^# End of file missing' "$base.prg"; then
            echo "CHECK  $rel: recording cut off, prg602 filled the missing registers with 0:"
            grep '^# End of file missing' "$base.prg" | sed 's/^/         /'
            warn=$((warn + 1))
        else
            echo "FAIL   $rel: the new recording has other contents"
            fail=$((fail + 1))
        fi
        continue
    fi

    # 4. remarks of the old recording, e.g. read errors in the contents
    #    or a missing end (prg602 fills missing registers with 0)
    notes=$(grep -E '^# (Read error|End of file|Footer|Unexpected)|error in byte' "$base.prg" \
            | grep -v 'outside of the contents' | grep -v '^# Footer incomplete' | head -3)
    if [ -n "$notes" ]; then
        echo "CHECK  $rel:"; echo "$notes" | sed 's/^/         /'
        warn=$((warn + 1))
    else
        echo "OK     $rel"; ok=$((ok + 1))
        rm -f "$base.log"
    fi
done < <(find "$SRC" -name '*.wav' -print0 | sort -z)

echo
echo "$ok ok, $warn to check, $fail failed"
