//
//  HnapickerViewController.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-7.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HnapickerViewController.h"
#import "HNAPickerView.h"
@interface HnapickerViewController ()
{
    HNAPickerView *picker;
}
@end

@implementation HnapickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    picker = [[HNAPickerView alloc]initPickerData:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] Section:1];
    picker = [[HNAPickerView alloc]init];
    [picker addPreaSuperView:self.view];
    
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:0];
    button2.frame = CGRectMake(0, 300, 100, 100);
    button2.backgroundColor = [UIColor blueColor];
    [button2 addTarget:self action:@selector(add2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)add
{
    [picker setItemsArray:@[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]]];
    [picker showDatePickerView];
}

- (void)add2
{
    [picker setItemsArray:nil];
    [picker showDatePickerView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
