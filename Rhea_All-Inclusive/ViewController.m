//
//  ViewController.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"MainEntrance" bundle:nil] instantiateInitialViewController];
            self.view.window.rootViewController = vc;
        });
    });
    
}


@end
