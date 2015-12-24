//
//  fisterViewController.m
//  mall
//
//  Created by Mihua on 19/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterViewController.h"

@interface fisterViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) UITableView       *tableView;
@property (retain, nonatomic) fisterData        *fisterData;
@property (retain, nonatomic) NSMutableArray    *listData; //保存了goodslist的数据，每两个fisterList为一组，listData保存 了多组数据

@end

@implementation fisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self createSearchBar]; //设置导航栏
    
    [self requestFisterView];
    
    [self setTabelView];  //设置tabel
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.translucent = NO;
    //UIRectEdgeAll的时候会让tableView从导航栏下移44px，设置为UIRectEdgeNone的时候，刚刚在导航栏下面。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(65, 7, 200, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //左边logo
    UIButton * leftLogo = [UIButton buttonWithType:UIButtonTypeCustom];
    leftLogo.frame = CGRectMakeEx(0, 0, 40,20);
    [leftLogo setImage:[UIImage imageNamed:@"home_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftLogoItem = [[UIBarButtonItem alloc] initWithCustomView:leftLogo];
    self.navigationItem.leftBarButtonItem = leftLogoItem;
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeEx(0, 0, 20,20);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;

}

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 0, 320, 455) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return self.fisterData.FHome.count;
    }else
    {
        return self.listData.count;
    }
    
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellId = @"cell";
        fisterBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[fisterBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if(indexPath.section == 1)
    {
        //判断数组里面的类是不是fisterHome1类
        if ([self.fisterData.FHome[indexPath.row] isKindOfClass:[fisterHome1 class]]) {  //home1 样式
            static NSString * cellId2 = @"cell2";
            fisterHome1TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
            if(cell2 == nil){
                cell2 = [[fisterHome1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor whiteColor];
            
            [cell2 setTextAndImage:self.fisterData.FHome[indexPath.row]];
            return cell2;
        }else        //home4样式
        {
            static NSString * cellId3 = @"cell3";
            fisterHome4TableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
            if(cell3 == nil){
                cell3 = [[fisterHome4TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            cell3.backgroundColor = [UIColor whiteColor];
            
            [cell3 setTextAndImage:self.fisterData.FHome[indexPath.row]];
            
            return cell3;
        }
        
    }else
    {
        static NSString * cellId4 = @"cell4";
        fisterListerTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellId4];
        if(cell4 == nil){
            cell4 = [[fisterListerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId4];
            cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell4.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        
       [cell4 setTextAndImage:self.listData[indexPath.row]];
        return cell4;
    }

}
#pragma mark - 跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return widthEx(150);
    }else if (indexPath.section == 1)
    {
        if ([self.fisterData.FHome[indexPath.row] isKindOfClass:[fisterHome1 class]]) {
            fisterHome1 *FHome1 = self.fisterData.FHome[indexPath.row];
            if ([FHome1.title length] == 0) { //home1 没有标题的高度
                return widthEx(153);
            }else
            {
                return widthEx(183);
            }
        }else  //home4 类的高度
        {
            return widthEx(153);
        }
        
    }else
    {
        return widthEx(230);
    }
}


#pragma mark - 请求首页数据
-(void)requestFisterView
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:fisterRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        self.fisterData = [fisterData setValueWithDictionary:dict];
        
        self.listData = [[NSMutableArray alloc] init];
        int h=0;
        NSMutableArray *twoListArray;
        for (int i=0; i<self.fisterData.FList.count; i++) {
            //将完整的数据打包成每两个一组
            if (h==1) {
                [twoListArray addObject:self.fisterData.FList[i]];
                h=0;
                [self.listData addObject:twoListArray];
                continue;
            }else
            {
                twoListArray = [[NSMutableArray alloc] init];
                [twoListArray addObject:self.fisterData.FList[i]];
                h++;
            }
        }
        if (h==0) { //当是最后一个是单个的时候
            [self.listData addObject:twoListArray];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(requestFisterView) userInfo:nil repeats:YES];
    }];
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
