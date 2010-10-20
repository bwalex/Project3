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

static DWORD _if_readn(DIME_HANDLE hCard1, DWORD count, DWORD *pdata, DWORD timeout)
{
	DWORD tmp_write;
	DWORD ret;

	tmp_write = count;
	tmp_write |= 0xF0000000;

	assert(((unsigned long)&tmp_write) % 4 == 0);
	assert(((unsigned long)pdata) % 4 == 0);

	ret = DIME_AddressWriteSingle(hCard1, &tmp_write, NULL, timeout);
	//printf("B) DIME_AddressWriteSingle, ret=%d\n", ret);

	printf("Reading %d words\n", count);
	ret = DIME_DataRead(hCard1, pdata, count, NULL, NULL, timeout);
	//printf("B) DIME_DataReadSingle, ret=%d\n", ret);

	return ret;
}

static DWORD if_readn(DIME_HANDLE hCard1, DWORD count, DWORD *pdata, DWORD timeout)
{
	int i, error;

	assert((count % 16) == 0);

	for (i = 0; i < count/16; i++) {
		printf("Read %d/128, %#x\n", i, &pdata[16*i]);
		error = _if_readn(hCard1, 16, &pdata[16*i], timeout);
		if (error)
			return error;
	}

	return 0;
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
	DWORD tmp_array[5192];
	DWORD *ptr;
	FILE *fp, *fp2;
	int i;
	double mV, t;

	fp = fopen("adc_data.csv", "w");
	if (fp == NULL) {
		printf("Failed to open adc_data.csv\n");
		exit(1);
	}


	fp2 = fopen("adc_time.csv", "w");
	if (fp2 == NULL) {
		printf("Failed to open adc_time.csv\n");
		exit(1);
	}

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

	enable_periph(hCard1);

	printf("Continuing on your mark\n");
	getchar();

	disable_periph(hCard1);

#if 0
	t = 0;
	for (i =0; i < 65536; i++) {
		error = if_readn(hCard1, 1, &tmp, 10000);
		/*
		 * We need to convert the 14-bit 2's complement
		 * to 32-bit 2's complement.
		 *
		 * To do that we just pad 14-bit 2's complement
		 * numbers with 1's to the left if they are
		 * negative.
		 */
		//printf("Read: %#x (error = %d)\n", tmp, error);
		if (tmp & (1 << 13)) {
			tmp |= 0xFFFFC000;
			    /* 0b11111111111111111100000000000000 */
		}
		//mV = (double)2200*(double)tmp/16384;
		fprintf(fp, "%d,", tmp);

		t += 9.52381;
		fprintf(fp2, "%lf,", t);
	}
#endif

#if 1
	error = if_readn(hCard1, 4096, &tmp_array[0], 10000);
	for (i = 0; i < 4096; i++) {
		tmp = tmp_array[i];
		if (tmp & (1 << 13)) {
			tmp |= 0xFFFFC000;
			    /* 0b11111111111111111100000000000000 */
		}
		//printf("Read: %#x (error = %d)\n", tmp, error);
		//mV = (double)2200*(double)tmp/16384;
		fprintf(fp, "%d,", tmp);
	}
#endif

	close_card(hCard1, hLocate);
	fclose(fp);
	fclose(fp2);

	printf("Done\n");
	getchar();
	return 0;
}
