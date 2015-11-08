//
//  CustomViewController.m
//  Matcho
//
//  Created by Sergey Rybalko on 11/8/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "CustomViewController.h"

@class ViewController;

@interface CustomViewController ()

@property(nonatomic, strong) NSArray *colors;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    self.colors = @[[UIColor blueColor], [UIColor redColor], [UIColor greenColor]];
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    
    self.view.backgroundColor = self.colors[arc4random_uniform(3)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGame:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ViewController *gameView = [storyboard instantiateViewControllerWithIdentifier:@"GameView"];
    [self presentViewController:gameView animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
