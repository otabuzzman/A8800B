#!/usr/bin/awk -f

# prints references on stdout
# prints declarations on stderr
#
# usage cues:
#   $0 F[34].4TH > ... 2> ...
#   sed -e 's,>,,g' -e 's,:,,g' | sort -u <file with stdout from $0) > ...
#   sed -e 's,>,,g' -e 's,#,,g' | sort -u <file with stderr from $0) > ...
#   manual processing of resulting files ...
#   sort -u processed files into single files containing all decs and refs
#   compile lists with defs not in refs and vice versa
#   for lab in $(cat <refs file>) ; do grep -qs $lab <defs file> || echo $lab ; done > <not declared file>
#   for lab in $(cat <defs file>) ; do grep -qs $lab <refs file> || echo $lab ; done > <not referenced file>
#   grep unknown refs and defs from resulting files in *.4TH and manually check/ update *.3RD accordingly
#   for lab in $(cat <not declared file>) ; do echo "*** $lab" ; grep $lab *.4TH ; echo ; echo ; echo ; done > ...
#   for lab in $(cat <not referenced file>) ; do echo "*** $lab" ; grep $lab *.4TH ; echo ; echo ; echo ; done > ...

BEGIN {
  comment = ""
}

$2 ~ /COMMENT/ {
  comment = $3
}

NF > 1 && comment == $2 {
  comment = ""
}

comment != "" {
  next
}

$2 ~ /;/ { next }

{
    for (nf = 2; nf <= NF ; nf++) {
       if ($nf ~ /^[A-Z0-9]+:$/) {
            print $nf > "/dev/stderr" ; continue
        }
        if ($nf ~ /^(ACI|ADC|ADD|ADI|ANA|ANI|CALL|CC|CM|CMA|CMC|CMP|CNC|CNZ|CP|CPE|CPI|CPO|CZ|DAA|DAD|DCR|DCX|DI|EI|HLT|IN|INR|INX|JC|JM|JMP|JNC|JNZ|JP|JPE|JPO|JZ|LDA|LDAX|LHLD|LXI|MOV|MVI|NOP|ORA|ORI|OUT|PCHL|POP|PUSH|RAL|RAR|RC|RET|RIM|RLC|RM|RNC|RNZ|RP|RPE|RPO|RRC|RST|RZ|SBB|SBI|SHLD|SIM|SPHL|STA|STAX|STC|SUB|SUI|XCHG|XRA|XRI|XTHL)$/) {
            if ($(nf + 1) ~ /^.,.$/) next
            if ($(nf + 1) ~ /,/) {
                split($(nf + 1), t, /,/)
                if (t[1] ~ /^....+$/) {
                    print t[1] ; next
                }
                if (t[2] ~ /^....+$/) {
                    print t[2] ; next
                }
            }
            if ($(nf + 1) ~ /;/) next
            if ($(nf + 1) ~ /"/) next
            if ($(nf + 1) ~ /^.{1,2}$/) next
            print $(nf + 1) ; next
        }
    }
}
