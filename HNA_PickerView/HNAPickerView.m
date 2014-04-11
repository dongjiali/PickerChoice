//
//  HNAPickerView.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HNAPickerView.h"
#import "HNAPicker.h"
@interface HNAPickerView ()
@property (nonatomic, strong)UIView *preaSuperView;
@property (nonatomic, strong)HNAPicker *pickerView;
@end

@implementation HNAPickerView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    return [self initPickerData:nil Section:0];
}

- (id)initPickerData:(NSArray *)pickerData Section:(NSInteger)pickerSection
{
    if(self = [super init])
    {
        self.pickerView = [[HNAPicker alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _pickerView.backgroundColor = [UIColor clearColor];
        [_pickerView selectedDone:^(NSArray *item) {
            if (item) {
                NSLog(@"%@",item);
            }
            [self selectItemDone];
        }];
        self.view = _pickerView;
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setItemsArray:(NSArray *)itemsArray
{
    [_pickerView setItemsDataSource:itemsArray];
}

//设置父VIEW
- (void)addPreaSuperView:(UIView *)preaSuperView{
    _preaSuperView = preaSuperView;
}

//弹出VIEW
- (void)showDatePickerView
{
    //改变状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //把view添加到window中
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [_pickerView setScrollViewContent];
        self.view.frame = CGRectMake(0, -10, self.view.frame.size.width, self.view.frame.size.height);
        _preaSuperView.transform = CGAffineTransformMakeScale(0.90, 0.90);
        _preaSuperView.alpha = 0.6;
        _preaSuperView.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }];
}

- (void)selectItemDone
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        _preaSuperView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _preaSuperView.alpha = 1.0;
    } completion:^(BOOL finished) {
        _preaSuperView.userInteractionEnabled = YES;
        //改变状态栏颜色
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        //把view从window中移除
        [self.view removeFromSuperview];
    }];
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
