//
//  ViewController.m
//  worktime
//
//  Created by 武淅 段 on 16/9/20.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (nonatomic) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger index;  //参照时间的 后夜的序号 1
@property (nonatomic) NSDate *normalDate;   //参照时间  2016-09-19
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _items = @[@"一值", @"二值", @"三值", @"四值", @"五值"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _normalDate = [formatter dateFromString:@"2016-09-19 01:00:24"];
    _index = 1;
    [self updateTextWithDate:_datePicker.date];
}


- (IBAction)dateChange:(UIDatePicker *)sender {
    
    NSDate *date = sender.date;
    [self updateTextWithDate:date];
}

- (void) updateTextWithDate : (NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日  EEEE"];
    NSString *dateStr = [formatter stringFromDate:date];
    //    [_content setText:dateStr];
    
    //计算相差天数
    NSInteger day = [date timeIntervalSinceDate:_normalDate]/(3600*24);
    if(day < 0){
        day = day + (labs(day)/_items.count+1)*_items.count;
    }
    NSUInteger index1 = (day+_index)%(_items.count);
//    NSLog(@"index1--%ld, %d, %d", index1, (-1%5), (-2%5));
    NSInteger index2 = (index1+1)%(_items.count);
    NSInteger index3 = (index2+1)%(_items.count);
    NSString *work = [NSString stringWithFormat:@"%@后夜  %@白班  %@前夜", _items[index1], _items[index2], _items[index3]];
    NSString *show = [NSString stringWithFormat:@"%@\n%@", dateStr, work];
    [_content setText:show];
}
@end
