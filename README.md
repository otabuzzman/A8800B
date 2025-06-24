# Altair 8800 BASIC
A transcript of the PDF containing the Altair 8800 BASIC source code shared by Bill Gates.

### Method and tools
1. OCR with [AWS Textract](https://aws.amazon.com/textract/)
2. Coarse layout reconstruction with AWK
  ```bash
  # BASIC
  cat part-0*.txt |\
    ./concat_numbered_lines.sh 1 7801 |\
    ./remove_page_headers.sh BASIC |\
    ./remove_addresses_and_opcodes.sh |\
    tee F3.2ND | less
  # math package
  cat part-02[5-9].txt part-03[0-8].txt |\
    ./concat_numbered_lines.sh 1 4827 |\
    ./remove_page_headers.sh MATHPK |\
    ./remove_addresses_and_opcodes.sh |\
    tee F4.2ND | less
  ```

3. Coarse OCR error corrections by hand
4. Fine layout reconstruction with AWK
  ```bash
  cat F3.3RD |\
    ./restore_indent.sh |\
    ./restore_comments.sh |\
    tee F3.4TH | less
  cat F4.3RD |\
    ./restore_indent.sh |\
    ./restore_comments.sh |\
    tee F4.4TH | less
  ```

5. Further error corrections by hand

### Artefacts
|File|Description|
|:---|:---|
|[Original-Microsoft-Source-Code.pdf](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf)|The PDF shared by Bill Gates.|
|`artefacts/part-*.pdf`|The original PDF in parts of four pages each, no larger than 5 MB.|
|`artefacts/part-*.txt`|The raw text files from AWS Textract.|
|`artefacts/*.sh`|Scripts for bash and AWK processing.|
|`F[34].2ND`|Intermediate files with processing result of step 2.|
|`F[34].3RD`|Intermediate files with processing result of step 3.|
|`F[34].4TH`|Intermediate files with processing result of step 4.|
|`F[34].5TH`|Processing result of last step. The actual transcripts of F3 and F4.|

### Notes on PDF
The PDF starts with the BASIC code followed by the math package. Banner pages F3 and F4 prepend each part. F4 is followed by a page of handwritten notes, followed by a duplicate of the last page with the symbol references from F3.
- [PDF page 1](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf) 1st page of BASIC code
- [page 82](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=82) last page of BASIC code
- [page 100](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=100) 1st page of math package
- [page 151](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=151) last page of math package
- [page 37](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=37) handwritten notes
- [page 98](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=98) handwritten notes
- [page 99](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=99) duplicate of [page 96](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=96)
- [page 101](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=101) handwritten notes
- [page 127](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=127) handwritten notes
- [page 129](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=129) handwritten notes
- [page 130](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=130) handwritten notes
- [page 135](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=135) handwritten notes
- [page 137](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=137) handwritten notes
- [page 149](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=149) handwritten notes

### References
- [Macro 10 Assembler Programmer's Reference](https://bitsavers.org/pdf/dec/pdp10/TOPS10/1973_Assembly_Language_Handbook/02_1973AsmRef_macro.pdf)
- [Macro 10 Assembler Reference Manual](https://bitsavers.org/pdf/dec/pdp10/TOPS10_softwareNotebooks/vol13/AA-C780C-TB_Macro_Assembler_Reference_Manual_Apr78.pdf)
- [Blog on Microsoft BASIC for 6502 source code](https://www.pagetable.com/?p=774)
