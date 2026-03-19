// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "vector_max.h"

int vector_max(int *v, int len)
{
	int max = v[0];
	unsigned int i = 0;

get_max:
	if (v[i] > max) {
		max = v[i];
	}

	i++;

	if (i < len) {
		goto get_max;
	}

	return max;
}
