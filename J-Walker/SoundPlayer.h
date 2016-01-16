//
//  SoundPlayer.h
//  J-Walker
//
//  Created by Alan Hu on 2015-01-05.
//  Copyright (c) 2015 Alan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

AVAudioPlayer *audioPlayer;
@interface SoundPlayer : NSObject
@property NSString *urlPath;

-(void)makeMusic;
@end
