#!/usr/bin/awk -f

$0 ~ /; / { print ; next }
$0 ~ /;/ { s = index($0, ";") ; printf("%-48s%s\n", substr($0, 0, s - 1), substr($0, s)) ; next }
{ print }

