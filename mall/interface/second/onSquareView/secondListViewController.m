//
//  secondListViewController.m
//  mall
//
//  Created by Mihua on 9/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondListViewController.h"

@interface secondListViewController ()<UITableViewDelegate, UITableViewDataSource>

typedef enum {
    //以下是枚举成员
    upSelected = 1,
    downSelected = 2,
    noSelected = 0
}upDownSelected; // 保存了价格后面的那一张图片

@property (retain, nonatomic) UITableView       *tableView;

@property (retain, nonatomic) UIView         *bgSortView;
@property (retain, nonatomic) NSArray        *sortItem;     //排序导航栏下面的排序标题
@property (assign, nonatomic) upDownSelected  UDSelec;

@property (assign, nonatomic) NSString        *key;    ///排序方式 1-销量 2-浏览量 3-价格 空-按最新发布排序
@property (assign, nonatomic) NSInteger       order; //排序方式 1-升序 2-降序
@property (assign, nonatomic) NSInteger       page;   // 每页数量
@property (assign, nonatomic) NSInteger       curpage;  //当前页码

@property (retain, nonatomic) NSArray         *arrayData;


@end

@implementation secondListViewController

-(void)viewWillAppear:(BOOL)animated
{
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;  //便签控制器不隐藏
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setWebRequestData];  //初始化数据
    
    [self requestClassification]; //请求数据
    
    [self createSort];   //设置导航栏下面的商品排序
    
    [self setTabelView];  //加载tabel
    
}

-(void)setWebRequestData
{
    self.key = @"&key=1";
    self.order = 1;
    self.page = 10;
    self.curpage = 1;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)createSort
{
    self.bgSortView = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 64, 320, 30)];
    [self.bgSortView setBackgroundColor:[UIColor colorWithRed:248.0/255.0f green:249.0/255.0f blue:250.0/255.0f alpha:1]];
    [self.view addSubview:self.bgSortView];
    
    self.sortItem = @[@"新品", @"销量", @"价格", @"人气"];
    for (int i=0; i<self.sortItem.count; i++) {
        UIButton *sortBut = [[UIButton alloc] initWithFrame:CGRectMakeEx(i*320/self.sortItem.count, 0, 320/self.sortItem.count, 30)];
        if (i==1) {
            sortBut.selected = YES;
        }else
        {
            sortBut.selected = NO;
        }
        [sortBut setTitle:self.sortItem[i] forState:UIControlStateNormal];
        [sortBut setTitle:self.sortItem[i] forState:UIControlStateSelected];
        [sortBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sortBut setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        sortBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        sortBut.tag = i+180;
        [sortBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 2) {  //加载价格后面的图标
            UIImageView *upDownImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx((i+1)*320/self.sortItem.count - 20, 10, 10, 10)];//coupon_double_arrow_pressed2.png
            self.UDSelec = noSelected;
            [upDownImage setImage:[UIImage imageNamed:@"coupon_double_arrow_normal.png"]];
            upDownImage.tag = 2000;
            [self.bgSortView addSubview:upDownImage];
        }
        [self.bgSortView addSubview:sortBut];
    }
}
-(void)buttonAction:(UIButton *)but
{
    UIImageView *upDownImage = (UIImageView *)[self.bgSortView viewWithTag:2000];
    //设置but选中时候的状态和其它but没有选中的状态
    for (int i=0; i<self.sortItem.count; i++) {
        UIButton *sectBut = (UIButton *)[self.bgSortView viewWithTag:i+180];
        if (but.tag == i+180) { //如果是选中的按钮，就是yes
            if (i==2) {
                if (self.UDSelec != upSelected) {
                    [upDownImage setImage:[UIImage imageNamed:@"coupon_double_arrow_pressed2.png"]];
                    self.UDSelec = upSelected;
                    but.selected = YES;
                    self.key = @"&key=3";
                    self.order = 1;
                    self.page = 10;
                    self.curpage = 1;
                    [self requestClassification];
                }else
                {
                    [upDownImage setImage:[UIImage imageNamed:@"coupon_double_arrow_pressed1.png"]];
                    self.UDSelec = downSelected;
                    but.selected = YES;
                    self.key = @"&key=3";
                    self.order = 2;
                    self.page = 10;
                    self.curpage = 1;
                    [self requestClassification];
                }
            }else
            {
                switch (i) {
                    case 0:
                    {
                        self.key = @"";
                        self.order = 1;
                        self.page = 10;
                        self.curpage = 1;
                        [self requestClassification];
                        break;
                    }
                    case 1:
                    {
                        self.key = @"&key=3";
                        self.order = 1;
                        self.page = 10;
                        self.curpage = 1;
                        [self requestClassification];
                        break;
                    }
                    case 3:
                    {
                        self.key = @"&key=2";
                        self.order = 1;
                        self.page = 10;
                        self.curpage = 1;
                        [self requestClassification];
                        break;
                    }
                    default:
                        break;
                }
                but.selected = YES;
                [upDownImage setImage:[UIImage imageNamed:@"coupon_double_arrow_normal.png"]];
                self.UDSelec = noSelected;
            }
        }else //否则no
        {
            sectBut.selected = NO;
        }
    }
}

#pragma mark - 商品列表数据
-(void)requestClassification
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:SecondListRequest, self.key, self.order, self.page, self.curpage, self.gc_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        self.arrayData = [commodityList setValueWithDictionary:dict];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 94, 320, 474) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor redColor]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; //设置tabel没有的cell不显示出来
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

#pragma mark - 返回cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //初始化一级数据的cell
    static NSString * cellId = @"cell1";
    secondListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[secondListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTextImage:self.arrayData[indexPath.row]];
    return cell;
}
#pragma mark - tabel跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    goodInformationViewController *GInformation = [[goodInformationViewController alloc] init];
    commodityList *comList= self.arrayData[indexPath.row];
    GInformation.goods_id = [comList.goods_id integerValue];
    [self.navigationController pushViewController:GInformation animated:YES];
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightEx(110);
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
