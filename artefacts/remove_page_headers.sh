#!/usr/bin/awk -f

BEGIN {
  stop = ARGV[1]
  delete ARGV[1]
}

/MACRO 47[(]113[)]/i {
    idx = index($0, stop)
    if (idx > 0) {
      print substr($0, 1, idx - 1)
    } else {
      print
    }
}
