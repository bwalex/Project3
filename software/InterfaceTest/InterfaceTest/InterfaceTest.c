// InterfaceTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "assert.h"

int _tmain(int argc, _TCHAR* argv[])
{
	LOCATE_HANDLE hLocate = NULL;
	DWORD ErrorNum,NumOfCards;
	char ErrorString[1000];
	DIME_HANDLE hCard1;
	DWORD ret, tmp = 0, tmp_write;

	/* Call the function to locate our BenOne card on the USB bus */
	if( (hLocate = DIME_LocateCard(dlUSB,mbtTHEBENONE,NULL,dldrDEFAULT,dlDEFAULT)) == NULL)
	{
		DIME_GetError(NULL,&ErrorNum,ErrorString);
		printf("Error %d: %s\n", ErrorNum, ErrorString);
		getchar();
		return 1;
	}

	/* Determine how many Nallatech cards have been found. */
	NumOfCards = DIME_LocateStatus(hLocate,0,dlNUMCARDS);
	printf("%d Nallatech card(s) found.\n", NumOfCards);

	printf("Opening card via driver: %s.\n",
		(char*)DIME_LocateStatusPtr(hLocate, 1, dlDESCRIPTION));

	hCard1 = DIME_OpenCard(hLocate,1,dccOPEN_NO_OSCILLATOR_SETUP);
	if (hCard1 == NULL)
	{
		printf("Card Number One failed to open.\n");
		DIME_CloseLocate(hLocate);
		getchar();
		return 1;
	}

	printf("Card successfully opened.\n");

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
	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, 10000);
	printf("B) DIME_AddressWriteSingle, ret=%d\n", ret);

	ret = DIME_DataReadSingle(hCard1, &tmp, NULL, 10000);
	printf("B) DIME_DataReadSingle, ret=%d\n", ret);
	printf("Read: %#x\n", tmp);

	//DIME_DataRead(hCard1, ReadData, 128, NULL, NULL, 10000);


	DIME_CloseCard(hCard1);
	DIME_CloseLocate(hLocate);

	printf("Done\n");
	getchar();
	return 0;
}
