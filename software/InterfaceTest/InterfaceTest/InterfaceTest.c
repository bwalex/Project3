// InterfaceTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "assert.h"

static DWORD if_write(DIME_HANDLE hCard1, DWORD *pdata, DWORD timeout)
{
	DWORD tmp_write;
	DWORD ret;

	tmp_write = 0x0FFFFFF0;
	assert(((unsigned long)&tmp_write) % 4 == 0);
	assert(((unsigned long)pdata) % 4 == 0);

	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, timeout);
	printf("A) DIME_AddressWriteSingle, ret=%d\n", ret);

	ret = DIME_DataWriteSingle(hCard1, pdata, NULL, timeout);
	printf("A) DIME_DataWriteSingle, ret=%d\n", ret);

	return ret;
}

static DWORD if_read(DIME_HANDLE hCard1, DWORD *pdata, DWORD timeout)
{
	DWORD tmp_write;
	DWORD ret;

	tmp_write = 0xFFFFFFFF;
	assert(((unsigned long)&tmp_write) % 4 == 0);
	assert(((unsigned long)pdata) % 4 == 0);

	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, timeout);
	//printf("B) DIME_AddressWriteSingle, ret=%d\n", ret);

	ret = DIME_DataReadSingle(hCard1, pdata, NULL, timeout);
	//printf("B) DIME_DataReadSingle, ret=%d\n", ret);

	return ret;
}

static void enable_periph(DIME_HANDLE hCard1)
{
	DWORD data;

	data = 0xFFFFFFFF;
	if_write(hCard1, &data, 10000);
}

static void disable_periph(DIME_HANDLE hCard1)
{
	DWORD data;

	data = 0x00000000;
	if_write(hCard1, &data, 10000);
}

static DWORD open_card(DIME_HANDLE *phCard, LOCATE_HANDLE *phLocate)
{
	LOCATE_HANDLE hLocate = NULL;
	DWORD ErrorNum,NumOfCards;
	char ErrorString[1000];
	DIME_HANDLE hCard1;

	/* Call the function to locate our BenOne card on the USB bus */
	if( (hLocate = DIME_LocateCard(dlUSB,mbtTHEBENONE,NULL,dldrDEFAULT,dlDEFAULT)) == NULL)
	{
		DIME_GetError(NULL,&ErrorNum,ErrorString);
		printf("Error %d: %s\n", ErrorNum, ErrorString);
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
		printf("Card Number one failed to open.\n");
		DIME_CloseLocate(hLocate);
		return 1;
	}

	*phCard = hCard1;
	*phLocate = hLocate;
	return 0;
}

static void close_card(DIME_HANDLE hCard, LOCATE_HANDLE hLocate)
{
	DIME_CloseCard(hCard);
	DIME_CloseLocate(hLocate);
}

int _tmain(int argc, _TCHAR* argv[])
{
	LOCATE_HANDLE hLocate;
	DIME_HANDLE hCard1;
	DWORD error, tmp;
	int i;

	error = open_card(&hCard1, &hLocate);

	if (error == 0) {
		printf("Card successfully opened.\n");
	} else {
		printf("Woops, something went wrong opening the card\n");
		exit(1);
	}
		/* NOTREACHED */

	printf("Writing something whenever you press a button\n");
	getchar();

	disable_periph(hCard1);

	printf("Continuing on your mark\n");
	getchar();

	for (i = 0; i < 1096; i++) {
		error = if_read(hCard1, &tmp, 10000);
		printf("Read: %#x (error = %d)\n", tmp, error);
	}

	close_card(hCard1, hLocate);

	printf("Done\n");
	getchar();
	return 0;
}
