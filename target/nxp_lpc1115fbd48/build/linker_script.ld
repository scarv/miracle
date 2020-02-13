
MEMORY
{
    FLASH : org = 0x00000000, len = 64k
    SRAM  : org = 0x10000000, len = 8k
}
  
SECTIONS
{
        
	. = ORIGIN(FLASH);
        .text : {
		  *(.vectors); /* The interrupt vectors */
		  *(.text);
        } >FLASH
	. = ORIGIN(SRAM);
        .data : {
          INIT_DATA_VALUES = LOADADDR(.data);
          INIT_DATA_START = .;
            *(.data);
          INIT_DATA_END = .;
        } >SRAM AT>FLASH
	BSS_START = .;
	.bss : {
	  
	    *(.bss);
	  
	} > SRAM
	BSS_END = .;
}
