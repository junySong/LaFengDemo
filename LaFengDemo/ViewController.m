//
//  ViewController.m
//  LaFengDemo
//
//  Created by 宋俊红 on 16/8/29.
//  Copyright © 2016年 Juny_song. All rights reserved.
//

#import "ViewController.h"

#import "LFLivePreview.h"

#import "LFLiveSession.h"

@interface ViewController ()<LFLiveSessionDelegate>

@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:[[LFLivePreview alloc] initWithFrame:self.view.bounds]];
//    [self session];
//    [self startLive];
    NSMutableString *a = [NSMutableString stringWithString:@"Tom"];
    NSLog(@"\n 定以前：------------------------------------\n\
         %@-- a指向的堆中地址：%p；a在栈中的指针地址：%p",a, a, &a);               //a在栈区
    void (^foo)(void) = ^{
        a.string = @"Jerry";
        NSLog(@"\n block内部：------------------------------------\n\
            %@--   a指向的堆中地址：%p；a在栈中的指针地址：%p",a,  a, &a);               //a在栈区
//        a = [NSMutableString stringWithString:@"William"];
        a.string = @"helloword";
    };
    foo();
    NSLog(@"\n 定以后：------------------------------------\n\
        %@--   a指向的堆中地址：%p；a在栈中的指针地址：%p",a,  a, &a);               //a在栈区

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
#pragma mark Private
- (LFLiveSession*)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.preView = self.view;
        _session.delegate = self;
        [_session setRunning:YES];//开始录制
    }
    return _session;
}

- (void)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"rtmp://pili-live-rtmp.newzhibo.cn/newlive/Juny";//pili-live-rtmp.newzhibo.cn
    [self.session startLive:streamInfo];
}

- (void)stopLive {
    [self.session stopLive];
}

- (void)liveSession:(LFLiveSession *)session liveStateDidChange: (LFLiveState)state{
    NSLog(@"LFLiveState--%d",state);
}
- (void)liveSession:( LFLiveSession *)session debugInfo:( LFLiveDebug*)debugInfo{
     NSLog(@"debugInfo--%@",debugInfo.description);
}
- (void)liveSession:( LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"LFLiveSocketErrorCode--%d",errorCode);

}
@end
