// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "iterate.h"
#include "array.h"

void print_chars(void)
{
	/**
	 * TODO: Implement function
	 */
	int i;
	char *p = (char *)v;

	for (i = 0; i < sizeof(v) / sizeof(char); i++) {
		printf("%p -> 0x%hhx\n", p, *p);
		p++;
	}

	printf("-------------------------------\n");
}

void print_shorts(void)
{
	/**
	 * TODO: Implement function
	 */
	int i;
	short *p = (short *)v;

	for (i = 0; i < sizeof(v) / sizeof(short); i++) {
		printf("%p -> 0x%hx\n", p, *p);
		p++;
	}

	printf("-------------------------------\n");
}

void print_ints(void)
{
	/**
	 * TODO: Implement function
	 */
	int i;
	int *p = (int *)v;

	for (i = 0; i < sizeof(v) / sizeof(int); i++) {
		printf("%p -> 0x%x\n", p, *p);
		p++;
	}

	printf("-------------------------------\n");
}

void print_long_longs(void)
{
	/**
	 * TODO: Implement function
	 */
	int i;
	long *p = (long *)v;

	for (i = 0; i < sizeof(v) / sizeof(long); i++) {
		printf("%p -> 0x%lx\n", p, *p);
		p++;
	}

	printf("-------------------------------\n");
}
