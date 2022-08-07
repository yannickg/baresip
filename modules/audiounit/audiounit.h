/**
 * @file audiounit.h  AudioUnit sound driver -- Internal interface
 *
 * Copyright (C) 2010 Alfred E. Heggestad
 */

#if __MAC_OS_X_VERSION_MAX_ALLOWED < 120000
#define kAudioObjectPropertyElementMain (kAudioObjectPropertyElementMaster)
#endif

#if TARGET_OS_IPHONE

    /**
     * As in iOS SDK 4 or later, audio route change property listener is
     * no longer necessary. Just make surethat your application can receive
     * remote control events by adding the code:
     *     [[UIApplication sharedApplication] 
     *      beginReceivingRemoteControlEvents];
     * Otherwise audio route change (such as headset plug/unplug) will not be
     * processed while your application is in the background mode.
     */
    #define USE_AUDIO_ROUTE_CHANGE_PROP_LISTENER 0
    /* Starting iOS SDK 7, Audio Session API is deprecated. */
    #define USE_AUDIO_SESSION_API 0

    /* For better integration with CallKit features (available starting
     * in iOS 10), let the application setup and manage its own
     * audio session.
     */
    #define SETUP_AV_AUDIO_SESSION  1

#endif

AudioComponent audiounit_comp_io;
AudioComponent audiounit_comp_conv;


struct audiosess;
struct audiosess_st;
struct conv_buf;


typedef void (audiosess_int_h)(bool start, void *arg);

int  audiosess_alloc(struct audiosess_st **stp,
		     audiosess_int_h *inth, void *arg);
void audiosess_interrupt(bool interrupted);


int conv_buf_alloc(struct conv_buf **bufp, size_t framesz);
int  get_nb_frames(struct conv_buf *buf, uint32_t *nb_frames);
OSStatus init_data_write(struct conv_buf *buf, void **data,
			 size_t framesz, uint32_t nb_frames);
OSStatus init_data_read(struct conv_buf *buf, void **data,
			size_t framesz, uint32_t nb_frames);


int audiounit_player_alloc(struct auplay_st **stp, const struct auplay *ap,
			   struct auplay_prm *prm, const char *device,
			   auplay_write_h *wh, void *arg);
int audiounit_recorder_alloc(struct ausrc_st **stp, const struct ausrc *as,
			     struct ausrc_prm *prm, const char *device,
			     ausrc_read_h *rh, ausrc_error_h *errh, void *arg);


uint32_t audiounit_aufmt_to_formatflags(enum aufmt fmt);
