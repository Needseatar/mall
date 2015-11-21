//
//  fiveViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "fiveViewController.h"

@interface fiveViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *mArray;

@end

@implementation fiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self setTabelView];  //设置tabel
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark -  初始化参数
-(void)setData
{
    NSArray *array1 = @[@"个人账户"];
    NSArray *array2 = @[@"我的订单", @"虚拟订单"];
    NSArray *array3 = @[@"我的代金劵", @"收藏的店铺"];
    NSArray *array4 = @[@"系统消息", @"版本更新"];
    NSArray *array5 = @[@"建议反馈", @"关于"];
    
    _mArray = [[NSMutableArray alloc] init];
    [_mArray addObject:array1];
    [_mArray addObject:array2];
    [_mArray addObject:array3];
    [_mArray addObject:array4];
    [_mArray addObject:array5];
}

#pragma mark - 设置TabelView界面
-(void)setTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 -44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_mArray[section] count];
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mArray.count;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //用户登陆界面
    if (indexPath.section == 0) {
        static NSString * cellId1 = @"cell1";
        fiveViewUserTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if(cell1 == nil){
            cell1 = [[fiveViewUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    }else // 其它信息
    {
        static NSString * cellId = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置右边箭头
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array = _mArray[indexPath.section];
        
        cell.textLabel.text = array[indexPath.row];
        
        return cell;
    }
    
}
//跳转到介绍
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4 && indexPath.row == 1) {  //进入关于的界面
        fiveAboutViewController *FAV = [[fiveAboutViewController alloc] init];
        [self.navigationController popToViewController:FAV animated:YES];
    }else
    {
        fiveAboutViewController * FAView = [[fiveAboutViewController alloc] init];
        [self.navigationController pushViewController:FAView animated:YES];
    }
    
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return heightEx(130);
    }else
    {
        return widthEx(35);
    }
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
//返回组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else
    {
        return heightEx(10);
    }
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

@end
