#!/usr/bin/awk -f

{
    i = 2
    count = 0
    # up to four consecutive fields starting at 2nd
    while (i <= NF && count < 4 && match($i, /[0-9]{5,6}[^ ]?/)) {
        count++
        i++
    }

    printf "%s", $1

    # remaining fields after skipped
    for (j = i; j <= NF; j++) {
        printf " %s", $j
    }
    print ""
}
