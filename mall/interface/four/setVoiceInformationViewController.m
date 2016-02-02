//
//  setVoiceInformationViewController.m
//  mall
//
//  Created by Mihua on 23/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "setVoiceInformationViewController.h"

@interface setVoiceInformationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *tabelView;
@property (retain, nonatomic) NSArray     *data;

@end

@implementation setVoiceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发票";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self requestVoiceList];
    
    [self settabelView];
}

#pragma mark - 设置tabel
-(void)settabelView
{
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    //self.tabelView.hidden = YES;
    [self.view addSubview:self.tabelView];
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.data.count;
    }else
    {
        return 1;
    }
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) { //发票列表
        static NSString * cellId = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        
        cell.textLabel.text = [self.data[indexPath.row] inv_title];
        cell.detailTextLabel.text = [self.data[indexPath.row] inv_content];
        
        return cell;
    }else  //添加发票
    {
        static NSString * cellId = @"cell1";
        AddVoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[AddVoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        
        return cell;
    }
    
}
//跳回订单
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }
    return 300;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 20;
    }else
    {
        return 0.01;
    }
    
}

#pragma mark - 请求发票列表
-(void)requestVoiceList{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *voiceListRequest =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",nil];
        [manager POST:voiceListPost parameters:voiceListRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            self.data = [voiceListModel setValueWithDictionary:dict];
            
            [self.tabelView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
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
