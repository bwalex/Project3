// InterfaceTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "assert.h"

int _tmain(int argc, _TCHAR* argv[])
{
	LOCATE_HANDLE hLocate = NULL;
	DWORD ErrorNum,NumOfCards,LoopCntr,LEDs;
	char ErrorString[1000];
	DIME_HANDLE hCard1;
	double ActualFrequency; 
	VIDIME_HANDLE viHandle;
	DWORD Result, error=0;
	DWORD j=0;
	DWORD ReadData[2048];
	DWORD WriteData[2048];
	DWORD ret, tmp = 0, tmp_write;

	//Call the function to locate our BenOne card on the USB bus
	if( (hLocate = DIME_LocateCard(dlUSB,mbtTHEBENONE,NULL,dldrDEFAULT,dlDEFAULT)) == NULL)
	{//Error hLocate NULL
		//Print the error then terminate the program
		DIME_GetError(NULL,&ErrorNum,ErrorString);
		printf("Error %d: %s\n", ErrorNum, ErrorString);
		getchar();
		return 1;
	}

	//Determine how many Nallatech cards have been found.
	NumOfCards = DIME_LocateStatus(hLocate,0,dlNUMCARDS);
	printf("%d Nallatech card(s) found.\n", NumOfCards);

	//Get the details for each card detected.
	for (LoopCntr=1; LoopCntr<=NumOfCards; LoopCntr++)
	{
		printf("Details of card number %d, of %d:\n",LoopCntr,NumOfCards);
		printf("\tThe card driver for this card is a %s.\n",(char*)DIME_LocateStatusPtr(hLocate,LoopCntr,dlDESCRIPTION));
		printf("\tThe cards motherboard type is %d.\n",DIME_LocateStatus(hLocate,LoopCntr,dlMBTYPE));
	}

	//Open up the first card found. To open the nth card found simple change the second argument to n. 
	hCard1 = DIME_OpenCard(hLocate,1,dccOPEN_NO_OSCILLATOR_SETUP); //opens up card 1 with default flags
	if (hCard1 == NULL) //check to see if the open worked.
	{
		printf("Card Number One failed to open.\n");
		DIME_CloseLocate(hLocate);
		getchar();
		return 1;
	}

	printf("Specified card successfully opened.\n");


	//Open the handle to vidime
	//viHandle = viDIME_Open(hCard1, 0);

	assert(((unsigned long)&tmp) % 4 == 0);
	assert(((unsigned long)&tmp_write) % 4 == 0);
	printf("Writing something whenever you press a button\n");
	getchar();

	tmp_write = 0x0FFFFFF0;
	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, 10000);
	printf("A) DIME_AddressWriteSingle, ret=%d\n", ret);

	tmp_write = 0x12345678;
	ret = DIME_DataWriteSingle(hCard1, &tmp_write, NULL, 10000);
	printf("A) DIME_DataWriteSingle, ret=%d\n", ret);

	tmp_write = 0xFFFFFFFF;
	//tmp_write = 0x00000000;
	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, 10000);
	printf("B) DIME_AddressWriteSingle, ret=%d\n", ret);

	//DIME_DataWrite(hCard1, WriteData, 256, NULL, NULL, 10000);
	//tmp_write = 0xDEADC0DE;

	//printf("Reading something whenever you press a button\n");
	//getchar();
	ret = DIME_DataReadSingle(hCard1, &tmp, NULL, 10000);
	printf("B) DIME_DataReadSingle, ret=%d\n", ret);
	printf("Read: %#x\n", tmp);


	//DIME_DataRead(hCard1, ReadData, 128, NULL, NULL, 10000);



	//viDIME_ReadRegister(viHandle, 0,0);
	//viDIME_WriteRegister(viHandle, 0, 1234, 10000);
	//Result = viDIME_DMAWrite(viHandle,WriteData,256,0, NULL, NULL, 5000);
	//Result = viDIME_DMARead(viHandle,ReadData,256,0, NULL, NULL, 5000);
	//Close the card
	//viDIME_Close(viHandle);

	DIME_CloseCard(hCard1);//Closes down the card.

	//Finally the last thing that should be done is to close down the locate.
	DIME_CloseLocate(hLocate);

	printf("Done\n");
	getchar();
	return 0;
}
