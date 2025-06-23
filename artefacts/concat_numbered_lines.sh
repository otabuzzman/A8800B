#!/usr/bin/awk -f

BEGIN {
    next_marker  = ARGV[1]
    end_marker   = ARGV[2]
    ARGV[1] = ""; ARGV[2] = ""
    concatenating = 0
    output = ""
}

{
    line = $0
    gsub(/[ \t]+$/, "", line)

    if (line == end_marker) {
        if (concatenating && output != "")
            print output
        exit 0
    }

    if (line == next_marker) {
        if (concatenating && output != "")
            print output
        output = line
        concatenating = 1
	next_marker++
        next
    }

    if (line ~ ("^" next_marker " ")) {
        if (concatenating && output != "")
            print output
        output = line
        concatenating = 1
	next_marker++
        next
    }

    if (next_marker ~"^7" && line ~ ("^1" substr(next_marker, 2))) {
        if (concatenating && output != "")
            print output
        output = next_marker
        concatenating = 1
	next_marker++
        next
    }

    if (concatenating) {
        output = output " " $0
    }
}

