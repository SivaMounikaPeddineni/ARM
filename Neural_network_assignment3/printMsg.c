
#include "stm32f4xx.h"
#include <string.h>
void printMsg(const int a)
{
	 char Msg[100];
	 char *ptr;
	switch (a) {
            case 1:
							  sprintf(Msg, "%x.Logic Function: AND\n", a);
                break;
            case 2:
                sprintf(Msg, "%x.Logic Function: OR\n", a);
                break;
            case 3:
                sprintf(Msg, "%x.Logic Function: NOT\n", a);
                break;
						case 4:
                sprintf(Msg, "%x.Logic Function: NAND\n", a);
						 break;
 						case 5:
                sprintf(Msg, "%x.Logic Function: NOR\n", a);
						break;						
						case 6:
                sprintf(Msg, "%x.Logic Function: XOR\n", a);
 						 break;
						case 7:
                sprintf(Msg, "%x.Logic Function: XNOR\n", a);  
	}

	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}
void printMsg2p(const int a, const int b)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x ", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, "%d\n", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printMsg4p(const int a, const int b, const int c, const int d)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x\t", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }

	 sprintf(Msg, "%x\t", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }

	 sprintf(Msg, "%x\t", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }

	 sprintf(Msg, "%x\n", d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 }
}

