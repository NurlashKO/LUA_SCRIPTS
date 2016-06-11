#ifndef __EBDAT_AUDIO_H__
#define __EBDAT_AUDIO_H__
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
  *          embed at APIs for audio                 
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
/*        TYPES                                                                                              */
/*-------------------------------------------------------------------------------------*/
typedef struct {
  uint16 tap0;     /* Filter Tap, h[0] and h[12], Q14                         */
  uint16 tap1;     /* Filter Tap, h[1] and h[11], Q14                         */
  uint16 tap2;     /* Filter Tap, h[2] and h[10], Q14                         */
  uint16 tap3;     /* Filter Tap, h[3] and h[9], Q14                          */
  uint16 tap4;     /* Filter Tap, h[4] and h[8], Q14                          */
  uint16 tap5;     /* Filter Tap, h[5] and h[7], Q14                          */
  uint16 tap6;     /* Filter Tap, h[6], Q14. The filter is disabled if this   */
                   /* tap is set to zero.                                     */
} ebdat_audio_pcm_ftr_t;

/* Select the Echo Cancellation mode
*/
typedef enum {
  EBDAT_EC_OFF = 0,
  EBDAT_EC_ESEC,
  EBDAT_EC_HEADSET,
  EBDAT_EC_AEC,
  EBDAT_EC_SPEAKER,
  EBDAT_EC_BT_HEADSET,
  EBDAT_EC_DYNAMIC1,
  EBDAT_EC_DYNAMIC2,
  EBDAT_EC_DYNAMIC3
} ebdat_audio_ec_t;

/* Select the Noise Suppressor mode
*/
typedef enum {
  EBDAT_NS_OFF = 0,
  EBDAT_NS_ON
} ebdat_audio_ns_t;

typedef enum
{
	EBDAT_DEV_HANDSET,
	EBDAT_DEV_HEADSET,
	EBDAT_DEV_SPEAKER,
	EBDAT_DEV_HFK
}ebdat_audio_dev_t;

typedef enum
{
	EBDAT_PCM_FMT_ULAW,
	EBDAT_PCM_FMT_ALAW,
	EBDAT_PCM_FMT_LEANER
}ebdat_pcm_fmt_t;
	
typedef enum
{
	EBDAT_PCM_MD_AUXILIARY_MASTER,
	EBDAT_PCM_MD_PRIMARY_MASTER,
	EBDAT_PCM_MD_PRIMARY_SLAVER
}ebdat_pcm_mode_t;

/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DECLARATION                                                                             */
/*-------------------------------------------------------------------------------------*/
/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_mic_amp1_set
  * 
  * DESCRIPTION: set current mic's gain
  * 
  * PARAMETER: [in] amp_level - gain : 0, 1
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_mic_gain_set(uint8 amp_level);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_sidetone_set
  * 
  * DESCRIPTION: set current device's sidetone gain
  * 
  * PARAMETER: [in] value - gain
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_sidetone_set(uint16 gain);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_auido_tx_gain_set
  * 
  * DESCRIPTION: set current device's gain of TX path 
  * 
  * PARAMETER: [in] value - gain
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_auido_tx_gain_set(uint16 gain);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_rx_gain_set
  * 
  * DESCRIPTION: set current device's gain of RX path 
  * 
  * PARAMETER: [in] value - gain
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_rx_gain_set(uint16 gain);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_tx_vol_set
  * 
  * DESCRIPTION: set current device's volumn of TX path 
  * 
  * PARAMETER: [in] volumn - volumn value
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_tx_vol_set(uint16 volumn);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_rx_vol_set
  * 
  * DESCRIPTION: set current device's volumn of RX path 
  * 
  * PARAMETER: [in] volumn - volumn value
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_rx_vol_set(uint16 volumn);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_tx_ftr_set
  * 
  * DESCRIPTION: set current device's filter parameters of TX path 
  * 
  * PARAMETER: [in] ftr_param - filter parameters
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_tx_ftr_set(const ebdat_audio_pcm_ftr_t *ftr_param);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_rx_ftr_set
  * 
  * DESCRIPTION: set current device's filter parameters of RX path 
  * 
  * PARAMETER: [in] ftr_param - filter parameters
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_rx_ftr_set(const ebdat_audio_pcm_ftr_t *ftr_param);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_echo_mode_set
  * 
  * DESCRIPTION: set current device's EC mode
  * 
  * PARAMETER: [in] ec_md - EC mode type
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_echo_mode_set(ebdat_audio_ec_t ec_md);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_noise_mode_set
  * 
  * DESCRIPTION: set current device's NS mode
  * 
  * PARAMETER: [in] ec_md - NS mode type
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_noise_mode_set(ebdat_audio_ns_t ns_md);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_echo_param_set
  * 
  * DESCRIPTION: set current EC mode's parameter
  * 
  * PARAMETER: [in] param_index -index parameter to set to
  *                     [in] param_val - value to set 
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_echo_param_set(uint8 param_index, uint16 param_val);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_volumn_level_set
  * 
  * DESCRIPTION: set one level's volumn value
  * 
  * PARAMETER: [in] level -volumn level to set
  *                     [in] volumn - value to set to the level
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_volumn_level_set(uint8 level, int16 volumn);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_volumn_level_select
  * 
  * DESCRIPTION: select volumn level
  * 
  * PARAMETER: [in] level -volumn level to select
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_volumn_level_select(uint8 level);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_device_set
  * 
  * DESCRIPTION: set the current valid audio device 
  * 
  * PARAMETER: [in] dev_type -device to select
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_device_set(ebdat_audio_dev_t dev_type);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_device_mute
  * 
  * DESCRIPTION: mute/unmute current device's INPUT/OUTPUT path 
  * 
  * PARAMETER: [in] in_mute -input path mute/unmute
  *                     [in] out_mute - output path mute/unmute
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_device_mute(boolean in_mute, boolean out_mute);

/***************************************************************************************
  *
  * FUNCTION:   ebdat_audio_pcm_set
  * 
  * DESCRIPTION: config the PCM interface
  * 
  * PARAMETER: [in] mode -PCM mode
  *                     [in] fmt - data format
  *                     [in] slot - data slot
  *  
  * RETURN VALUE: TRUE - success
  *                          FALSE -failed
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
boolean ebdat_audio_pcm_set(ebdat_pcm_mode_t mode, ebdat_pcm_fmt_t fmt, uint8 slot);

void ebdat_audio_play_tone(ebdat_audio_dev_t dev, uint8 tone_id);
#endif /*__EBDAT_AUDIO_H__*/

