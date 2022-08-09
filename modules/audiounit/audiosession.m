#include <AVFoundation/AVAudioSession.h>
#include "audiosession.h"
#include <re.h>
#include <rem.h>
#include <baresip.h>


int AVAudioSessionInitialize(void)
{
	AVAudioSession *sess = [AVAudioSession sharedInstance];

    NSError *error = nil;
	int err = 0;

	if ([sess respondsToSelector: @selector(setCategory:withOptions:error:)])
	{
	    err = [sess setCategory: AVAudioSessionCategoryPlayAndRecord
		        withOptions: AVAudioSessionCategoryOptionAllowBluetooth
		        error: nil] != YES;
    }
    else 
    {
        err = [sess setCategory: AVAudioSessionCategoryPlayAndRecord
            error: nil] != YES;
    }

	if (err) 
    {
        warning("audiounit: failed setting audio session category\n");
	}

	if ([sess respondsToSelector: @selector(setMode:error:)] &&
	    [sess setMode: AVAudioSessionModeVideoChat error: nil] != YES)
	{
        err = 1;
        warning("audiounit: failed setting audio mode\n");
	}

    [sess setActive:YES error:&error];
    if (error)
    {
        err = 1;
        warning("audiounit: failed setting Audiosession Active: %s\n", error.localizedDescription);
    }


    return err;
}
