/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
06/15/12  sj     Create Module
*/
#ifndef __EBDAT_EFS_H__
#define __EBDAT_EFS_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

typedef void (*ebdat_efs_list_cb)(char* item_name, void* user_data);

/*file/dir operation*/
int ebdat_efs_creat(const char *path, uint16 mode);
int ebdat_efs_open(const char* path, int oflag);
int ebdat_efs_close(int filedes);
int ebdat_efs_read(int filedes, void *buf, fs_size_t nbyte);
int ebdat_efs_write (int filedes, const void *buf, fs_size_t nbytes);
int ebdat_efs_ftruncate(int fd, fs_off_t length);
int ebdat_efs_lseek (int filedes, fs_off_t offset, int whence);
int ebdat_efs_stat(const char *path, struct fs_stat *buf);
int ebdat_efs_fstat(int fd, struct fs_stat *buf);
int ebdat_efs_lstat(const char *path, struct fs_stat *buf);
int ebdat_efs_tell(int fd);
int ebdat_efs_get_opened_filesize(int fd);
boolean ebdat_efs_file_exist (const char* filename);
boolean ebdat_efs_dir_exist (const char* filename);
boolean ebdat_efs_delete_file (const char* filename);
boolean ebdat_efs_rmdir (const char* filename);
boolean ebdat_efs_mkdir (const char* dirname);
int ebdat_efs_get_filesize (const char* filename);
boolean ebdat_efs_truncate_file(const char *path, int length);
int ebdat_efs_lsdir (const char *dirname, ebdat_efs_list_cb list_cb, void* user_data) ;//list all directories under the dirname folder
int ebdat_efs_lsfile (const char *dirname, ebdat_efs_list_cb list_cb, void* user_data) ;//list all files under the dirname folder

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_EFS_H__ */