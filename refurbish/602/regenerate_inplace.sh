#!/bin/bash
# regenerate_inplace.sh [directory]
#
# Works on the recordings in [directory] (default casiowav in the
# current directory). For each recording, e.g.
# casiowav/games/PF_LOTTO_602M20_P012345.wav, a directory with the name
# of the recording is created:
#
#   casiowav/games/PF_LOTTO_602M20_P012345/
#       PF_LOTTO_602M20_P012345_rawdump.wav   the original recording
#       PF_LOTTO_602M20_P012345.prg           listing (list602 -w)
#       PF_LOTTO_602M20_P012345.wav           clean recording (prg602)
#
# The new recording is checked as in refurbish/602/regenerate.sh: its
# listing must have the contents of the listing of the original. The
# original is moved into the directory only if the new recording was
# created; otherwise it stays in place and the directory is removed.
# Recordings that already have their directory are skipped, so the
# script can be run again.
#
# Needs list602 and prg602 in the PATH (sudo make install) or set
# BIN=/path/to/casutil/src.

ROOT=${1:-casiowav}
BIN=${BIN:+$BIN/}
LIST=${BIN}list602
PRG=${BIN}prg602

[ -d "$ROOT" ] || { echo "no directory $ROOT here, start in its parent directory"; exit 1; }

ok=0; warn=0; fail=0; skip=0
while IFS= read -r -d '' wav; do
    dir=${wav%.wav}
    name=${dir##*/}
    rel=${wav#$ROOT/}

    # created by an earlier run: <name>/<name>.wav
    [ "$(basename "$(dirname "$wav")")" = "$name" ] && continue
    if [ -e "$dir" ]; then
        echo "SKIP   $rel: ${dir#$ROOT/} exists"; skip=$((skip + 1)); continue
    fi

    mkdir "$dir"
    prg=$dir/$name.prg
    new=$dir/$name.wav
    log=$dir/$name.log

    # 1. decode the recording into a listing, 2. create a clean WAV file
    if ! "$LIST" -w "$wav" > "$prg" 2> "$log"; then
        echo "FAIL   $rel: list602 failed"; rm -rf "$dir"; fail=$((fail + 1)); continue
    fi
    if ! "$PRG" "$prg" "$new" >> "$log" 2>&1; then
        echo "FAIL   $rel: prg602 failed:"; sed 's/^/         /' "$log"
        rm -rf "$dir"; fail=$((fail + 1)); continue
    fi

    # 3. compare the contents of both listings without the comments,
    #    which describe read errors, missing footers and ends
    status=OK; notes=
    if ! cmp -s <(grep -v -e '^#' -e '^$' "$prg" | sed 's/  *#.*$//') \
                <("$LIST" -w "$new" 2>/dev/null | grep -v -e '^#' -e '^$' | sed 's/  *#.*$//'); then
        if grep -q '^# End of file missing' "$prg"; then
            status=CHECK
            notes="recording cut off, prg602 filled the missing registers with 0:
$(grep '^# End of file missing' "$prg")"
        else
            echo "FAIL   $rel: the new recording has other contents"
            rm -rf "$dir"; fail=$((fail + 1)); continue
        fi
    else
        # 4. remarks of the old recording, e.g. read errors in the contents
        notes=$(grep -E '^# (Read error|End of file|Footer|Unexpected)|error in byte' "$prg" \
                | grep -v 'outside of the contents' | grep -v '^# Footer incomplete' | head -3)
        [ -n "$notes" ] && status=CHECK
    fi

    # 5. move the original into the directory
    mv "$wav" "$dir/${name}_rawdump.wav"
    if [ $status = OK ]; then
        echo "OK     $rel"; ok=$((ok + 1)); rm -f "$log"
    else
        echo "CHECK  $rel:"; echo "$notes" | sed 's/^/         /'
        echo "$notes" >> "$log"; warn=$((warn + 1))
    fi
done < <(find "$ROOT" -name '*.wav' ! -name '*_rawdump.wav' -print0 | sort -z)

echo
echo "$ok ok, $warn to check, $fail failed, $skip skipped"
