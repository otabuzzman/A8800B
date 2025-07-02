#!/usr/bin/awk -f

BEGIN {
    level = 0
}

{
    output = ""
    for (i = 1; i <= length($0); i++) {
        ch = substr($0, i, 1)
        if (ch == "<") {
            level++
            output = output "<" level
        } else if (ch == ">") {
            if (level > 0) {
                output = output level ">"
                level--
            } else {
                output = output "0>"
                printf "*** unmatched closing > at line %d, char %d\n", NR, i > "/dev/stderr"
                print  > "/dev/stderr"
            }
        } else {
            output = output ch
        }
    }

    print output
}

END {
    if (level > 0) {
        printf "*** %d unmatched opening <\n", level > "/dev/stderr"
    }
}
