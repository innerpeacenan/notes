int hash_init(HashTable *ht)
{
    ht->size        = HASH_TABLE_INIT_SIZE;
    ht->elem_num    = 0;
    ht->buckets     = (Bucket **)calloc(ht->size, sizeof(Bucket *));

    if(ht->buckets == NULL) return FAILED;

    LOG_MSG("[init]\tsize: %i\n", ht->size);

    return SUCCESS;
}


// check if we need to resize the hashtable
    resize_hash_table_if_needed(ht);

Bucket *bucket = (Bucket *)malloc(sizeof(Bucket));

grep
-r recursively
-n, --line-number
              Prefix each line of output with the 1-based line number within its input file.

php 源码查看方式:
grep -rn "PHP_FUNCTION(socket_accept)" ./ext

zend_memnstr(char *haystack, char *needle, int needle_len, char *end)

static inline char *zend_memnstr(char *haystack, char *needle, int needle_len, char *end)
{
	char *p = haystack;
	char ne = needle[needle_len-1];

	if (needle_len == 1) {
		return (char *)memchr(p, *needle, (end-p));
	}

	if (needle_len > end-haystack) {
		return NULL;
	}
/**
 * char an integer can convert implicit
 * end is actually converted to integer
 */
	end -= needle_len;

	while (p <= end) {
		// @todo nxn although I can not understand it, I guess it is used for boundary condition restriction
		if ((p = (char *)memchr(p, *needle, (end-p+1))) && ne == p[needle_len-1]) {
			if (!memcmp(needle, p, needle_len-1)) {
				return p;
			}
		}

		if (p == NULL) {
			return NULL;
		}

		p++;
	}

	return NULL;
}


