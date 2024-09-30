MEMORY
{
PAGE 0 : 

	RAMM0           	: origin = 0x000122, length = 0x0002DE

PAGE 1 : 

 
   PIE_VECT   : origin = 0x000D02, length = 0x000200  /*  PIE Vector 0x000D02~0x000E02 for Vector table*/

   RAMM1           : origin = 0x000400, length = 0x000400     /* on-chip RAM block M1 */

   }
 

 
SECTIONS
{

   .reset           : > RAMM1,       PAGE = 1
   .text            : > RAMM1,       PAGE = 1  
   codestart		: > RAMM1,		 PAGE = 1
   PieVectTable     : > PIE_VECT,    PAGE = 1

}
