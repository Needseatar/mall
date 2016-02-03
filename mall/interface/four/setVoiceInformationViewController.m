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
@property (retain, nonatomic) UIView      *bgVoiceView;
@property (retain, nonatomic) UITableView *voiceInformationTabelView;
@property (retain, nonatomic) NSMutableArray     *data;
@property (retain, nonatomic) NSArray     *voiceInformation;
@property (retain, nonatomic) NSString    *voiceTitleDetailsString;

@end

@implementation setVoiceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发票";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.voiceTitleDetailsString = @"";
    
    [self requestVoiceList]; //请求发票列表
    
    [self requsetVoiceInformation];//请求发票选择的内容
    
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
    
    self.bgVoiceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgVoiceView.hidden = YES;
    self.bgVoiceView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bgVoiceView];
    
    self.voiceInformationTabelView = [[UITableView alloc] initWithFrame:CGRectMake(self.bgVoiceView.frame.size.width/2.0-200/2.0, self.bgVoiceView.frame.size.height/2.0-350/2.0, 200, 350) style:UITableViewStylePlain];
    self.voiceInformationTabelView.delegate = self;
    self.voiceInformationTabelView.dataSource = self;
    [self.bgVoiceView addSubview:self.voiceInformationTabelView];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    //如果需要带参数只能将该通知作为参数携带过去
    [center addObserver:self selector:@selector(notice) name:@"voiceListAction" object:nil];
    [center addObserver:self selector:@selector(VoiceSaveOrGiveUp:) name:@"SaveOrGiveUpVoice" object:nil];
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tabelView)
    {
        if (section==0) {
            return self.data.count;
        }else
        {
            return 1;
        }
    }else
    {
        return self.voiceInformation.count;
    }

}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tabelView)
    {
        return 2;
    }else
    {
        return 1;
    }
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tabelView) {
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
            cell.voiceTitleDetails.text = self.voiceTitleDetailsString;
            
            return cell;
        }
    }else //发票选择内容的tabel
    {
        static NSString * cellId = @"cell2";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        cell.textLabel.text = self.voiceInformation[indexPath.row];
        
        return cell;
    }
    
}
#pragma mark - 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tabelView) {
        ;
    }else
    {
        self.voiceTitleDetailsString = self.voiceInformation[indexPath.row];
        [self.tabelView reloadData];
        self.bgVoiceView.hidden = YES;
    }
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tabelView) {
        if (indexPath.section==0) {
            return 50;
        }
        return 300;
    }else
    {
        return 30;
    }
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tabelView) {
        if (section==1) {
            return 20;
        }else
        {
            return 0.01;
        }
    }else
    {
        return 0.01;
    }
}
#pragma mark - 编辑删除table
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelView)
    {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
}

#pragma mark 在滑动手势删除某一行的时候，显示按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelView)
    {
        // 添加一个删除按钮
        if (indexPath.section == 0) {
            UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                NSLog(@"点击了删除");
                signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
                if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
                    
                    NSDictionary *deleteVoiceList =
                    [NSDictionary dictionaryWithObjectsAndKeys:
                     signIn.key, @"key",
                     [self.data[indexPath.row] inv_id], @"inv_id", nil];
                    [manager POST:delectvoiceListPost parameters:deleteVoiceList success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"JSON: %@", dict);
                        
                        if ([dict[@"datas"] isEqualToString:@"1"]) {
                            [self.data removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
                            [self.tabelView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];  //删除对应的组数
                        }
                        
                    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                        
                        NSLog(@"Error: %@", error);
                    }];
                }else //没有令牌，也就是没有登录
                {
                    ;
                }
            }];
            // 将设置好的按钮放到数组中返回
            return @[deleteRowAction];
            
        }else
        {
            return nil;
        }
    }else
    {
        return nil;
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

#pragma mark - 请求发票的内容
-(void)requsetVoiceInformation
{
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *VoiceListInformation =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",nil];
        [manager POST:voiceListInformationPost parameters:VoiceListInformation success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            NSDictionary *VoiceList = dict[@"datas"];
            self.voiceInformation = VoiceList[@"invoice_content_list"];
            if (self.voiceInformation.count>0) {
                self.voiceTitleDetailsString = self.voiceInformation[0];
            }
            
            [self.tabelView reloadData];
            [self.voiceInformationTabelView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
    }
}
#pragma mark - 设置发票内容
-(void)notice
{
     self.bgVoiceView.hidden = NO;
}
#pragma mark - 保存或者放弃发票
-(void)VoiceSaveOrGiveUp:(NSNotification *)notification
{
    if ([[notification object] isEqualToString:@"Save"]) {
        ;
    }else
    {
        [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
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
