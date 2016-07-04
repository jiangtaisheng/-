//
//  ViewController.m
//  手势解锁
//
//  Created by apple2015 on 16/3/2.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "GirlsViewController.h"
#import "GirlssssViewController.h"

@interface ViewController ()<CustomViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet CustomView *CustView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CustView.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)customView:(CustomView *)customView andWithPath:(NSString *)path
{

   
    NSLog(@"%@",path);
    NSString * str=[NSString stringWithFormat:@"你输的的密码是:%@",path];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    
    [alert show];
    
    if([path isEqualToString:@"0124678"])
    {
        GirlssssViewController * vc=[[GirlssssViewController alloc]init];
        
     
        [self presentViewController:vc animated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
