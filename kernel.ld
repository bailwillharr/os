OUTPUT_FORMAT("binary")
ENTRY(_start)
SECTIONS
{
    . = 0x10000;

    .text BLOCK(16K) : ALIGN(16K)
    {
        *(.text.prologue)
        *(.text)
    }

    .rodata BLOCK(16K) : ALIGN(16K)
    {
        *(.rodata)
    }

    .data BLOCK(16K) : ALIGN(16K)
    {
        *(.data)
    }

    .bss BLOCK(16K) : ALIGN(16K)
    {
        *(.bss)
    }

    end = .;
}
