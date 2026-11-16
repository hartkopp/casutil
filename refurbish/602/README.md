# Refurbishing FX-601P/FX-602P tape recordings

Recordings of FX-601P/FX-602P and FX-501P/FX-502P programs from old
cassettes often have a short or noisy lead-in, a broken end or read errors
outside of the contents. They load badly into the calculator and are hard to
work with. The plan is to keep the original recording as it is, but to use a
clean recording created from its contents:

1. `list602 -w` decodes the recording into a listing (`.prg`), which shows
   the programs, registers, the name and the memory partition, and remarks
   on read errors, a missing footer or a missing end.
2. `prg602` creates a new WAV file from the listing, as the calculator would
   save it: a lead-in of 5 seconds, the same header and contents, a complete
   footer of 8 bytes 0xFF followed by 8 bytes 0x00, 24000 samples per
   second.
3. `list602 -w` reads the new recording again, and its contents must be the
   contents of the original recording. Recordings that were cut off (the
   missing registers become 0) or have read errors in the contents are
   reported for a manual check.

Two scripts implement this for a directory tree of recordings:

| Script | Result |
|---|---|
| `regenerate.sh <source> <target>` | a new tree `<target>` with the new recordings and their listings under the same names, the source tree stays unchanged |
| `regenerate_inplace.sh [directory]` | in place (default `casiowav`): each recording `name.wav` becomes a directory `name/` with the original as `name_rawdump.wav`, the listing `name.prg` and the new recording `name.wav` |

Both scripts print `OK`, `CHECK` with the remarks of the listing, or `FAIL`
for each recording and a summary at the end. `regenerate_inplace.sh` moves
the original only if the new recording was created and skips recordings
that already have their directory, so it can be run again. The programs
`list602` and `prg602` must be in the `PATH`, or `BIN` names their
directory:

```
BIN=~/casutil/src refurbish/602/regenerate_inplace.sh
```

The listings can be edited and translated again with `prg602`, e.g. to fix
a read error by hand.
