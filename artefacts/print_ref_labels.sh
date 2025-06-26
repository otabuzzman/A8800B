#!/usr/bin/awk -f

# prints references on stdout
# prints declarations on stderr
#
# usage cues:
#   $0 F[34].4TH > refs 2> defs
#   sed -e 's,>,,g' -e 's,#,,g' refs | sort -u > refs.u
#   sort -u defs > defs.u
#   manually check/ fix resulting *.u files
#   compile lists with defs not in refs and vice versa
#   for lab in $(cat refs.u) ; do grep -qs $lab defs.u || echo $lab ; done > nodefs
#   for lab in $(cat defs.u) ; do grep -qs $lab refs.u || echo $lab ; done > norefs
#   grep unknown refs and defs from resulting files in *.4TH and manually check/ fix *.3RD accordingly
#   for lab in $(cat nodefs) ; do echo "*** $lab" ; grep $lab *.4TH ; echo ; echo ; echo ; done > nodefs.grep
#   for lab in $(cat norefs) ; do echo "*** $lab" ; grep $lab *.4TH ; echo ; echo ; echo ; done > norefs.grep

BEGIN {
  comment = ""
}

$2 ~ /COMMENT/ {
  comment = $3 ; next
}

NF > 1 && comment == $2 {
  comment = "" ; next
}

comment != "" {
  next
}

$2 ~ /;/ { next }

{
    for (nf = 2; nf <= NF ; nf++) {
        if ($nf ~ /;/) next
        if ($nf ~ /^[0-9]+[>]*$/) next
        if ($nf ~ /^[A-Z0-9]+:[>]*/) {
            print substr($nf, 0, index($nf, ":") - 1) > "/dev/stderr" ; continue
        }
        if ($nf ~ /^(ACI|ADC|ADD|ADI|ANA|ANI|CALL|CC|CM|CMA|CMC|CMP|CNC|CNZ|CP|CPE|CPI|CPO|CZ|DAA|DAD|DCR|DCX|DI|EI|HLT|IN|INR|INX|JC|JM|JMP|JNC|JNZ|JP|JPE|JPO|JZ|LDA|LDAX|LHLD|LXI|MOV|MVI|NOP|ORA|ORI|OUT|PCHL|POP|PUSH|RAL|RAR|RC|RET|RIM|RLC|RM|RNC|RNZ|RP|RPE|RPO|RRC|RST|RZ|SBB|SBI|SHLD|SIM|SPHL|STA|STAX|STC|SUB|SUI|XCHG|XRA|XRI|XTHL)$/) {
            if ($(nf + 1) ~ /;/) next
            if ($(nf + 1) ~ /^[0-9]+$/) next
            if ($(nf + 1) ~ /^.,.[>]*$/) next
            if ($(nf + 1) ~ /^.,[0-9]+[>]*$/) next
            if ($(nf + 1) ~ /,/) {
                split($(nf + 1), t, /,/)
                if (t[1] ~ /[-+*]/) next
                if (t[1] ~ /^...+$/) {
                    print t[1] ; next
                }
                if (t[2] ~ /[-+*]/) next
                if (t[2] ~ /^...+$/ && t[2] !~ /"."/ && t[2] !~ /^[0-9]+/) {
                    print t[2] ; next
                }
            }
            if ($(nf + 1) ~ /[-+*]/) next
            if ($(nf + 1) ~ /"/) next
            if ($(nf + 1) ~ /^.{1,2}[>]*$/) next
            print $(nf + 1) ; next
        }
    }
}
