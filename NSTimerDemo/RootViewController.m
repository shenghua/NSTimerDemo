//
//  RootViewController.m
//  NSTimerDemo
//
//  Created by wsh on 6/24/13.
//  Copyright (c) 2013 wsh. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UILabel *timerLabel;

@end

@implementation RootViewController

@synthesize timer, timerLabel;

- (void)dealloc
{
    [timer release];
    [timerLabel release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self.timer invalidate];
    self.timer = nil;
    self.timerLabel = nil;
    [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    bgView.backgroundColor = [UIColor grayColor];
    self.view = bgView;
    [bgView release];
    
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(160 - 150, 230 - 200, 80, 20)];
    self.timerLabel.backgroundColor = [UIColor clearColor];
    self.timerLabel.textColor = [UIColor redColor];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
//    [self.timerLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:128.0]];
//	self.timerLabel.text = @"I0A0IN6";
    
    [self.view addSubview:timerLabel];
    [self.timerLabel release];
    
    [self onTimer];
}

- (void)updateLabel
{
    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
//    [dateFormatter setDefaultDate:now];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponets = [[NSDateComponents alloc] init];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    dateComponets = [calendar components:unitFlags fromDate:now];
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", [dateComponets hour], [dateComponets minute], [dateComponets second]];
}

- (void)onTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion compare:@"6.0"] == NSOrderedSame
        || [[UIDevice currentDevice].systemVersion compare:@"6.0"] == NSOrderedDescending)
    {
        if ([self.view window] == nil)
        {
            self.timer = nil;
            self.timerLabel = nil;
        }
    }
}

@end
