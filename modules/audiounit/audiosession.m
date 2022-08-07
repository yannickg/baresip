#include <AVFoundation/AVAudioSession.h>
#include <re.h>
#include <rem.h>
#include <baresip.h>

int AVAudioSessionSetProperty()
{
    /* Initialize audio session category and mode */
	AVAudioSession *sess = [AVAudioSession sharedInstance];
	int err;
	if ([sess respondsToSelector:@selector(setCategory:withOptions:error:)])
	{
	    err = [sess setCategory:AVAudioSessionCategoryPlayAndRecord
		        withOptions:AVAudioSessionCategoryOptionAllowBluetooth
		        error:nil] != YES;
    }
    else 
    {
        err = [sess setCategory:AVAudioSessionCategoryPlayAndRecord
            error:nil] != YES;
    }

	if (err) 
    {
        warning("audiounit: failed settting audio session category");
	}

	if ([sess respondsToSelector:@selector(setMode:error:)] &&
	    [sess setMode:AVAudioSessionModeVoiceChat error:nil] != YES)
	{
        warning("audiounit: failed settting audio mode");
	}

    return err;
}

int AVAudioSessionSetBufferDuration()
{
	AVAudioSession *sess = [AVAudioSession sharedInstance];
	NSTimeInterval duration;

	/* For low-latency audio streaming, you can set this value to
	 * as low as 5 ms (the default is 23ms). However, lowering the
	 * latency may cause a decrease in audio quality.
	 */
	duration = 0.023;
	if ([sess setPreferredIOBufferDuration:duration error:nil] != YES)
    {
        warning("audiounit: cannot set the preferred buffer duration");
        return 1;
	}

    return 0;
}
