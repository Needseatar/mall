//
//  goodInformationViewController.m
//  mall
//
//  Created by Mihua on 11/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//
/*
 *
 *当数据请求回来的时候会加载下面的购物栏
 */


#import "goodInformationViewController.h"

#define InformatonItemHeight 30  //商品栏高度
#define bgLineHeight         2   //黑线高度
#define redLineHeight        4   //红线高度
#define shopingHeight        45   //购物栏高度
#define timeButtonRedLine    200    //按钮按下时候红线移动的速度
#define timeButtonRedLinePi  25    //按钮按下时候红线移动的加速度 timeButtonRedLinePi>M_PI

@interface goodInformationViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView             *scr;
@property (retain, nonatomic) UITableView              *tableView;

@property (retain, nonatomic) UIView                   *bgSortView;
@property (retain, nonatomic) NSArray                  *InformatonItem;     //导航栏下面的商品信息

@property (retain, nonatomic) UIView                   *BGshopView; //购物栏背景视图

@property (retain, nonatomic) UIView                   *redLine; //商品栏下面的背景红线
@property (retain, nonatomic) UIView                   *bgLine;  //商品栏下面的背景黑线

@property (retain, nonatomic) dataCommodityInformation *data;  //视图数据
@property (retain, nonatomic) NSMutableArray           *dataStore;  //第二组 的店铺信息

@property (assign, nonatomic) NSInteger                sectionThir; //保存了第三组数据cell的高度
@property (assign, nonatomic) NSInteger                sectionFour;  //保存了第四组数据cell的高度

@property (retain, nonatomic) UIView                   *loadingiew; //加载加载视图
@property (retain, nonatomic) UIView                   *errorNetWork; //加载没有网络视图


@property (assign, nonatomic) NSInteger                shoppingCarNumber; //保存了更改后该商品的购买数量

@property (assign, nonatomic) double                   sinX; //保存了sin的角度 0=<sinX=<M_PI;


@end

@implementation goodInformationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self setValueInit];            //初始化数据
    
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;  //便签控制器隐藏
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.title = @"商品信息";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self monitorShoppingCarNumber]; //监听该商品需要购买多少 和 商品id是否已经变了
    
    [self requestCommodit];         //请求数据
    
    [self commodityInformatonItem];        //加载导航栏下面的商品标题
    
    [self setTabelViewAndScrollView]; //设置tabel和滚动视图
    
    [self setdownShopping];   //设置下面的物品加入购物车
    
    [self setLoadingView]; //加载加载视图
}

-(void)setValueInit
{
    self.sectionThir = 0;
    self.sectionFour = 0;
    
    self.sinX = 0;
}

-(void)monitorShoppingCarNumber
{
    self.shoppingCarNumber = 1; //默认选择的商品是一件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShoppingCarNumber:) name:@"ShoppingCarNumber" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeShoppingGoods_id:) name:@"ChangeShoppingGoods_id" object:nil];
}
- (void)changeShoppingCarNumber:(NSNotification *)notifica{
    
    self.shoppingCarNumber = [[notifica object] integerValue];
    NSLog(@"%@", [notifica object]);
}
- (void)ChangeShoppingGoods_id:(NSNotification *)notifica{
    
    self.goods_id = [[notifica object] integerValue];
    [self requestCommodit];         //请求数据
}
#pragma mark - 加载加载视图
-(void)setLoadingView
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height/2.0-40, 80, 80);
    self.loadingiew = [loadingImageView setLoadingImageView:fr];
    
    [self.view addSubview:self.loadingiew];
}

#pragma - mark 设置导航栏下面的商品信息栏
-(void)commodityInformatonItem
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.bgSortView = [[UIView alloc] initWithFrame:CGRectMake(0, Navigation+UpState, widthEx(320), InformatonItemHeight)];
    self.bgSortView.hidden = YES;
    [self.bgSortView setBackgroundColor:[UIColor colorWithRed:248.0/255.0f green:249.0/255.0f blue:250.0/255.0f alpha:1]];
    [self.view addSubview:self.bgSortView];
    
    self.InformatonItem = @[@"商品详情", @"图文详情", @"商品评论"];
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *sortBut = [[UIButton alloc] initWithFrame:CGRectMake(widthEx(i*320/(float)self.InformatonItem.count), 0, widthEx(320/(float)self.InformatonItem.count), InformatonItemHeight)];
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
            UIView *bgVerticalLine = [[UIView alloc] initWithFrame:CGRectMake(widthEx(i*320/(float)self.InformatonItem.count)-1, 5, 2, InformatonItemHeight-10)];
            bgVerticalLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
            [self.bgSortView addSubview:bgVerticalLine];
        }
    }
    
    //下面的背景横线
    self.bgLine = [[UIView alloc] initWithFrame:CGRectMake(0, UpState+Navigation+InformatonItemHeight, widthEx(320), bgLineHeight)];
    self.bgLine.hidden = YES;
    self.bgLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
    [self.view addSubview:self.bgLine];
    
    //加载背景横线上面的红色视图
    self.redLine = [[UIView alloc] initWithFrame:CGRectMake(0, UpState+Navigation+InformatonItemHeight-bgLineHeight, widthEx(320/(float)self.InformatonItem.count), redLineHeight)];
    self.redLine.backgroundColor = [UIColor redColor];
    self.redLine.hidden = YES;
    self.redLine.alpha = 0.4;
    [self.view addSubview:self.redLine];
}

-(void)buttonSetAction:(UIButton *)but{
    
    int index=0; //保存了点击之前but的下标
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *yesBut = [self.bgSortView viewWithTag:i+300];
        if (yesBut.selected == NO) {
            index = (int)(yesBut.tag-300);
        }
        yesBut.selected = YES;
    }
    
    but.selected = NO; //选择的哪一个button
    
    //设置scr的位置,会带动redLine的位置
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction:) userInfo:but repeats:YES];
}
#pragma mark - 控制滚动视图的位置
-(void)timerAction:(NSTimer *)time
{
    self.bgSortView.userInteractionEnabled = NO;
    self.scr.userInteractionEnabled = NO;
    
    //加速度
    if (self.sinX >= M_PI_2) {
        self.sinX = self.sinX+M_PI/(float)timeButtonRedLinePi;
    }else
    {
        self.sinX = self.sinX-M_PI/(float)timeButtonRedLinePi;
    }
    if (self.sinX<=0) {
        self.sinX = M_PI/(float)timeButtonRedLinePi;
    }
    if (self.sinX>=M_PI) {
        self.sinX = M_PI-M_PI/(float)timeButtonRedLinePi;
    }
    
    UIButton *but = [time userInfo];
    CGPoint contentOffsetPoint = self.scr.contentOffset;
    if ((self.scr.contentSize.height/3)*(but.tag-300)>contentOffsetPoint.y) {
        contentOffsetPoint.y = contentOffsetPoint.y+(double)timeButtonRedLine*self.sinX;
        self.scr.contentOffset = contentOffsetPoint;
        if ((int)self.scr.contentOffset.y >= (int)(self.scr.contentSize.height/3)*(but.tag-300))
        {
            contentOffsetPoint.y = (self.scr.contentSize.height/3)*(but.tag-300);
            self.scr.userInteractionEnabled = YES;
            self.bgSortView.userInteractionEnabled = YES;
            self.scr.contentOffset =contentOffsetPoint;
            [time invalidate];//停止时间执行此函数
            self.sinX=0;
        }
    }else
    {
        contentOffsetPoint.y = contentOffsetPoint.y-timeButtonRedLine*self.sinX;
        self.scr.contentOffset = contentOffsetPoint;
        if ((int)self.scr.contentOffset.y <= (int)(self.scr.contentSize.height/3)*(but.tag-300)) {
            contentOffsetPoint.y = (self.scr.contentSize.height/3)*(but.tag-300);
            self.scr.userInteractionEnabled = YES;
            self.bgSortView.userInteractionEnabled = YES;
            self.scr.contentOffset =contentOffsetPoint;
            [time invalidate];
            self.sinX=0;
        }
    }
}

#pragma mark - 请求商品详细信息
-(void)requestCommodit{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    NSLog(DetailedCommodity, (long)self.goods_id);
    [manager GET:[NSString stringWithFormat:DetailedCommodity, (long)self.goods_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        self.data = [dataCommodityInformation setValueWithDictionary:dict];
        
        //设置第二组 的店铺信息
        self.dataStore = [[NSMutableArray alloc] init];
        [self.dataStore addObject:@"图文详情"];
        [self.dataStore addObject:[NSString stringWithFormat:@"店铺:%@", [self.data.store_info store_name]]];
        
        [self.tableView reloadData];
        self.bgLine.hidden = NO;
        self.redLine.hidden = NO;
        self.tableView.hidden = NO;
        self.bgSortView.hidden = NO;
        self.BGshopView.hidden = NO;
        [self.loadingiew removeFromSuperview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self.loadingiew removeFromSuperview];
        [self.errorNetWork removeFromSuperview];
        CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
        self.errorNetWork = [loadingImageView setNetWorkError:fr];
        UIButton *but = [self.errorNetWork viewWithTag:7777];
        [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.errorNetWork];
    }];
}

-(void)buttonAction
{
    [self.errorNetWork removeFromSuperview];
    [self setLoadingView]; //加载加载视图
    [self requestCommodit];
}

#pragma mark - 加载tabel
-(void)setTabelViewAndScrollView
{
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, UpState+Navigation+InformatonItemHeight+bgLineHeight, widthEx(320), heightEx(568)-UpState-Navigation-InformatonItemHeight-bgLineHeight)];
    self.scr.contentSize = CGSizeMake(widthEx(320), 3*(heightEx(568)-UpState-Navigation-InformatonItemHeight-bgLineHeight));
    self.scr.delegate = self;
    self.scr.pagingEnabled = YES;
    self.scr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scr];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, widthEx(320), heightEx(568)-UpState-Navigation-InformatonItemHeight-bgLineHeight) style:UITableViewStyleGrouped];
    self.tableView.hidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.scr addSubview:_tableView];
    
    UIWebView *ImageTextView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 1*(heightEx(568)-UpState-Navigation-InformatonItemHeight-bgLineHeight), widthEx(320), (heightEx(568)-UpState-Navigation-InformatonItemHeight-bgLineHeight))];
    NSString *url = [NSString stringWithFormat:GoodsHtml, (long)self.goods_id];
    [ImageTextView setScalesPageToFit:YES]; //可以缩放
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    ImageTextView.delegate = self;
    [ImageTextView loadRequest:request];
    [self.scr addSubview:ImageTextView];
    
    
}
//设置ImageTextView尺寸
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //放大1.5倍
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom=1.5"];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) { //第一组
        return 1;
    }else if (section == 1)//第二组
    {
        return self.dataStore.count;
    }else if (section==2 || section==3) //第三组 或着 第四组
    {
        return 1;
    }else  //最后一组
    {
        return 1;
    }
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 90;
    }
    return 10;
}

#pragma mark - 返回cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) { //第一组滚动视图
        static NSString * cellId = @"cell";
        goodInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[goodInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setImage:self.data];
        return cell;
    }else if (indexPath.section == 1) //第二组
    {
        static NSString * cellId2 = @"cell2";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if(cell2 == nil){
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置右边箭头
        cell2.textLabel.text = @"";
        
        cell2.textLabel.text = self.dataStore[indexPath.row];

        return cell2;
    }else if (indexPath.section == 2) //第三组
    {
        static NSString * cellId3 = @"cell3";
        goodsInformationpaceTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
        if(cell3 == nil){
            cell3 = [[goodsInformationpaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
        }
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.accessoryType = UITableViewCellAccessoryNone;
        
        [cell3 setString:self.data];
        
        return cell3;
        
    }else if (indexPath.section == 3) //第四组
    {
        static NSString * cellId4 = @"cell4";
        goodsSpecificationsTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellId4];
        if(cell4 == nil){
            cell4 = [[goodsSpecificationsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId4];
        }
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell4.accessoryType = UITableViewCellAccessoryNone;
        
        [cell4 setString:self.data];
        
        return cell4;
    }
    
    static NSString * cellId5 = @"cell5";
    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellId5];
    if(cell5 == nil){
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId5];
    }
    cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    cell5.accessoryType = UITableViewCellAccessoryNone;
    
    cell5.textLabel.text = @"";
    
    return cell5;
}
#pragma mark - tabelView跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
#pragma mark - 返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {  //第一组
        //计算label高度
        CGRect frame = CGRectMakeEx(5, 0, 310, 0);
        secondGoodsInfo *GInfo = self.data.goods_info;
        frame.size.height = [self heightWithString:GInfo.goods_name width:widthEx(310) fontSize:18];
        return frame.size.height+heightEx(250)+10;
    }else if (indexPath.section == 1)//第二组
    {
        return heightEx(40);
    }else if (indexPath.section == 2) // 第三组
    {
        if (self.data != nil) {
            if (self.sectionThir == 0) { //因为只有一组cell，计算之后就不用算了
                //计算第三组label的高度，要更改需要到 PrefixHeader 更改
                NSInteger up;
                if ([[self.data.goods_info goods_jingle] length] == 0) {
                    up = 0;
                }else
                {
                    up = [self heightWithString:[self.data.goods_info goods_jingle] width:widthEx(bgWidth) fontSize:setFontSize]; //上面标题的高度
                }
                NSString *string = [NSString stringWithFormat:@"由%@负责发货,并提供售后服务", [self.data.store_info store_name]];
                NSInteger storeName = [self heightWithString:string width:widthEx(bgWidth-Service) fontSize:setFontSize]; //服务后面的发货商介绍视图
                NSInteger bg = heightEx(Pacebg); //价格的背景视图的高度
                self.sectionThir = up+storeName+bg+10;
            }
        }
        return self.sectionThir;
    }else if (indexPath.section == 3) //第四组，是设置商品的规格选择
    {
        if (self.data != nil) {
            if (self.sectionFour == 0) {
                //计算商品规格的背景视图
                NSInteger bgSpecifications =  0;//款式背景视图
                NSLog(@"%@", [self.data.goods_info spec_name]);
                if ([[self.data.goods_info spec_name] isKindOfClass:[NSDictionary class]]) {
                    for (NSDictionary *dic in [self.data.goods_info spec_name]) {
                        NSDictionary *dic2 = [self.data.goods_info spec_value];
                        NSDictionary *dicspecValue = dic2[dic]; //通过字典的key找到在[data.goods_info spec_value]里面的字典数量
                        int grouInt  = (int)dicspecValue.count/2;
                        float grouFl = dicspecValue.count/2.0;
                        if (grouFl > (float)grouInt) {
                            grouInt++;
                            if ((int)dicspecValue.count == 1) {
                                grouInt = 1;
                            }
                        }
                        bgSpecifications = bgSpecifications + grouInt*(SpecificationHeight+IntervalButton);
                        bgSpecifications = bgSpecifications+Interval;
                    }
                    NSInteger specifications = heightEx(30)+Interval; //库存视图
                    
                    NSInteger number = heightEx(5+30); //数量
                    
                    self.sectionFour = heightEx(bgSpecifications)+specifications+number+10;
                }else
                {
                    return heightEx(76)+10;
                }

            }
        }
        return self.sectionFour;
    }else
    {
        return heightEx(200);
    }
}
#pragma mark - 返回组尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *footView = [[UIView alloc] init];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
        textLabel.text = @"继续拖动,查看图文详情";
        textLabel.textAlignment = NSTextAlignmentCenter;
        [footView addSubview:textLabel];
        return footView;
    }else
    {
        return nil;
    }
}


#pragma mark - 设置加入购物车栏
-(void)setdownShopping
{
    NSArray *ar = @[@"关注", @"购物车", @"加入购物车"];
    
    //self.view.frame.size.height-shopingHeight
    self.BGshopView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height-shopingHeight, self.view.frame.size.width, shopingHeight)];
    self.BGshopView.hidden = YES;
    self.BGshopView.alpha = 1;
    UISwipeGestureRecognizer *gestture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(stopGestture)];
    [self.BGshopView addGestureRecognizer:gestture];
    [self.scr addSubview:self.BGshopView];
    
    for (int i=0; i<3; i++) {
        UIView *shopView = [[UIView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width/3.0f, 0, self.view.frame.size.width/3.0f, shopingHeight)];
        shopView.backgroundColor = [UIColor blackColor];
        shopView.alpha = 0.7;
        //加载label
        UILabel *shopLabel = [[UILabel alloc] init];
        shopLabel.textAlignment = NSTextAlignmentCenter;
        shopLabel.text = ar[i];
        shopLabel.textColor = [UIColor whiteColor];
        shopLabel.frame = CGRectMake(0, 25, widthEx(320/3.0f), shopingHeight-25);
        [shopView addSubview:shopLabel];
        if (i==2) {
            shopView.backgroundColor = [UIColor redColor];
            shopView.alpha = 1;
            shopLabel.frame = CGRectMake(0, 0, widthEx(320/3.0f), shopingHeight);
        }
        
        //加载image
        if (i==0) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthEx((320/3.0f)/2.0f-25/2.0f), 0, 25, 25)];
            [imageView setImage:[UIImage imageNamed:@"nearby_focus_off.png"]];
            [shopView addSubview:imageView];
        }
        if (i==1) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthEx((320/3.0f)/2.0f-25/2.0f), 0, 25, 25)];
            [imageView setImage:[UIImage imageNamed:@"main_bottom_tab_cart_normal.png"]];
            [shopView addSubview:imageView];
        }
        
        
        //加载动作
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOflabel:)];//加载点击动作
        [shopView addGestureRecognizer:tapAction];
        shopLabel.userInteractionEnabled = YES;
        shopView.tag = 600+i;
        [self.BGshopView addSubview:shopView];
    }
}
-(void)stopGestture
{
    ;
}
-(void)tapActionOflabel:(UITapGestureRecognizer *)tapAction
{
    switch (tapAction.view.tag-600) {
        case 0:
        {
            break;
        }
        case 1:
        {
            signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
            if (signIn.whetherSignIn == YES) {
                //跳回根视图
                [self.navigationController popToRootViewControllerAnimated:NO];
                //跳转到购物车
                tabelBarID *TB = [tabelBarID shareTabbarID:nil];
                TB.tabbarControl.selectedIndex = 3;
                break;
            }else
            {
                if (self.errorNetWork==nil) {
                    self.errorNetWork = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"请登录"];
                    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                    [self.view addSubview:self.errorNetWork];
                }
            }
        }
        case 2:
        {
            [self postAddShopingCar];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 加入购物车Post
-(void)postAddShopingCar{
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         [NSString stringWithFormat:@"%ld", (long)self.goods_id], @"goods_id",
         [NSString stringWithFormat:@"%ld", (long)self.shoppingCarNumber], @"quantity",
         nil];
        [manager POST:AddShopingCar parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            NSString *str = [NSString stringWithFormat:@"%@", dict[@"datas"]];
            if ([str integerValue]==1) {
                if (self.errorNetWork==nil) {
                    self.errorNetWork = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"已加入购物车"];
                    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                    [self.view addSubview:self.errorNetWork];
                }
            }else
            {
                if (self.errorNetWork==nil) {
                    NSDictionary *dicError = dict[@"datas"];
                    NSString *str = [NSString stringWithFormat:@"%@", dicError[@"error"]];
                    self.errorNetWork = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:str];
                    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                    [self.view addSubview:self.errorNetWork];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else
    {
        if (self.errorNetWork==nil) {
            self.errorNetWork = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"请登录"];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
            [self.view addSubview:self.errorNetWork];
        }
    }
}
-(void)setStoplabel
{
    [self.errorNetWork removeFromSuperview];
    self.errorNetWork = nil;
}

#pragma mark - 计算label高度
-(CGFloat)heightWithString:(NSString *)string width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return rect.size.height;
}
//滚动视图控制redLine
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffsetPoint = scrollView.contentOffset;
    if (self.scr == scrollView) {
        NSLog(@"%f", contentOffsetPoint.y);
        float redLineX = self.view.frame.size.width/(float)(self.scr.contentSize.height/(float)contentOffsetPoint.y);
        CGRect fram = self.redLine.frame;
        fram.origin.x = redLineX;
        self.redLine.frame = fram;
    }
}
//当滚动视图停止时执行
#pragma mark - 滚动视图停止时控制redLine
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scr == scrollView) {
        CGPoint contentOffsetPoint = scrollView.contentOffset;
        int j=0;
        for (int i=0; i<3; i++) {
            if ((int)contentOffsetPoint.y==(int)((self.scr.contentSize.height/3)*i)) {
                j=i;
                break;
            }
        }
        for (int i=0; i<3; i++) {
            UIButton *but = [self.bgSortView viewWithTag:i+300];
            but.selected = YES;
        }
        UIButton *but1 = [self.bgSortView viewWithTag:j+300];
        but1.selected = NO;
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
