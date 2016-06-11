/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
09/06/13  sj     Create Module
*/
#ifndef __EBDAT_MINIZIP_H__
#define __EBDAT_MINIZIP_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT


void* ebdat_minizip_openzip(char* zipfile_pathname, int append);
int ebdat_minizip_add_file(void* zf, char* filepathname,char* password, int opt_compress_level, boolean opt_exclude_path);
int ebdat_minizip_closezip(void* zf);


void* ebdat_miniunz_openzip(char* zipfile_pathname);
int ebdat_miniunz_closezip(void* uf);
int ebdat_miniunz_get_entry_count(void* uf);
int ebdat_miniunz_get_current_file_info(void* uf, char * szFileName, uint32 fileNameBufferSize, uint32* filesize_p, boolean* crypted_p);
int ebdat_miniunz_goto_next_file (void*  uf);
int ebdat_miniunz_extract_currentfile(void* uf,const char* password,char* dirname);

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_MINIZIP_H__ */
