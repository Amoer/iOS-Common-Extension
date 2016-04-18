//
//  AMRecorderAndPlayer.m
//  融云无界面通信
//
//  Created by ziboow on 16/4/14.
//  Copyright © 2016年 ziboow. All rights reserved.
//

#import "AMRecorderAndPlayer.h"

@interface AMRecorderAndPlayer ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) long playTime;
@property (nonatomic, strong) NSData *wavData;

@end
@implementation AMRecorderAndPlayer

static AMRecorderAndPlayer *recorderAndPlayer = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (recorderAndPlayer == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            recorderAndPlayer = [super allocWithZone:zone];
        });
    }
    return recorderAndPlayer;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recorderAndPlayer = [super init];
    });
    return recorderAndPlayer;
}

+ (instancetype)shareRecorderAndPlayer {
    return [[self alloc] init];
}


+ (void)startRecorder {
    [[AMRecorderAndPlayer shareRecorderAndPlayer] startRecord];
}

+ (void)stopRecorder {
    [[AMRecorderAndPlayer shareRecorderAndPlayer] stopRecord];
}

+ (void)startPlayer {
    [[AMRecorderAndPlayer shareRecorderAndPlayer] startPlay];
}


+ (NSString *)recorderPath {
    return [AMRecorderAndPlayer shareRecorderAndPlayer].filePath;
}
/**
 *  @return 封装后成 RCVoiceMessage
 */
+ (RCVoiceMessage *)voiceMessage {
    RCVoiceMessage *voiceMessage = [RCVoiceMessage messageWithAudio:[AMRecorderAndPlayer shareRecorderAndPlayer].wavData duration:[AMRecorderAndPlayer shareRecorderAndPlayer].playTime];
    return voiceMessage;
}

/**
 *  开始录音
 */
- (void)startRecord {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    NSDictionary *settings = @{AVFormatIDKey: @(kAudioFormatLinearPCM),
                               AVSampleRateKey: @8000.00f,
                               AVNumberOfChannelsKey: @1,
                               AVLinearPCMBitDepthKey: @16,
                               AVLinearPCMIsNonInterleaved: @NO,
                               AVLinearPCMIsFloatKey: @NO,
                               AVLinearPCMIsBigEndianKey: @NO};
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"talk.wav"];
    self.filePath = filePath;
    if (error) {
        NSLog(@"配置出错");
    }
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:filePath] settings:settings error:&error];
    NSLog(@"开始录音");
    [self.recorder record];
}

/**
 *  停止录音
 */
- (void)stopRecord{
    [self.recorder stop];
    NSTimeInterval playTime = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.filePath] error:NULL].duration;
    NSLog(@"录音时长是 %f",playTime);
    self.playTime = playTime;
    NSLog(@"停止录音 ...");
}
/**
 *  开始播放
 */
- (void)startPlay {
    self.wavData = [NSData dataWithContentsOfFile:self.filePath];
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (error) {
        NSLog(@"配置出错");
        return;
    }
    self.player = [[AVAudioPlayer alloc] initWithData:self.wavData error:&error];
    NSLog(@"开始播放...");
    [self.player play];
}


@end
