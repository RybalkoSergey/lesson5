//
//  ViewController.m
//  HypnoNerd
//
//  Created by Sergey Rybalko on 11/6/15.
//  Copyright © 2015 Sergey Rybalko. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController ()

@end

@implementation BNRHypnosisViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view");}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.tabBarItem.title = @"Hypnose";
    
    UIImage *i = [UIImage imageNamed:@"Hypno.png"];
    self.tabBarItem.image = i;
    
    return self;
}

- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
 

    self.view = backgroundView;
}

@end
