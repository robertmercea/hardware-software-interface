// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "delete_first.h"

char *delete_first(char *s, char *pattern)
{
	char *first_appearance = strstr(s, pattern);

	if (!first_appearance) {
		return strdup(s);
	}

	char *res = strdup(s);
	int off = first_appearance - s;
	strcpy(res + off, first_appearance + strlen(pattern));
	
	return res;
}
