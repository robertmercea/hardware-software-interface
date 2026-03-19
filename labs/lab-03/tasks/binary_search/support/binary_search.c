// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "binary_search.h"

int binary_search(int *v, int len, int dest)
{
	int start = 0;
	int end = len - 1;
	int middle;

find:
	middle = start + (end - start) / 2;

	if (v[middle] == dest) {
		goto finish;
	}

	if (v[middle] > dest) {
		end = middle - 1;
	}

	if (v[middle] < dest){
		start = middle + 1;
	}

	if (start <= end) {
		goto find;
	}

	return -1;

finish:
	return middle;
}
