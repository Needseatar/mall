//
//  merchantShopViewController.m
//  mall
//
//  Created by Mihua on 5/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "merchantShopViewController.h"

@interface merchantShopViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray    *dataArray;
@property (assign, nonatomic) NSInteger         curpage; //当前页码
@property (retain, nonatomic) UITableView       *merchantTabel;
@property (assign, nonatomic) BOOL              hasmore;

@property (retain, nonatomic) UIView            *loadingiew; //加载加载视图
@property (retain, nonatomic) UIView            *errorNetWork; //加载没有网络视图
@property (retain, nonatomic) UILabel           *errorRefresh; //刷新失败视图

@end

@implementation merchantShopViewController


-(void)viewWillAppear:(BOOL)animated
{
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden =  YES;
    self.tabBarController.tabBar.hidden = YES;  //便签控制器隐藏
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始数据
    self.curpage = 1;
    self.hasmore = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabel];   //加载tabel
    
    [self setLoadingView]; //加载加载视图
    
    [self requestMerchantShop]; // 请求数据
    
    
}

#pragma mark - 全部商家信息
-(void)requestMerchantShop{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:MerchantShop, self.merchant, [NSString stringWithFormat:@"&curpage=%ld", (long)self.curpage]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        if (self.hasmore == NO) {
            if (self.curpage==1 || self.dataArray.count==0) {
                self.dataArray = [merchantModel setValueWithDictionary:dict];
                if (self.dataArray.count == 0 ) { //网上没有数据
                    ;
                }
            }else
            {
                NSArray *array = [merchantModel setValueWithDictionary:dict];
                for (int i=0; i<array.count; i++) {
                    [self.dataArray addObject:array[i]];
                }
            }
        }else //没有更多的数据的时候
        {
            if (self.errorRefresh==nil) {
                self.errorRefresh = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"没有更多的数据了"];
                [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                [self.view addSubview:self.errorRefresh];
            }
        }
        if ([dict[@"hasmore"] integerValue] == 0) {
            self.hasmore = YES; //没有更多的数据了
        }else
        {
            self.hasmore = NO;
        }
        [self.merchantTabel reloadData];
        [self.merchantTabel.mj_header endRefreshing];
        [self.merchantTabel.mj_footer endRefreshing];
        [self.loadingiew removeFromSuperview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (self.dataArray.count == 0) {
            [self.loadingiew removeFromSuperview];
            [self.merchantTabel.mj_header endRefreshing];
            [self.merchantTabel.mj_footer endRefreshing];
            CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
            self.errorNetWork = [loadingImageView setNetWorkError:fr];
            UIButton *but = [self.errorNetWork viewWithTag:7777];
            [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.errorNetWork];
        }else //刷新失败
        {
            [self.loadingiew removeFromSuperview];
            [self.merchantTabel.mj_header endRefreshing];
            [self.merchantTabel.mj_footer endRefreshing];
            if (self.errorRefresh==nil) {
                self.errorRefresh = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"刷新失败"];
                [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                [self.view addSubview:self.errorRefresh];
            }
        }
        
    }];
}

-(void)setStoplabel
{
    [self.errorRefresh removeFromSuperview];
    self.errorRefresh = nil;
}

-(void)buttonAction
{
    [self.errorNetWork removeFromSuperview];
    [self setLoadingView]; //加载加载视图
    [self requestMerchantShop];
}


#pragma mark - 加载加载视图
-(void)setLoadingView
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height/2.0-40, 80, 80);
    self.loadingiew = [loadingImageView setLoadingImageView:fr];
    
    [self.view addSubview:self.loadingiew];
}


#pragma mark - 设置TabelView界面
-(void)setTabel
{
    self.merchantTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+TabBar) style:UITableViewStylePlain];
    self.merchantTabel.delegate = self;
    self.merchantTabel.dataSource = self;
    [self.view addSubview:self.merchantTabel];
    
    //设置下拉菜单
    self.merchantTabel.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        self.hasmore = NO;
        _curpage = 1;
        [self requestMerchantShop];
    }];
    
    //加载上拉菜单
    self.merchantTabel.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _curpage++;
        [self requestMerchantShop];
    }];
    
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色

    
    cell.textLabel.text = [self.dataArray[indexPath.row] store_name];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    cell.detailTextLabel.text = [self.dataArray[indexPath.row] store_address];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
    
    return cell;
    
}
//跳转到商家
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
