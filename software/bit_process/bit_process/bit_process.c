// bit_process.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#define _isnum(x)	((x >= '0') && (x <= '9'))

#pragma pack(1)

struct ieee802_15_4_MAChdr {
	unsigned short frame_control;
	unsigned char seq_no;
	unsigned short dest_pan;
	unsigned short dest_addr;
	unsigned short src_addr;
};

struct ieee802_15_4_PHYhdr {
	unsigned char preamble[4];
	unsigned char sfd;
	unsigned char frame_length;
};

struct ieee802_15_4_PKTdemo {
	struct ieee802_15_4_PHYhdr phy_hdr;
	struct ieee802_15_4_MAChdr mac_hdr;
	unsigned short frame_payload;
	unsigned short fcs;
	unsigned short lets_not_sigsegv[4096];
};

unsigned short
crc_ccitt_update(unsigned short crc, unsigned char data)
{
#define lo8(x) (x & 0xFF)
#define hi8(x) ((x >> 8) & 0xFF)

	data ^= lo8 (crc);
	data ^= data << 4;
	return ((((unsigned short)data << 8) | hi8 (crc)) ^ (unsigned char)(data >> 4) ^ ((unsigned short)data << 3));

#undef lo8
#undef hi8
}

unsigned short
_crc(unsigned char *data, unsigned int size, unsigned short crc)
{
	while (size--)
		crc = crc_ccitt_update(crc, *data++);

	return crc;
}

void packet_introspect(struct ieee802_15_4_PKTdemo *pkt)
{
	int ok, crc;
	unsigned short flen;
	unsigned int correct_preamble = 0;
	unsigned char *crc_start;
	unsigned int crc_len;
	unsigned short swap;

	ok = !memcmp(&correct_preamble, pkt->phy_hdr.preamble, sizeof(correct_preamble));
	flen = pkt->phy_hdr.frame_length;

	printf("Preamble:\t %s\n", (ok) ? "correct" : "incorrect");
	printf("SFD:\t\t %.2x\n", pkt->phy_hdr.sfd);
	printf("Frame Length:\t %.2x (%#d)\n", pkt->phy_hdr.frame_length,
		pkt->phy_hdr.frame_length);
	printf("\n");
	printf("Frame Control:\t %.4x\n", pkt->mac_hdr.frame_control);
	printf("sequence no.:\t %.2x\n", pkt->mac_hdr.seq_no);
	printf("Dest. PAN:\t %.4x\n", pkt->mac_hdr.dest_pan);
	printf("Dest. Addr.:\t %.4x\n", pkt->mac_hdr.dest_addr);
	printf("Source Addr.:\t %.4x\n", pkt->mac_hdr.src_addr);
	printf("\n");
#if 0
	swap = ((pkt->frame_payload & 0xFF00) >> 8) | ((pkt->frame_payload & 0xFF) << 8);
	pkt->frame_payload = swap;
#endif
	printf("Payload:\t %.4x\n", pkt->frame_payload);

	/* 
	 * The FCS field is 16 bits in length and contains
	 * a 16 bit ITU-T CRC. The FCS is calculated over the
	 * MHR and MAC payload parts of the frame.
	 */
	crc_start = &pkt->mac_hdr;
	crc_len = offsetof(struct ieee802_15_4_PKTdemo, fcs) - offsetof(struct ieee802_15_4_PKTdemo, mac_hdr);
	printf("crc_len=%d\n", crc_len);
	crc = _crc(crc_start, crc_len, 0);

	printf("FCS:\t\t %.4x (%s)\n", pkt->fcs, (crc == pkt->fcs) ? "correct" : "incorrect");

}

enum {
	STATE_IDLE = 0,
	STATE_NEWSYM,
	STATE_LSB,
	STATE_MSB
};

int _tmain(int argc, _TCHAR* argv[])
{
	long sz;
	size_t bytes_read;
	FILE *fp;
	char *buf, *ptr;
	unsigned char pkt[8192];
	unsigned char symbols[2048];
	unsigned char octet;
	unsigned short word16;
	unsigned int word32;
	struct ieee802_15_4_PKTdemo pkt_demo;
	int i, bitcount, bytecount, symbolcount, state, nsyms;

	fp = fopen("D:\\Documents and Settings\\Administrator\\Desktop\\Project3\\software\\bit_process\\input.txt", "r");
	if (fp == NULL) {
		perror("fopen");
		return 1;
	}

	/* Get filesize */
	fseek(fp, 0L, SEEK_END);
	sz = ftell(fp);
	fseek(fp, 0L, SEEK_SET);

	buf = malloc(sz + 1);
	if (buf == NULL) {
		perror("malloc");
		return 1;
	}

	bytes_read = fread(buf, 1, sz, fp);
	if (bytes_read < 0) {
		perror("fread");
		return 1;
	}

	printf("sz = %ld, bytes_read = %lu\n", sz, bytes_read);

	symbolcount = bitcount = bytecount = 0;
	state = STATE_IDLE;

	ptr = buf;

	nsyms = 0;

	while (*ptr != '\0') {
		/*
		 * Process the CSV into the symbols[] array. We
		 * blindly assume that each number is only a single
		 * digit. As a matter of fact we understand any
		 * format that follows this syntax:
		 * <digit><non-digit><digit><non-digit>...
		 */
		if (_isnum(*ptr)) {
			symbols[nsyms++] = *ptr - '0';
		}
		*ptr++;
	}

	state = STATE_NEWSYM;

	printf("nsyms = %d\n", nsyms);
	for (i = 0; i < nsyms; i++) {
		/*
		 * According to the 802.15.4-2003 standard:
		 * The 4 LSBs (b0, b1, b2, b3) of each octet shall
		 * map into one data symbol, and the 4 MSBs
		 * b4, b5, b6, b7) of each octet shall map into the
		 * next data symbol.
		 */
		switch (state) {
		case STATE_NEWSYM:
			symbolcount = 0;
			octet = 0;
			octet |= (symbols[i] << 3);
			state = STATE_LSB;
			++symbolcount;
			break;

		case STATE_LSB:
			octet |= (symbols[i] << (3-symbolcount));
			if (++symbolcount == 4) {
				state = STATE_MSB;
				symbolcount = 0;
			}
			break;

		case STATE_MSB:
			octet |= (symbols[i] << (7-symbolcount));
			if (++symbolcount == 4) {
				state = STATE_NEWSYM;
				pkt[bytecount++] = octet;
			}
			break;
		default:
			printf("Uh-Oh!\n");
			break;
		}
	}

	printf("============================================================\n");

	for (i = 0; i < bytecount; i++) {
		printf("%.2x ", pkt[i]);
	}

	/* Flush */
	printf("\n\n");

	memset(&pkt_demo, 0, sizeof(pkt_demo));
	memcpy(&pkt_demo, pkt, bytecount);
	packet_introspect(&pkt_demo);


	free(buf);
	fclose(fp);

	return 0;
}

