#ifndef __EBDAT_GPIO_H__
#define __EBDAT_GPIO_H__
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
  *          embed at APIs for GPIO                 
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
typedef enum
{
    EBDAT_GPIO_LOW_VALUE     = 0,
    EBDAT_GPIO_HIGH_VALUE    = 1,
} ebdat_gpio_value_t;

typedef enum
{
    EBDAT_GPIO_INPUT  = 0,
    EBDAT_GPIO_OUTPUT = 1
}ebdat_gpio_direction_t;

typedef enum
{
  EBDAT_ACTIVE_LOW,
  EBDAT_ACTIVE_HIGH
} ebdat_gpio_int_pol_t;


typedef enum
{
  EBDAT_DETECT_LEVEL,
  EBDAT_DETECT_EDGE
} ebdat_gpio_int_detect_t;

/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DECLARATION                                                                           */
/*-------------------------------------------------------------------------------------*/
/***************************************************************************************
  *
  * FUNCTION:   ebdat_gpio_config
  * 
  * DESCRIPTION: config the direction of the GPIO
  * 
  * PARAMETER: [in] gpio - which gpio to config
  *			       gpio_io - direction
  *  
  * RETURN VALUE: read result
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gpio_config(uint8 gpio, ebdat_gpio_direction_t gpio_io);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_gpio_out
  * 
  * DESCRIPTION: set the value of the GPIO
  * 
  * PARAMETER: [in] gpio - which gpio to set
  *			       gpio_val - value
  *  
  * RETURN VALUE: TRUE - success
  *			      FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gpio_out(uint8 gpio, ebdat_gpio_value_t gpio_val);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_gpio_get
  * 
  * DESCRIPTION: get the value of the GPIO
  * 
  * PARAMETER: [in] gpio - which gpio to get
  *  
  * RETURN VALUE: value of the GPIO
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
ebdat_gpio_value_t ebdat_gpio_get(uint8 gpio);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_gpio_func_set
  * 
  * DESCRIPTION: set the gpio to the specific function
  * 
  * PARAMETER: [in] gpio_func - gpio function
  *			 [in] bEnabled - enable(true)/disable(false)
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gpio_func_set(uint8 gpio_func, boolean bEnabled);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_gpio_isr_set
  * 
  * DESCRIPTION: set one gpio as an ISR
  * 
  * PARAMETER: [in] gpio_no - which gpio to set
  *			 [in] detect - detect mode
  *                     [in] polarity - detect polarity
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gpio_isr_set(uint8 gpio_no, ebdat_gpio_int_detect_t detect, ebdat_gpio_int_pol_t polarity);

/***************************************************************************************
  *
  * FUNCTION:   bedat_gpio_debounce_set
  * 
  * DESCRIPTION: set debounce time for one ISR GPIO
  * 
  * PARAMETER: [in] gpio_no - which gpio to set
  *			 [in] debounce_ms - debounce time in millisecond
  *  
  * RETURN VALUE: TRUE - success
  *		              FALSE - failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_gpio_debounce_set(uint8 gpio_no, uint32 debounce_ms);

#endif /*__EBDAT_GPIO_H__*/

