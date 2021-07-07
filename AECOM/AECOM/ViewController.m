//
//  ViewController.m
//  AECOM
//
//  Created by Prasad on 1/11/16.
//  Copyright (c) 2016 rapidBizApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <WebServiceDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sleep(3);
    [self loadRootView];
   // [self performSelectorOnMainThread:@selector(loadingActivity) withObject:nil waitUntilDone:YES];
    [self getPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPhotos
{
    if ([ReusedMethods checkNetwrokConnection])
    {
    WebServiceClass * service = [[WebServiceClass alloc] init];
    service.delegate = self;
    [service getPhotos];
    }
    else
    {
        [ReusedMethods sharedObject].isPics = YES;
        [self refreshBottomView];
    }
}

-(void)checkDataWithDB
{
    id object = [ReusedMethods getResponseUserDefaults:DB_PICS];
    if (object)
    {
        [self parseResponse:object];
    }
    
}
#pragma mark WebService Delegate methods
-(void)serviceCallDoneSuccess:(id)resposne withMethodName:(NSString *)methodName
{
    [ReusedMethods saveResponseInUserDefaults:resposne WithKey:DB_PICS];
    [self parseResponse:resposne];
    [self hideActivity];
    
}
-(void)serviceCallFailedWithError:(NSError *)error withMethodName:(NSString *)methodName
{
    NSLog(@"FAIL %@",error);
    [ReusedMethods sharedObject].isPics = YES;
    [self hideActivity];
     [self refreshBottomView];
}

-(void)parseResponse:(id)response
{
    NSArray * array = (NSArray *)response;
    picturesArray = [[NSMutableArray alloc] init];
    for (id object  in array)
    {
        AEVRData * data = [[AEVRData alloc] initWithVRDict:object];
        data.duration = @"";
        [picturesArray addObject:data];
    }
    if  (picturesArray.count)
    {
        [ReusedMethods sharedObject].isPics = YES;
    }
    else
    {
        [ReusedMethods sharedObject].isPics = NO;
    }
     [ReusedMethods sharedObject].isPics = NO;
    [self refreshBottomView];
}

-(void)loadingActivity
{
    [RBAActivityLoader setupLoaderViewOnView:self.view];
    [RBAActivityLoader showLoaderOnView:self.view withTitle:@"Loading..."];
}

-(void)hideActivity
{
    [RBAActivityLoader removeLoader];
}

-(void)refreshBottomView
{
   // AppDelegate * delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
   // [delegate refreshBottomView];
}
-(void)loadRootView
{
    AppDelegate * delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate setRootViewController];
}
@end
