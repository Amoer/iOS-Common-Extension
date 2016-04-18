//
//  AMRecorderAndPlayer.h
//  融云无界面通信
//
//  Created by ziboow on 16/4/14.
//  Copyright © 2016年 ziboow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <RongIMLib/RongIMLib.h>
@interface AMRecorderAndPlayer : NSObject

+ (void)startRecorder;

+ (void)stopRecorder;

+ (void)startPlayer;

+ (NSString *)recorderPath;

+ (RCVoiceMessage *)voiceMessage;

+ (instancetype)shareRecorderAndPlayer;


@end
