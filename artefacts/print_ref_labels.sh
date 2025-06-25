#!/usr/bin/awk -f

{
    for (nf = 2; nf <= NF ; nf++) {
       if ($nf ~ /^[A-Z0-9]+:$/) {
            print $nf > "/dev/stderr" ; next
        }
        if ($nf ~ /^(ACI|ADC|ADD|ADI|ANA|ANI|CALL|CC|CM|CMA|CMC|CMP|CNC|CNZ|CP|CPE|CPI|CPO|CZ|DAA|DAD|DCR|DCX|DI|EI|HLT|IN|INR|INX|JC|JM|JMP|JNC|JNZ|JP|JPE|JPO|JZ|LDA|LDAX|LHLD|LXI|MOV|MVI|NOP|ORA|ORI|OUT|PCHL|POP|PUSH|RAL|RAR|RC|RET|RIM|RLC|RM|RNC|RNZ|RP|RPE|RPO|RRC|RST|RZ|SBB|SBI|SHLD|SIM|SPHL|STA|STAX|STC|SUB|SUI|XCHG|XRA|XRI|XTHL)$/) {
            if ($(nf + 1) ~ /,/) next
            if ($(nf + 1) ~ /^.{1,2}$/) next
            print $(nf + 1) ; next
        }
    }
}