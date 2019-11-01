//
//  VoiceCallViewController.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "VoiceCallViewController.h"

@interface VoiceCallViewController ()

@property (strong, nonatomic) IBOutlet UILabel *durationTimeLabel;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation VoiceCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)muteClick:(id)sender {
    [_callSession setMuted:!_callSession.isMuted];
}

- (IBAction)hangUpClick:(id)sender {
    [_callSession hangup];
}

- (IBAction)speakerClick:(id)sender {
    [_callSession setSpeakerEnabled:!_callSession.speakerEnabled];
}

#pragma mark -

- (void)startTimer {
    [self.timer invalidate];
    
    __weak typeof(self) objWeak = self;
    NSDate *startDate = [NSDate date];
    self.timer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger timeInterval = MAX(-[startDate timeIntervalSinceNow], 0);
        NSString *durationString = @"";
        if (timeInterval > FLT_EPSILON) {
            durationString = [NSString stringWithFormat:@"%02ld:%02ld", (long)timeInterval/60, (long)timeInterval%60];
        } else {
            durationString = @"00:00";
        }
        objWeak.durationTimeLabel.text = durationString;
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

@end
