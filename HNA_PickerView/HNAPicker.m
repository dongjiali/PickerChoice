//
//  HNAPicker.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HNAPicker.h"
#import "HNAPickerCollectionView.h"
#import "HNAPickerCollectionViewFlowLayout.h"
#import "HNAPickerMacro.h"
#import "HNAPickerDateSource.h"

@interface HNAPicker()
{
    HNAPickerDateSource *pickerDateScource;
    
}
@property (nonatomic, strong)NSMutableArray *pickerDataArray;
@property (nonatomic, strong)NSMutableArray *resultDataArray;
@property (nonatomic, strong)NSMutableArray *HNAPickerArray;
@property (nonatomic, strong)NSString *pickerTitleText;
@property (nonatomic, strong)UIButton *doneButton;
@property (nonatomic, strong)NSArray *oldPickerArray;
@end

@implementation HNAPicker

- (id)init
{
   return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        pickerDateScource = [[HNAPickerDateSource alloc]init];
        self.pickerDataArray = [NSMutableArray array];
        self.HNAPickerArray = [NSMutableArray array];
        self.resultDataArray = [NSMutableArray array];
        self.oldPickerArray = [NSArray array];
    }
    return self;
}

#pragma -mark- init
- (void)initialize{
//    if (self.pickerType == PickertypeDate ) {
//        [self initPickerDateSource];
//        self.pickerTitleText = @"请选择出生日期";
//    }
//    else{
//        [self initItemDataSource:pickerData Section:section];
//        self.pickerTitleText = @"请选择";
//    }
}

- (void)setItemsDataSource:(NSArray *)itemsDataSource
{
    if ([self isreloadPickerData:itemsDataSource]) {
        return;
    }
    [_resultDataArray removeAllObjects];
    [_pickerDataArray removeAllObjects];
    if (itemsDataSource == nil) {
        [self initPickerDateSource];
        self.pickerTitleText = @"请选择日期";
        self.pickerType = PickertypeDate;
    }
    else
    {
        [self initItemDataSource:itemsDataSource];
        self.pickerTitleText = @"请选择";
        self.pickerType = PickertypeItem;
    }
    [self buildViewControl];
}

- (BOOL)isreloadPickerData:(NSArray *)newData
{
    if (newData == nil && _oldPickerArray == nil) {
        return YES;
    }
    else if ([newData isEqualToArray:_oldPickerArray])
    {
        return YES;
    }
    _oldPickerArray = newData;
    return NO;
}

#pragma -mark- build View
- (void)buildViewControl {
    //add cancel button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - (HEADERVIEWHEIGHT +PICKERVIEWHEIGHT));
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    //add picker view to bottom
    UIView *pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - (HEADERVIEWHEIGHT +PICKERVIEWHEIGHT), self.frame.size.width, HEADERVIEWHEIGHT + PICKERVIEWHEIGHT)];
    pickerView.backgroundColor = [UIColor clearColor];
    [self addSubview:pickerView];
    //add header view
    [self addHeaderView:pickerView];
    //add picker view
    [self addPickerView:pickerView];
}

- (void)addHeaderView:(UIView *)subView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, HEADERVIEWHEIGHT+5)];
    headerView.backgroundColor = RED_COLOR;
    headerView.layer.cornerRadius = 5.0;
    [subView addSubview:headerView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,subView.frame.size.width,HEADERVIEWHEIGHT)];
    label.text = _pickerTitleText;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = WHITE_COLOR;
    label.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:label];
    
    //cancel
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0, 0, 60, HEADERVIEWHEIGHT);
    cancelButton.tag = -1;
    [headerView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventTouchUpInside];
    
    //done
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [_doneButton setBackgroundColor:[UIColor clearColor]];
    _doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_doneButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    _doneButton.frame = CGRectMake(headerView.frame.size.width - 60 , 0, 60, HEADERVIEWHEIGHT);
    _doneButton.tag = 250;
    [headerView addSubview:_doneButton];
    [_doneButton addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addSelectItemBarView:(UIView *)subView
{
    UIView *barSel = [[UIView alloc] initWithFrame:CGRectMake(0, BAR_SEL_ORIGIN_Y, subView.frame.size.width, ITEM_HEIGHT)];
    [barSel setBackgroundColor:RED_COLOR];
    [subView addSubview:barSel];
}

- (void)addPickerView:(UIView *)subView
{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, HEADERVIEWHEIGHT, subView.frame.size.width, PICKERVIEWHEIGHT + 10)];
    bottomView.backgroundColor = WHITE_COLOR;
    [subView addSubview:bottomView];
    
    //add highlight selected view
    [self addSelectItemBarView:bottomView];
    
    //add picker view
    [self.HNAPickerArray removeAllObjects];
    for (int i= 0 ; i < self.pickerDataArray.count; i++) {
        
        float pickerWidth = self.frame.size.width / _pickerDataArray.count;
        CGRect pickframe = CGRectMake(pickerWidth * i, 0, pickerWidth, PICKERVIEWHEIGHT);
        HNAPickerCollectionViewFlowLayout* lineLayout = [[HNAPickerCollectionViewFlowLayout alloc] init:CGSizeMake(pickerWidth, ITEM_HEIGHT)];
        HNAPickerCollectionView *viewController = [[HNAPickerCollectionView alloc]initWithFrame:pickframe collectionViewLayout:lineLayout];
        viewController.delegate = self;
        viewController.cellItemArray = self.pickerDataArray[i];
        viewController.tag = i;
        [bottomView addSubview:viewController];
        [self.HNAPickerArray addObject:viewController];
        [self setScrollViewContent];
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(pickframe.size.width*i, 0, 1.0, PICKERVIEWHEIGHT)];
            [line setBackgroundColor:LINE_COLOR];
            [bottomView addSubview:line];
        }
    }
    //Layer gradient
    [self addGradientLayer:bottomView];
}

- (void)addGradientLayer:(UIView *)subView
{
    CAGradientLayer *gradientLayerTop = [CAGradientLayer layer];
    gradientLayerTop.frame = CGRectMake(0.0, 0.0, subView.frame.size.width, PICKERVIEWHEIGHT/2.0);
    gradientLayerTop.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor, subView.backgroundColor.CGColor, nil];
    gradientLayerTop.startPoint = CGPointMake(0.0f, 0.7f);
    gradientLayerTop.endPoint = CGPointMake(0.0f, 0.0f);
    
    CAGradientLayer *gradientLayerBottom = [CAGradientLayer layer];
    gradientLayerBottom.frame = CGRectMake(0.0, PICKERVIEWHEIGHT/2.0, subView.frame.size.width, PICKERVIEWHEIGHT/2.0);
    gradientLayerBottom.colors = gradientLayerTop.colors;
    gradientLayerBottom.startPoint = CGPointMake(0.0f, 0.3f);
    gradientLayerBottom.endPoint = CGPointMake(0.0f, 1.0f);
    
    //Add gradients
    [subView.layer addSublayer:gradientLayerTop];
    [subView.layer addSublayer:gradientLayerBottom];
}

#pragma -mark- set scroll 

- (void)setContentScrollViewSelected:(HNAPickerCollectionView *)scrollView
{
    int pointNum = [scrollView.cellItemArray indexOfObject:_resultDataArray[scrollView.tag]];
    
    scrollView.selectedItemTag = pointNum;
    double contentY = pointNum * ITEM_HEIGHT - 2*ITEM_HEIGHT;
    [scrollView setContentOffset:CGPointMake(0, contentY)];
}

- (void)setScrollViewContent
{
    for (int i = 0 ; i < self.HNAPickerArray.count; i++) {
        HNAPickerCollectionView *pickerView = (HNAPickerCollectionView *)_HNAPickerArray[i];
        
        int pointNum = [pickerView.cellItemArray indexOfObject:_resultDataArray[pickerView.tag]];
        pickerView.selectedItemTag = pointNum;
        double contentY = pointNum * ITEM_HEIGHT - 2*ITEM_HEIGHT;
        [pickerView setContentOffset:CGPointMake(0, contentY)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [pickerView reloadData];
        });    }
    _doneButton.enabled = YES;
}

#pragma -mark- init picker date data

- (void)initPickerDateSource
{
    NSArray *arrayyear = [pickerDateScource getYears:_resultDataArray];
    [self.pickerDataArray addObject:arrayyear];
    NSArray *arraymonth = pickerDateScource.getMonths;
    [self.pickerDataArray addObject:arraymonth];
    NSArray *arrayday = [pickerDateScource getDaysInMonth:[NSDate new]];
    [self.pickerDataArray addObject:arrayday];
}

- (void)initItemDataSource:(NSArray *)dataArray
{
    self.pickerDataArray = [NSMutableArray arrayWithArray:dataArray];
    for (int i = 0; i< self.pickerDataArray.count; i++) {
        [_resultDataArray addObject:self.pickerDataArray[i][0]];
    }
}

- (void)setResultDataArrayValue
{
    for (int i = 0 ; i < self.HNAPickerArray.count; i++) {
        HNAPickerCollectionView *pickerView = (HNAPickerCollectionView *)self.HNAPickerArray[i];
        [_resultDataArray replaceObjectAtIndex:pickerView.tag withObject:pickerView.cellItemArray[pickerView.selectedItemTag]];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerValueForScrollView:(HNAPickerCollectionView *)scrollView];
    if (self.pickerType == PickertypeDate) {
        [self getDaysInYearAndMonth:(HNAPickerCollectionView *)scrollView];
    }
    _doneButton.enabled = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    HNAPickerCollectionView *cv = (HNAPickerCollectionView *)scrollView;
    [cv highlightCellWithIndexPathRow:-1];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _doneButton.enabled = NO;
}

- (void)centerValueForScrollView:(HNAPickerCollectionView *)scrollView {
    float offset = scrollView.contentOffset.y;
    offset += (scrollView.contentInset.top);
    NSInteger indexPathRow = (int)(offset/ITEM_HEIGHT);
    [scrollView highlightCellWithIndexPathRow:indexPathRow];
}

//According  year & month get days
- (void)getDaysInYearAndMonth:(HNAPickerCollectionView *)scrollView
{
    if (scrollView.tag != 2) {
        HNAPickerCollectionView *yearTableView = _HNAPickerArray[0];
        HNAPickerCollectionView *monthTableView = _HNAPickerArray[1];
        HNAPickerCollectionView *dayTableView = _HNAPickerArray[2];
        if (yearTableView.selectedItemTag<0 || monthTableView.selectedItemTag <0) {
            return;
        }
        if (yearTableView.selectedItemTag >= yearTableView.cellItemArray.count ) {
            yearTableView.selectedItemTag = yearTableView.cellItemArray.count - 1;
        }
        if (monthTableView.selectedItemTag >= monthTableView.cellItemArray.count ) {
            monthTableView.selectedItemTag = monthTableView.cellItemArray.count - 1;
        }
        int year = [yearTableView.cellItemArray[yearTableView.selectedItemTag] integerValue];
        int month = [monthTableView.cellItemArray[monthTableView.selectedItemTag] integerValue];
        NSArray *daysArray = [pickerDateScource getDaysInMonth:[pickerDateScource convertToDateDay:1 month:month year:year]];
        [_pickerDataArray replaceObjectAtIndex:2 withObject:daysArray];
        dayTableView.cellItemArray = daysArray;

        [dayTableView reloadData];
        if (dayTableView.selectedItemTag >= dayTableView.cellItemArray.count) {
            dayTableView.selectedItemTag = dayTableView.cellItemArray.count - 1;
        }
    }
}

#pragma -mark- button click event
-(void)dismissPickerView:(UIButton *)button
{
    if (self.block)
    {
        if (button == _doneButton ) {
            [self setResultDataArrayValue];
            self.block(_resultDataArray);
        }else
        {
            self.block(nil);
        }
    }
}

- (void)selectedDone:(SelectedDoneBlock)block
{
    self.block = [block copy];
}

@end
