//
//  SoundPlayer.m
//  J-Walker
//
//  Created by Alan Hu on 2015-01-05.
//  Copyright (c) 2015 Alan Hu. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

-(id)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
    
}

-(void)makeMusic {
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:_urlPath, [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];

}

@end
