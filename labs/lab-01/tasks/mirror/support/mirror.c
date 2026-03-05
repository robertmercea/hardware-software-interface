// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "mirror.h"

void mirror(char *s)
{
	int i;
	int n = strlen(s);
	char aux;

	for (i = 0; i < n / 2; i++) {
		aux = s[i];
		s[i] = s[n - i - 1];
		s[n - i - 1] = aux;
	}
}
