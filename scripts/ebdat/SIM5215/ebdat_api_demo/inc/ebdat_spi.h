#ifndef __EBDAT_SPI_H__
#define __EBDAT_SPI_H__
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
  *          embed at APIs for SPI                 
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

#ifdef FEATURE_SUPPORT_SPI

/*-------------------------------------------------------------------------------------*/
/*        TYPES                                                                                                        */
/*-------------------------------------------------------------------------------------*/
/**
 * The clock polarity parameter type
 */
typedef enum
{
   SPI_CLK_IDLE_LOW, /**< the SPI clock signal is low when the clock is idle */
   SPI_CLK_IDLE_HIGH /**< the SPI clock signal is high when the clock is idle */
} ebdat_spi_clk_pol_t;

/**
 * The clock phase parameter type
 */
typedef enum
{
   SPI_INPUT_FIRST_MODE, /**< the SPI data input signal is sampled on the leading clock edge */ 
   SPI_OUTPUT_FIRST_MODE /**< the SPI data input signal is sampled on the trailing clock edge */
} ebdat_spi_trans_mode_t;

/**
 * The clock mode parameter type
 */
typedef enum
{
   SPI_CLK_NORMAL, /**< the SPI clock runs only during a transfer unit */
   SPI_CLK_ALWAYS_ON /**< the SPI clock runs continously from the start of the transfer */
} ebdat_spi_clk_mode_t;

/**
 * The chip select polarity parameter type
 */
typedef enum
{
   SPI_CS_ACTIVE_LOW, /**< the SPI chip select is active low */
   SPI_CS_ACTIVE_HIGH /**< the SPI chip select is active high */
} ebdat_spi_cs_pol_t;

/**
 * The chip select mode parameter type
 */
typedef enum
{
   SPI_CS_DEASSERT, /**< the SPI chip select is de-asserted between transfer units */
   SPI_CS_KEEP_ASSERTED /**< the SPI chip select is kept asserted between transfer units */
} ebdat_spi_cs_mode_t;

/**
 * This parameter type specifies whether the input data should
 * be packed into the user input buffer as it is received.
 * 
 * When packing is disabled, each n-bit transfer unit is placed
 * into its own 32-bit word. n is the number of bits per
 * transfer unit as specified in the transfer parameter
 * nNumBits.
 * 
 * When packing is enabled, each n-bit transfer unit is packed
 * into the 32-bit input buffer in 8-bit or 16-bit units.
 * 
 *  n <= 8: 8-bit packing.
 *  8 < n <= 16: 16-bit packing.
 *  n > 16: no packing
 */
typedef enum
{
   SPI_INPUT_PACKING_DISABLED, /* disable input packing */
   SPI_INPUT_PACKING_ENABLED /* enable input packing */
}ebdat_spi_input_packing_t;

/**
 *  This parameter type specifies whether the output data should
 *  be unpacked from the user output buffer as it is
 *  transmitted.
 * 
 *  When unpacking is disabled, each 32-bit word in the user
 *  input buffer contains the data for a single n-bit transfer
 *  unit. n is the number of bits per transfer unit as specified
 *  in the transfer parameter nNumBits.
 * 
 *  When unpacking is enable, the user places the n-bit transfer
 *  unit data in packed quantities of 8-bit or 16-bit units.
 * 
 *  n <= 8: 8-bit packing.
 *  8 < n <= 16: 16-bit packing.
 *  n > 16: no packing
 */
typedef enum
{
   SPI_OUTPUT_UNPACKING_DISABLED, /*< disable output unpacking */
   SPI_OUTPUT_UNPACKING_ENABLED /**< enable output unpacking */
} ebdat_spi_output_unpacking_t;

/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DECLARATION                                                                             */
/*-------------------------------------------------------------------------------------*/
/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_init
  * 
  * DESCRIPTION: initialize the spi sub system
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
void ebdat_spi_init(void);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_set_clk_info
  * 
  * DESCRIPTION: set spi clock information
  * 
  * PARAMETER:  [in] clk_pol - clock polarity
  *			  [in] clk_md - clock mode
  *                      [in] trans_md -  clock phase parameter
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_set_clk_info(ebdat_spi_clk_pol_t clk_pol, ebdat_spi_clk_mode_t clk_md, ebdat_spi_trans_mode_t trans_md);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_set_cs
  * 
  * DESCRIPTION: set spi Chip Selector  information
  * 
  * PARAMETER:  [in] cs_md - CS mode
  *			  [in] cs_pol - CS polarity
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_set_cs(ebdat_spi_cs_mode_t cs_md, ebdat_spi_cs_pol_t cs_pol);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_set_frequency
  * 
  * DESCRIPTION: set spi running clock frequency
  * 
  * PARAMETER:  [in] nMinFreq -  in master mode, specify the minimum SPI clock frequency supported by the slave device
  *			  [in] nMaxFreq - in mster mode, specify the maximum SPI clock frequency supported by the slave device
  *                      [in] nDeassertionTime - in master mode, configures the minimum time to wait between transfer units in 
  *				nanoseconds
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_set_frequency(uint32 nMinFreq, uint32 nMaxFreq, uint32 nDeassertionTime);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_set_param
  * 
  * DESCRIPTION: set spi's transfer information
  * 
  * PARAMETER:  [in] nNumBits -  configures the number of bits to use per transfer unit
  *			  [in] input_packing - specifies whether data should be packed into the user input buffer
  *                      [in] output_packing -specifies whether data should be unpacked from the user output buffer 
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_set_param( uint8 nNumBits, ebdat_spi_input_packing_t input_packing, ebdat_spi_output_unpacking_t output_packing);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_write_data
  * 
  * DESCRIPTION: write data to spi slave device
  * 
  * PARAMETER:  [in] data_byte -data to be sent to device
  *			  [in] len - length of data to be sent to device
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_write_data(uint8* data_byte, uint32 len);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_write_uint32_data
  * 
  * DESCRIPTION: write data to spi slave device
  * 
  * PARAMETER:  [in] data_byte -data to be sent to device
  *			  [in] len - length of data to be sent to device
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_write_uint32_data(uint32* data_byte, uint32 len);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_write_reg
  * 
  * DESCRIPTION: write register value to spi slave device
  * 
  * PARAMETER:  [in] reg -register be written to 
  *			  [in] reg_val - value be written to the register
  *			  [in] len - length of value
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_write_reg(uint32 reg, uint32 reg_val, uint32 len);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_spi_read_reg
  * 
  * DESCRIPTION: read register value from spi slave device
  * 
  * PARAMETER:  [in] reg -register be read from 
  *			  [in] read_buf - buffer to store the data
  *			  [in] len - length of the read buffer
  *  
  * RETURN VALUE:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
void ebdat_spi_read_reg(uint32 reg, uint8* read_buf, uint32 len);

#endif 

#endif /*__EBDAT_SPI_H__*/

