#!/usr/bin/awk -f

BEGIN {
  comment = ""
  nindent = ""
}

$0 ~ /^[0-9] / { nindent = "   " }
$0 ~ /^[0-9]{2} / { nindent = "  " }
$0 ~ /^[0-9]{3} / { nindent = " " }
$0 ~ /^[0-9]{4} / { nindent = "" }

$0 ~ /; / {
  print nindent $0 ; next
}

$2 ~ /COMMENT/ {
  comment = $3
}

NF > 1 && comment == $2 {
  comment = ""
}

comment != "" {
  print nindent $0 ; next
}

{
  for (nf=1 ; nf <= NF ; nf++) {
    eol = 1
    if (nf == 1) {
      printf("%4s ", $nf) ; continue
    }
    if (nf == 2 && ! ($nf ~ /SEARCH|SUBTTL|SALL|IFE|^DEFINE|IFN|PAGE|TITLE|IFNDEF|COMMENT|RADIX|INTERNAL|EXTERNAL|RELOC/ || $nf ~ /.+:$/))
      printf("         ")
    if ($nf ~ /;/) {
      print substr($0, index($0, ";")) ; eol = 0 ; break
    }
    printf("%-9s", $nf)
    if (nf == 2 && $nf ~/TITLE|SUBTTL/) {
      print substr($0, index($0, $3)) ; eol = 0 ; break
    }
  }
  if (eol == 1) print ""
}

