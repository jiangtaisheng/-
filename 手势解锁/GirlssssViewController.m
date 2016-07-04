//
//  GirlssssViewController.m
//  手势解锁
//
//  Created by apple2015 on 16/3/2.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "GirlssssViewController.h"

@interface GirlssssViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)preBtn:(id)sender;
@property(nonatomic,assign) int index;
- (IBAction)nextBtn:(id)sender;
- (IBAction)back:(id)sender;
@end

@implementation GirlssssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //    GirlsViewController*  vc = [[GirlsViewController alloc] initWithNibName:@"Girls" bundle:nil];
      self.index=9;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)preBtn:(id)sender {
    self.index--;
    if (self.index==0) {
        self.index=15;
    }
    
    
    NSString * imageN=[NSString stringWithFormat:@"%d.jpg",self.index];
    
    [self.photo setImage:[UIImage imageNamed:imageN]];
    
    CATransition * animation=[CATransition animation];
    
    animation.type=@"pageUnCurl";
    //    animation.subtype=@"kCATransitionFromRight";
    animation.duration=1.0;
    [self.photo.layer addAnimation:animation forKey:nil];

}

- (IBAction)nextBtn:(id)sender {
    self.index++;
    if (self.index==16) {
        self.index=1;
    }
    
    
    NSString * imageN=[NSString stringWithFormat:@"%d.jpg",self.index];
    
    [self.photo setImage:[UIImage imageNamed:imageN]];
    
    CATransition * animation=[CATransition animation];
    
    animation.type=@"pageUnCurl";
    animation.subtype=@"kCATransitionFromRight";
    animation.duration=1.0;
    animation.startProgress=0.3;
    animation.endProgress=0.7;
    [self.photo.layer addAnimation:animation forKey:nil];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
