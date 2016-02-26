//
//  addSelectTabel.m
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addSelectTabel.h"

@interface addSelectTabel ()

@end

@implementation addSelectTabel

////初始化uiview中有view这个视图
//+(UITableView *)SetSelectTableView:(NSArray *)cellString tabelFram:(CGRect )fr
//{
//    UITableView *tabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, fr.size.width, fr.size.height-1) style:UITableViewStylePlain];
//    tabel.delegate = self;
//    tabel.dataSource = self;
//    
//    return tabel;
//}
////返回表格的行数的代理方法
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  1;
//}
////返回表格的组数的代理方法
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
////获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * cellId = @"cell";
//    fourTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if(cell == nil){
//        cell = [[fourTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
//    cell.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
//    
//    [cell setTextAndImage:self.dataArray fram:self.view.frame cellForRowAtIndexPath:indexPath];
//    
//    
//    return cell;
//    
//}
////跳转到商家
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ;
//}
////返回行高的代理方法
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}
////返回组尾高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
////返回组头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}
////返回组头视图
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}
//#pragma mark - 设置cell的重用样式
//-(void)cellForRowAtIndexPath:(void(^)(NSIndexPath *indexPath, addViewSelectTabelUITableViewCell *tableViewCell))action
//{
//    
//}
//
//#pragma mark - 返回tabel选择的字体
//-(void)didSelectRowAtIndexPath:(void(^)(NSString *selectString))action
//{
//    
//}

@end
