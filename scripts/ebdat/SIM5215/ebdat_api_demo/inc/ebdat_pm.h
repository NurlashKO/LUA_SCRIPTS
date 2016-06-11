#ifndef __EBDAT_PM_H__
#define __EBDAT_PM_H__
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
  *          embed at APIs for power manager                 
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
#include"ebdat_types.h"

/*-------------------------------------------------------------------------------------*/
/*        MACRO                                                                                                      */
/*-------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------*/
/*        TYPES                                                                                                        */
/*-------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DECLARATION                                                                            */
/*-------------------------------------------------------------------------------------*/
/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_auto_pwr_off_set
  * 
  * DESCRIPTION: set the voltage to auto power off when under this voltage 
  * 
  * PARAMETER: [in] low_voltage -voltage to power off from 2800 - 4300
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_pm_auto_pwr_off_set(uint32 low_voltage);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_auto_pwr_off_get
  * 
  * DESCRIPTION: get the current voltage to auto power off when under this voltage
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: voltage value, 0 if not working or unsupported
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
uint32 ebdat_pm_auto_pwr_off_get(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_enable_low_voltage_alarm
  * 
  * DESCRIPTION: set and enable the low power alarm function
  * 
  * PARAMETER: [in] low_voltage - voltage when under will send alarm URC to host
  *  
  * RETURN VALUE: 
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_pm_enable_low_voltage_alarm(uint32 low_voltage);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_disable_low_voltage_alarm
  * 
  * DESCRIPTION: disable the low power alarm function
  * 
  * PARAMETER: 
  *  
  * RETURN VALUE: 
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_pm_disable_low_voltage_alarm(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_enable_auto_pwr_on
  * 
  * DESCRIPTION: config and enable the auto startup function
  * 
  * PARAMETER:  [in] hour - which hour to power on
  *                      [in] minute - which minute to power on
  *                      [in] bRepeated - repeat or not  
  *
  * RETURN VALUE:  TRUE - success
  *                           FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_pm_enable_auto_pwr_on(uint8 hour, uint8 minute, boolean bRepeated);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_disable_auto_pwr_on
  * 
  * DESCRIPTION: disable the auto startup function
  * 
  * PARAMETER:
  *
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_pm_disable_auto_pwr_on(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_enable_auto_pwr_off
  * 
  * DESCRIPTION: config and enable the auto power-down function
  * 
  * PARAMETER:  [in] hour - which hour to power-down
  *                      [in] minute - which minute to power-down
  *                      [in] bRepeated - repeat or not  
  *
  * RETURN VALUE:  TRUE - success
  *                           FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_pm_enable_auto_pwr_off(uint8 hour, uint8 minute, boolean bRepeated);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_pm_disable_auto_pwr_off
  * 
  * DESCRIPTION: disable the auto startup function
  * 
  * PARAMETER:
  *
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_pm_disable_auto_pwr_off(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_power_off
  * 
  * DESCRIPTION: power down the module
  * 
  * PARAMETER: [in] bforce - flag to check if use hardware or software to power off
  *  
  * RETURN VALUE: TRUE - successfully
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_pm_power_off(boolean bforce);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_power_reset
  * 
  * DESCRIPTION: reset the module
  * 
  * PARAMETER:  [in] bforce - flag to check if use hardware or software to reset
  *  
  * RETURN VALUE: TRUE - successfully
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_pm_power_reset(boolean bforce);

#endif /*__EBDAT_PM_H__*/

