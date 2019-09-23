// thanks to "How do I create a shortcut whose target is specified by a relative path?"
// https://blogs.msdn.microsoft.com/oldnewthing/20171019-00/?p=97247

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

// [MS-SHLLINK]: size of ShellLinkHeader + CLSID
static const uint8_t MAGIC[] = {0x4c, 0x00, 0x00, 0x00, 0x01, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00,
	0x00, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46};

// relevant enums from shlobj.h
#define SLDF_FORCE_NO_LINKINFO  0x00000100
#define SLDF_FORCE_NO_LINKTRACK 0x00040000

static int retval = EXIT_SUCCESS;

#define BAIL retval = EXIT_FAILURE; goto end
static void process_link_file(const char *fn) {
	uint8_t magic_check[sizeof(MAGIC)];
	uint32_t link_flags;
	fpos_t off;
	FILE *f = fopen(fn, "r+b");
	if (f == NULL) {
		fprintf(stderr, "%s: can't open\n", fn);
		BAIL;
	}
	if (fread(magic_check, sizeof(MAGIC), 1, f) != 1) {
		if (feof(f)) {
			fprintf(stderr, "%s: not a shortcut file\n", fn);
		} else {
			fprintf(stderr, "%s: error reading\n", fn);
		}
		BAIL;
	}
	if (memcmp(magic_check, MAGIC, sizeof(MAGIC)) != 0) {
		fprintf(stderr, "%s: not a shortcut file\n", fn);
		BAIL;
	}
	if (fgetpos(f, &off) == -1) {
		fprintf(stderr, "%s: error reading\n", fn);
		BAIL;
	}
	if (fread(&link_flags, sizeof(uint32_t), 1, f) != 1) {
		if (feof(f)) {
			fprintf(stderr, "%s: not a shortcut file\n", fn);
			BAIL;
		} else {
			fprintf(stderr, "%s: error reading\n", fn);
			BAIL;
		}
	}
	// TODO: only does right thing on little-endian systems
	link_flags |= SLDF_FORCE_NO_LINKINFO | SLDF_FORCE_NO_LINKTRACK;
	if (fsetpos(f, &off) == -1) {
		fprintf(stderr, "%s: error writing\n", fn);
		BAIL;
	}
	if (fwrite(&link_flags, sizeof(uint32_t), 1, f) != 1) {
		fprintf(stderr, "%s: error writing\n", fn);
		BAIL;
	}
end:
	if (f) {
		fclose(f);
	}
}

int main(int argc, char **argv) {
	for (int i = 1; i < argc; ++i) {
		process_link_file(argv[i]);
	}
	return retval;
}