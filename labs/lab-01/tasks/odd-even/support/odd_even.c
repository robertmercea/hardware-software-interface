// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>

#include "odd_even.h"
#define BYTES_IN_BIT 8

/*
 * print even in binary and odd in hex
 * and use bitwise operations because iocla
 * */


/*
 * my idea is:
 * go with a mask from left to right and print each digit
 * like: go from 1000.0000 to 0000.0001 and check for the presence
 * of each bit
 * */
void print_binary(int number, int nr_bits)
{
	size_t i;
	const int SHIFT_AMOUNT = nr_bits * BYTES_IN_BIT;
	int magic = 1 << SHIFT_AMOUNT;

	for (i = 0; i < SHIFT_AMOUNT; i++) {
		printf("%d", (magic & number));
		magic = 1 << (SHIFT_AMOUNT - i);
	}

	printf("\n");
}

void check_parity(int *numbers, int n)
{
	size_t i;

	for (i = 0; i < n; i++) {
		if ( (*(numbers + i) & 1) == 0) {
			print_binary(*(numbers + i), sizeof(int));
		} else {
			printf("%08X\n", *(numbers + i));
		}
	}
}
