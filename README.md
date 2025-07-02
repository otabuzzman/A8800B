# Altair 8800 BASIC
A transcript of the PDF containing the [Altair 8800 BASIC source code](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf) shared by Bill Gates.

The transcript largely corresponds to the PDF. Addresses and opcodes of the Macro-10 Assembler have been removed, comment indentations standardized, and typos corrected. Of course, there are most likely previously undetected transcription errors.

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

3. OCR error corrections by hand
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

5. Iterations of steps 3 and 4 until apparently ok

### Artefacts
|File|Description|
|:---|:---|
|`artefacts/part-*.pdf`|The original PDF in parts of four pages each, no larger than 5 MB.|
|`artefacts/part-*.txt`|The raw text files from AWS Textract.|
|`artefacts/*.sh`|Scripts for bash and AWK processing.|
|`F[34].2ND`|Intermediate files with processing result of step 2.|
|`F[34].3RD`|Intermediate files with processing result of step 3.|
|`F[34].4TH`|Processing result of step 4. The actual transcripts of F3 and F4.|
|`*.grep`|Missing label definitions and references (candidates).|

### Notes and findings
The PDF starts with the BASIC code followed by the math package followed by initialization code. Banner pages F3 and F4 prepend BASIC and math package. Initialization code is at end of math package. F4 banner is followed by a page of handwritten notes, followed by a duplicate of the last page with the symbol references from F3. There is a missing double-quote (") at [line 1001](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=12) and a missing closing angle bracket (>) at [line 7291](https://images.gatesnotes.com/12514eb8-7b51-008e-41a9-512542cf683b/34d561c8-cf5c-4e69-af47-3782ea11482e/Original-Microsoft-Source-Code.pdf#page=76) in F3 where the entire latter line could be accidentally leftover code. F3 and F4 have LENGTH set to 1 (8k) and 2 (12k), respectively. Symbols $CODE, RESLST and VMOVE are undefined (see `nodefs.grep`) but can probably be looked up in A6502B (see [references](#References) section). LENGTH set to 2 references more undefined symbols.
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
- [Macro 10 Assembler Reference Manual](https://bitsavers.org/pdf/dec/pdp10/TOPS10_softwareNotebooks/vol13/AA-C780C-TB_Macro_Assembler_Reference_Manual_Apr78.pdf)
- [Macro 10 Assembler Programmer's Reference](https://bitsavers.org/pdf/dec/pdp10/TOPS10/1973_Assembly_Language_Handbook/02_1973AsmRef_macro.pdf)
- [Blog on Microsoft BASIC for 6502 source code](https://www.pagetable.com/?p=774)
