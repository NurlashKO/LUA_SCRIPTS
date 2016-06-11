printdir(1)

SND_ALERT = 0;--ring for incomging call
SND_WAKEUP = 1; --Wake-up/Power-up sound
SND_DIAL_TONE = 2; --Dial tone
SND_DTACO_ROAM_TONE = 3          -- DTACO roaming dial tone                   
SND_RING_BACK = 4                -- Ring-back sound                           
SND_INTERCEPT = 5                -- Send request intercepted locally          
SND_REORDER = 6                  -- System busy                               
SND_BUSY_ALERT = 7               -- Busy Signal                               
SND_CONFIRMATION = 8             -- Confirmation Tone                         
SND_CALL_WAITING = 9             -- Call Waiting                              
SND_ANSWER = 10                   -- 10 - Answer Tone                          
SND_OFF_HOOK = 11                 -- Off-Hook Warning                          
SND_NORMAL_ALERT = 12             -- "Normal" Alerting                         
SND_INTR_GROUP_ALERT = 13         -- Intergroup Alerting                       
SND_SPCL_ALERT = 14               -- Special/Priority Alerting                 
SND_PING_RING = 15                -- "Ping ring"                               
SND_IS54B_LONG_H_ALERT = 16       -- IS-54B High Long                          
SND_IS54B_SS_H_ALERT = 17         -- IS-54B High Short-short                   
SND_IS54B_SSL_H_ALERT = 18        -- IS-54B High Short-short-long              
SND_IS54B_SS2_H_ALERT = 19        -- IS-54B High Short-short-2                 
SND_IS54B_SLS_H_ALERT = 20        -- 20 - IS-54B High Short-long-short         
SND_IS54B_SSSS_H_ALERT = 21       -- IS-54B High Short-short-short-short       
SND_IS54B_PBX_LONG_H_ALERT = 22   -- IS-54B High PBX Long                      
SND_IS54B_PBX_SS_H_ALERT = 23     -- IS-54B High PBX Short-short               
SND_IS54B_PBX_SSL_H_ALERT = 24    -- IS-54B High PBX Short-short-long          
SND_IS54B_PBX_SLS_H_ALERT = 25    -- IS-54B High PBX Short-long-short          
SND_IS54B_PBX_SSSS_H_ALERT = 26   -- IS-54B High PBX Short-short-short-short   
SND_IS53A_PPPP_H_ALERT = 27       -- IS-53A High Pip-Pip-Pip-Pip Alert         
SND_IS54B_LONG_M_ALERT = 28       -- IS-54B Medium Long                        
SND_IS54B_SS_M_ALERT = 29         -- IS-54B Medium Short-short                 
SND_IS54B_SSL_M_ALERT = 30        -- 30 - IS-54B Medium Short-short-long       
SND_IS54B_SS2_M_ALERT = 31        -- IS-54B Medium Short-short-2               
SND_IS54B_SLS_M_ALERT = 32        -- IS-54B Medium Short-long-short            
SND_IS54B_SSSS_M_ALERT = 33       -- IS-54B Medium Short-short-short-short     
SND_IS54B_PBX_LONG_M_ALERT = 34   -- IS-54B Medium PBX Long                    
SND_IS54B_PBX_SS_M_ALERT = 35     -- IS-54B Medium PBX Short-short             
SND_IS54B_PBX_SSL_M_ALERT = 36    -- IS-54B Medium PBX Short-short-long        
SND_IS54B_PBX_SLS_M_ALERT = 37    -- IS-54B Medium PBX Short-long-short        
SND_IS54B_PBX_SSSS_M_ALERT = 38   -- IS-54B Medium PBX Short-short-short-short 
SND_IS53A_PPPP_M_ALERT = 39       -- IS-53A Medium Pip-Pip-Pip-Pip Alert       
SND_IS54B_LONG_L_ALERT = 40       -- 40 - IS-54B Low Long                      
SND_IS54B_SS_L_ALERT = 41         -- IS-54B Low Short-short                    
SND_IS54B_SSL_L_ALERT = 42        -- IS-54B Low Short-short-long               
SND_IS54B_SS2_L_ALERT = 43        -- IS-54B Low Short-short-2                  
SND_IS54B_SLS_L_ALERT = 44        -- IS-54B Low Short-long-short               
SND_IS54B_SSSS_L_ALERT = 45       -- IS-54B Low Short-short-short-short        
SND_IS54B_PBX_LONG_L_ALERT = 46   -- IS-54B Low PBX Long                       
SND_IS54B_PBX_SS_L_ALERT = 47     -- IS-54B Low PBX Short-short                
SND_IS54B_PBX_SSL_L_ALERT = 48    -- IS-54B Low PBX Short-short-long           
SND_IS54B_PBX_SLS_L_ALERT = 49    -- IS-54B Low PBX Short-long-short           
SND_IS54B_PBX_SSSS_L_ALERT = 50   -- 50 - IS-54B Low PBX Short-short-short-shrt
SND_IS53A_PPPP_L_ALERT = 51       -- IS-53A Low Pip-Pip-Pip-Pip Alert          
SND_FADE_TONE = 52                -- Tone to inform user of a fade             
SND_SVC_CHANGE = 53               -- Inform user of a service area change      
SND_HORN_ALERT = 54               -- Horn alert                                
SND_ABRV_REORDER = 55             -- Abbreviated System busy                   
SND_ABRV_INTERCEPT = 56           -- Abbrev'd Send request intercepted locally 
SND_ALTERNATE_REORDER = 57        -- Alternate reorder                         
SND_MESSAGE_ALERT = 58            -- Message Waiting Signal                    
SND_ABRV_ALERT = 59               -- Abbreviated alert                         
SND_PIP_TONE = 60                 -- 60 - Pip Tone (Voice Mail Waiting)        
SND_ROAM_RING = 61                -- Ringing option while roaming              
SND_SVC_ACQ = 62                  -- Service acquired sound                    
SND_SVC_LOST = 63                 -- Service lost sound                        
SND_SVC_CHNG_MORE_PREF = 64       -- Change to a more preferred service sound  
SND_SVC_CHNG_LESS_PREF = 65       -- Change to a less preferred service sound  
SND_EXT_PWR_ON = 66               -- External power on sound                   
SND_EXT_PWR_OFF = 67              -- External power off sound                  
SND_RING_1 = 68                   -- User selectable ring 1                    
SND_RING_2 = 69                   -- User selectable ring 2                    
SND_RING_3 = 70                   -- 70 - User selectable ring 3               
SND_RING_4 = 71                   -- User selectable ring 4                    
SND_RING_5 = 72                   -- User selectable ring 5                    
SND_RING_6 = 73                   -- User selectable ring 6                    
SND_RING_7 = 74                   -- User selectable ring 7                    
SND_RING_8 = 75                   -- User selectable ring 8                    
SND_RING_9 = 76                   -- User selectable ring 9                    
SND_VR_HFK_CALL_RECEIVED = 77     -- Call answer sound when in HFK             
SND_HFK_CALL_ORIG = 78            -- Call origination sound when in HFK        
SND_SPECIAL_INFO = 79             -- Special info sound                        
                              -- GSM tones defined in 3GPP 2.40           
SND_SUBSCRIBER_BUSY = 80          -- 80 - Subscriber busy sound                
SND_CONGESTION = 81               -- Congestion sound                          
SND_ERROR_INFO = 82               -- Error information sound                   
SND_NUMBER_UNOBTAINABLE = 83      -- Number unobtainable sound                 
SND_AUTH_FAILURE = 84             -- Authentication failure sound              
SND_RADIO_PATH_ACK = 85           -- Radio path acknowledgement sound          
SND_RADIO_PATH_NOT_AVAIL = 86     -- Radio path not available sound            
SND_CEPT_CALL_WAITING = 87        -- CEPT call waiting sound                   
SND_CEPT_RING = 88                -- CEPT ringing sound                        
SND_CEPT_DIAL_TONE = 89           -- CEPT dial tone   

SND_BRITISH_BUSY = 90              --CUSTOMER defined BUSY tone(British busy sound)



SND_DEV_CURRENT = 0
SND_DEV_HANDSET = 1
SND_DEV_HEADSET = 2
SND_DEV_SPEAKER = 3
local result;

local tone_id = SND_ALERT;
result = multimedia.play_tone(tone_id);
print("multimedia.play_tone, result=", result, "\r\n");

vmsleep(1000);
multimedia.stop_tone();
print("multimedia.stop_tone called\r\n");

dev = SND_DEV_CURRENT;
result = multimedia.play_tone(tone_id,dev);
print("multimedia.play_tone, result=", result, "\r\n");

vmsleep(1000);
multimedia.stop_tone();
print("multimedia.stop_tone called\r\n");

dev = SND_DEV_HANDSET;
result = multimedia.play_tone(tone_id,dev);
print("multimedia.play_tone, result=", result, "\r\n");

vmsleep(1000);
multimedia.stop_tone();
print("multimedia.stop_tone called\r\n");

dev = SND_DEV_HEADSET;
result = multimedia.play_tone(tone_id,dev);
print("multimedia.play_tone, result=", result, "\r\n");

vmsleep(1000);
multimedia.stop_tone();
print("multimedia.stop_tone called\r\n");

dev = SND_DEV_SPEAKER;
result = multimedia.play_tone(tone_id,dev);
print("multimedia.play_tone, result=", result, "\r\n");

vmsleep(1000);
multimedia.stop_tone();
print("multimedia.stop_tone called\r\n");