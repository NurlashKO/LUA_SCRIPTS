#ifndef __EBDAT_GPS_H__
#define __EBDAT_GPS_H__
/*==========================================================================   
  *                                                                                                                  
  * Copyright (c) 2012 SIMCOM Corporation.  All Rights Reserved.                     
  *                                                                                                               
  *----------------------------------------------------------------------------------------
  *
  * PROJECT             SIM5320
  *
  * LANGUAGE          ANSI C
  *
  * SUBSYSTEM        EMBEDDED AT
  *
  * DESCRIPTION     
  *          embed at APIs for GPS                 
  *
  *---------------------------------------------------------------------------------------
  *
  * HOSTORY
  * 
  *       when            who            what, where, why     
  * 
  * 2012/12/06       sj               Modify bug MKBUG00002195 to add buffer size parameters for GPS functions
  * 2012/07/11       zh               initial version
  *
  *========================================================================*/

/*-------------------------------------------------------------------------------------*/
/*        INCLUDE FILE                                                                                              */
/*-------------------------------------------------------------------------------------*/
#include"ebdat_types.h"

/*-------------------------------------------------------------------------------------*/
/*        MACRO                                                                                                      */
/*-------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------*/
/*        TYPES                                                                                                        */
/*-------------------------------------------------------------------------------------*/

typedef enum
{
    EBDAT_GPS_START_MODE_DEFAULT,
    EBDAT_GPS_START_MODE_HOT,
    EBDAT_GPS_START_MODE_COLD,   
    EBDAT_GPS_START_MODE_ERR
} ebdat_gps_start_mode_type_enum;

typedef enum {
  EBDAT_SESSION_OPERATION_MIN = 0,
  EBDAT_SESSION_OPERATION_STANDALONE_ONLY,
  EBDAT_SESSION_OPERATION_MSBASED,  //reserved
  EBDAT_SESSION_OPERATION_MSASSISTED,  //reserved
  EBDAT_SESSION_OPERATION_MAX = 0x10000000
} ebdat_session_operation_e_type;

typedef enum {
  EBDAT_NMEA_MIN = 0,
  EBDAT_NMEA_GGA,
  EBDAT_NMEA_RMC,
  EBDAT_NMEA_GSV,
  EBDAT_NMEA_GSA,
  EBDAT_NMEA_VTG,
  EBDAT_NMEA_MAX = 0x100
} ebdat_nmea_e_type;

/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_start
  * 
  * DESCRIPTION: Start GPS by mode hot/cold
  * 
  * PARAMETER: [in] mode - start mode
  *			
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gps_start (ebdat_gps_start_mode_type_enum mode);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_stop
  * 
  * DESCRIPTION: Stop GPS
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gps_stop (void);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_get_fix_info
  * 
  * DESCRIPTION: Get the GPS information. 
  *                        If no fix, retrun ",,,,,,,,"
  *                        If fix, return "lat,lon,date,time,alt,speed,course"
  * 
  * PARAMETER: [in] gps_info - Buffer to save the fixed information
  *  
  * RETURN VALUE: 
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_gps_get_fix_info (char * gps_info, uint32 buf_size);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_get_nmea_info
  * 
  * DESCRIPTION: Get the GPS NMEA sentence. 
  * 
  * PARAMETER: [in] nmea_type - which sentence will get
  *			 [in] nmea - Buffer to save the NMEA sentence
  *  
  * RETURN VALUE:  NMEA sentence length
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
int ebdat_gps_get_nmea_info (ebdat_nmea_e_type nmea_type, char * nmea, uint32 buf_size);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_set_mode
  * 
  * DESCRIPTION: Set GPS start mode AGPS/GPS
  * 
  * PARAMETER: [in] op - mode select
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gps_set_mode (ebdat_session_operation_e_type op);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_get_mode
  * 
  * DESCRIPTION: Get the GPS mode
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE:  Return GPS mode.
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
ebdat_session_operation_e_type ebdat_gps_get_mode (void);


/***************************************************************************************
  *
  * FUNCTION:   ebdat_gps_delete_info
  * 
  * DESCRIPTION: Delete GPS position and satellitic information
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES: It must execute after GPS engine stoped
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gps_delete_info (void);

#endif /*__EBDAT_GPS_H__*/

