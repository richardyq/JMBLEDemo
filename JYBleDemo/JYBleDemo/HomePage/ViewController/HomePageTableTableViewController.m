//
//  HomePageTableTableViewController.m
//  JYBleDemo
//
//  Created by yinquan on 17/4/18.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HomePageTableTableViewController.h"
#import "FSRKBodyTemperatureViewController.h"
#import "YuwellBloodPressureViewController.h"
#import "HoltekBodyWeightViewController.h"

@interface HomePageTableTableViewController ()

@end

typedef NS_ENUM(NSUInteger, BlueToothDevice) {
    FSRK_BodyTemperature,
    Holtek_BodyWeight,
    Yuwell_BloodPressure,
    BlueToothDeviceCount,
};

@implementation HomePageTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"首页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) cellTitle:(NSInteger) row
{
    NSString* cellTitle = @"蓝牙设备";
    switch (row)
    {
        case FSRK_BodyTemperature:
        {
            cellTitle = @"飞思瑞克蓝牙耳温枪";
            break;
        }
        case Holtek_BodyWeight:
        {
            cellTitle = @"Hotlek体脂称";
            break;
        }
        case Yuwell_BloodPressure:
        {
            cellTitle = @"鱼跃血压计";
            break;
        }
    }
    return cellTitle;
}

#pragma mark - Table view data source
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return BlueToothDeviceCount;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BlueToothDeviceTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BlueToothDeviceTableViewCell"];;
    }
    NSString* cellTitle = [self cellTitle:indexPath.row];
    [cell.textLabel setText:cellTitle];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case FSRK_BodyTemperature:
        {
            //飞斯瑞克体温计
            FSRKBodyTemperatureViewController* detectViewController = [[FSRKBodyTemperatureViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:detectViewController animated:YES];
            break;
        }
        case Holtek_BodyWeight:
        {
            HoltekBodyWeightViewController* detectViewController = [[HoltekBodyWeightViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:detectViewController animated:YES];
            break;
        }
        case Yuwell_BloodPressure:
        {
            //鱼跃血压计
            YuwellBloodPressureViewController* detectViewController =[[YuwellBloodPressureViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:detectViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
