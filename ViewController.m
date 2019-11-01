//
//  ViewController.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [appDelegate addObserver:self forKeyPath:@"voipPushToken" options:NSKeyValueObservingOptionNew context:nil];
    
    _textView.text = appDelegate.voipPushToken;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"voipPushToken"]) {
        _textView.text = change[NSKeyValueChangeNewKey];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (IBAction)incomingCall:(id)sender {
    [(AppDelegate *)UIApplication.sharedApplication.delegate incomingCall:@"模拟触发"];
}

@end
