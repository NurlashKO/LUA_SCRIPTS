#ifndef __EBDAT_HD_H__
#define __EBDAT_HD_H__
/*==========================================================================   
  *                                                                                                                  
  * Copyright (c) 2012 SIMCOM Corporation.  All Rights Reserved.                     
  *                                                                                                               
  *----------------------------------------------------------------------------------------
  *
  * PROJECT             SIM5215
  *
  * LANGUAGE          ANSI C
  *
  * SUBSYSTEM        EMBEDDED AT
  *
  * DESCRIPTION     
  *          embed at APIs for hardware device                 
  *
  *---------------------------------------------------------------------------------------
  *
  * HOSTORY
  * 
  *       when            who            what, where, why     
  * 
  * 2012/05/30     aaron        initial version
  *
  *========================================================================*/

/*-------------------------------------------------------------------------------------*/
/*        INCLUDE FILE                                                                                              */
/*-------------------------------------------------------------------------------------*/
#include "ebdat_types.h"

/*-------------------------------------------------------------------------------------*/
/*        TYPES                                                                                                         */
/*-------------------------------------------------------------------------------------*/
typedef enum
{
	EBDAT_ADC_MV_TYPE,
	EBDAT_ADC_TEMP_TYPE,
	EBDAT_ADC_RAW_TYPE
}ebdat_adc_t;

/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DECLARATION                                                                            */
/*-------------------------------------------------------------------------------------*/
/***************************************************************************************
  *
  * FUNCTION:   ebdat_adc_read
  * 
  * DESCRIPTION:read adc channel
  * 
  * PARAMETER: [in] adc_type - adc type to read
  *  
  * RETURN VALUE: read result
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
int ebdat_adc_read(ebdat_adc_t adc_type);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_vaux_set
  * 
  * DESCRIPTION: set the voltage value for the LDO
  * 
  * PARAMETER: [in] level - voltage from 1500 to 3050
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_vaux_set(uint16 level);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_vaux_get
  * 
  * DESCRIPTION: get the voltage value for the LDO
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: voltage of the current LDO
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
uint16 ebdat_vaux_get(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_vaux_switch
  * 
  * DESCRIPTION: enable/disable the LDO
  * 
  * PARAMETER: [in] bEnabled - TRUE(enabled) / FALSE(disabled)
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_vaux_switch(boolean bEnabled);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_vaux_get_state
  * 
  * DESCRIPTION: get current state of the LDO
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: TRUE - enabled
  *                          FALSE -disabled
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_vaux_get_state(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_i2c_read
  * 
  * DESCRIPTION: read the i2c slave device
  * 
  * PARAMETER: [in] slave_addr - slave device
  *                     [in] reg - register to read from
  *                     [in] read_buf - buffer to store data
  *                     [in] read_len -bytes count to read 
  *  
  * RETURN VALUE: TRUE - enabled
  *                          FALSE -disabled
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_i2c_read(byte slave_addr, byte reg, byte *read_buf, int read_len);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_i2c_combined_write_read
  * 
  * DESCRIPTION: read the i2c slave device
  * 
  * PARAMETER: [in] slave_addr - slave device
  *                     [in] reg - register to read from
  *                     [in] read_buf - buffer to store data
  *                     [in] read_len -bytes count to read 
  *  
  * RETURN VALUE: TRUE - enabled
  *                          FALSE -disabled
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_i2c_combined_write_read(byte slave_addr, byte reg, byte *read_buf, int read_len);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_i2c_write
  * 
  * DESCRIPTION: write the i2c slave device
  * 
  * PARAMETER: [in] slave_addr - slave device
  *                     [in] reg - register to write to
  *                     [in] write_buf - buffer to store data
  *                     [in] write_len -bytes count to write 
  *  
  * RETURN VALUE: TRUE - enabled
  *                          FALSE -disabled
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_i2c_write(byte slave_addr, byte reg, byte *write_buf, int write_len);

#endif /*__EBDAT_HD_H__*/

