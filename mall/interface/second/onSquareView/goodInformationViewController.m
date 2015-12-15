//
//  goodInformationViewController.m
//  mall
//
//  Created by Mihua on 11/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodInformationViewController.h"

@interface goodInformationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView              *tableView;

@property (retain, nonatomic) UIView                   *bgSortView;
@property (retain, nonatomic) NSArray                  *InformatonItem;     //排序导航栏下面的排序标题

@property (retain, nonatomic) UIView                   *redLine;

@property (retain, nonatomic) dataCommodityInformation *data;

@end

@implementation goodInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestCommodit];         //请求数据
    
    [self commodityInformatonItem];        //加载导航栏下面的商品标题
    
    [self setTabelView];
}


-(void)commodityInformatonItem
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.bgSortView = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 64, 320, 30)];
    [self.bgSortView setBackgroundColor:[UIColor colorWithRed:248.0/255.0f green:249.0/255.0f blue:250.0/255.0f alpha:1]];
    [self.view addSubview:self.bgSortView];
    
    self.InformatonItem = @[@"商品详情", @"图文详情", @"商品评论"];
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *sortBut = [[UIButton alloc] initWithFrame:CGRectMakeEx(i*320/self.InformatonItem.count, 0, 320/self.InformatonItem.count, 30)];
        if (i==0) {
            sortBut.selected = NO;
        }else
        {
            sortBut.selected = YES;
        }
        [sortBut setTitle:self.InformatonItem[i] forState:UIControlStateNormal];
        [sortBut setTitle:self.InformatonItem[i] forState:UIControlStateSelected];
        [sortBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sortBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        sortBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        sortBut.tag = i+300;
        [sortBut addTarget:self action:@selector(buttonSetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgSortView addSubview:sortBut];
        
        if (i!=0 || i!=self.InformatonItem.count) {
            //中间的两条线
            UIView *bgVerticalLine = [[UIView alloc] initWithFrame:CGRectMakeEx(i*320/self.InformatonItem.count-1, 5, 2, 20)];
            bgVerticalLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
            [self.bgSortView addSubview:bgVerticalLine];
        }
    }
    
    //下面的背景横线
    UIView *bgLine = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 94, 320, 2)];
    bgLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
    [self.view addSubview:bgLine];
    
    //加载背景横线上面的红色视图
    self.redLine = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 92, 320/self.InformatonItem.count, 4)];
    self.redLine.backgroundColor = [UIColor redColor];
    self.redLine.alpha = 0.4;
    [self.view addSubview:self.redLine];
}

-(void)buttonSetAction:(UIButton *)but{
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *yesBut = [self.bgSortView viewWithTag:i+300];
        yesBut.selected = YES;
    }
    
    but.selected = NO; //选择的哪一个button
    
    //平移动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    // 动画持续1秒
    anim.duration =0.1;
    anim.removedOnCompletion=NO;
    //因为CGPoint是结构体，所以用NSValue包装成一个OC对象
    anim.fromValue = [NSValue valueWithCGPoint:self.redLine.frame.origin];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(widthEx((but.tag-300)*320/self.InformatonItem.count), heightEx(92))];
    anim.delegate = self;
    //通过MyAnim可以取回相应的动画对象，比如用来中途取消动画
    [self.redLine.layer addAnimation:anim forKey:@"MyAnim"];
}

#pragma mark - anim返回动画结束的代理
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *but = [self.bgSortView viewWithTag:i+300];
        if (but.selected == NO) {
            self.redLine.frame = CGRectMakeEx((but.tag-300)*320/self.InformatonItem.count, 92, 320/self.InformatonItem.count, 4);
        }
    }
}

#pragma mark - 请求商品详细信息
-(void)requestCommodit{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:DetailedCommodity, self.goods_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        self.data = [dataCommodityInformation setValueWithDictionary:dict];
        secondCommendList *ddd = self.data.goods_commend_list[0];
        NSLog(@"%@", ddd.goods_image_url);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 96, 320, 472) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor blackColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else
    {
        return 10;
    }
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

#pragma mark - 返回cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) { //第一组滚动视图
        //初始化一级数据的cell
        static NSString * cellId = @"cell";
        goodInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[goodInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setImage:self.data];
        return cell;
    }else
    {
        //初始化一级数据的cell
        static NSString * cellId2 = @"cell2";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if(cell2 == nil){
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell2;
    }
}
#pragma mark - 一级数据tabelView跳转到指定滚动视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return heightEx(250);
    }
    return heightEx(100);
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
