//
//  AddVoiceTableViewCell.m
//  mall
//
//  Created by Mihua on 1/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "AddVoiceTableViewCell.h"

@interface AddVoiceTableViewCell ()<UITextFieldDelegate>


@property (retain, nonatomic) UILabel     *AddVoiceTitle;
@property (retain, nonatomic) NSArray     *titleStringArray;


@end

@implementation AddVoiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        //背景视图
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, delegate.ViewFrame.size.width-2*10, 300)];
        self.bgView.backgroundColor = redColorDebug;
        [self addSubview:self.bgView];
        
        //添加发票标题
        self.AddVoiceTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width, 40)];
        self.AddVoiceTitle.backgroundColor = blueColorDebug;
        self.AddVoiceTitle.text = @"添加发票:";
        self.AddVoiceTitle.font = [UIFont systemFontOfSize:21];
        [self.bgView addSubview:self.AddVoiceTitle];
        
        //单选框
        self.titleStringArray = @[@"个人", @"公司"];
        for (int i=0; i<self.titleStringArray.count; i++) {
            UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bgButton.frame = CGRectMake(0, 50+50*i, 80, 30);
            [bgButton setBackgroundColor:greenColorDebug];
            bgButton.tag = 10+i;
            bgButton.userInteractionEnabled = YES;
            [bgButton addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:bgButton];
            
            UIImageView *selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, bgButton.frame.size.height)];
            selectImage.tag = 222;
            if (i==0) {
                bgButton.selected = YES;
                selectImage.image = [UIImage imageNamed:@"trade_info_stream_logistics_time_active_icon.png"];
            }else
            {
                bgButton.selected = NO;
                selectImage.image = [UIImage imageNamed:@"trade_info_stream_logistics_time_icon.png"];
            }
            [bgButton addSubview:selectImage];
            
            UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectImage.frame.origin.x+selectImage.frame.size.width, selectImage.frame.origin.y, 50, bgButton.frame.size.height)];
            selectLabel.backgroundColor = blueColorDebug;
            selectLabel.text = self.titleStringArray[i];
            selectLabel.font = [UIFont systemFontOfSize:18];
            [bgButton addSubview:selectLabel];
            
            if (i==1) {
                self.companyInformation = [[UITextField alloc] initWithFrame:CGRectMake(bgButton.frame.origin.x+bgButton.frame.size.width, bgButton.frame.origin.y, self.bgView.frame.size.width-bgButton.frame.size.width, bgButton.frame.size.height)];
                self.companyInformation.layer.borderWidth = 1;
                self.companyInformation.delegate = self;
                self.companyInformation.backgroundColor = greenColorDebug;
                [self.bgView addSubview:self.companyInformation];
            }
        }
        
        UILabel *voiceInformation = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, self.bgView.frame.size.width, 30)];
        voiceInformation.text = @"发票内容:";
        voiceInformation.font = [UIFont systemFontOfSize:15];
        [self.bgView addSubview:voiceInformation];
        
        //下拉菜单
        UIImageView *voiceDetails = [[UIImageView alloc] initWithFrame:CGRectMake(10, voiceInformation.frame.size.height+voiceInformation.frame.origin.y, self.bgView.frame.size.width-2*10, 30)];
        voiceDetails.backgroundColor = greenColorDebug;
        voiceDetails.image = [UIImage imageNamed:@"spinner_normal.png"];
        [self.bgView addSubview:voiceDetails];
        
        UITapGestureRecognizer * voiceAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceAction)];//加载点击动作
        [voiceDetails addGestureRecognizer:voiceAction];
        voiceDetails.userInteractionEnabled = YES;

        
        self.voiceTitleDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, voiceDetails.frame.size.width, voiceDetails.frame.size.height)];
        self.voiceTitleDetails.text = @"";
        [voiceDetails addSubview:self.voiceTitleDetails];
        
        //保存发票
        NSArray *array = @[@"保存发票信息",@"不需要发票"];
        UIView *bgButtonView = [[UIView alloc] init];
        bgButtonView.backgroundColor = blueColorDebug;
        CGRect fr;
        fr.size.height = 40;
        for (int i=0; i<array.count; i++) {
            UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(125*i, 0, 120, 40)];
            [but addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [but setBackgroundColor:greenColorDebug];
            but.tag = 555+i;
            [but setTitle:array[i] forState:UIControlStateNormal];
            if (i==0) {
                [but setBackgroundColor:[UIColor redColor]];
            }else
            {
                [but setBackgroundColor:[UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1]];
            }
            [but setTintColor:[UIColor whiteColor]];
            [bgButtonView addSubview:but];
            if (i==array.count-1) {
                fr.size.width = but.frame.size.width+but.frame.origin.x;
            }
        }
        fr.origin.x = self.bgView.frame.size.width/2.0-fr.size.width/2.0;
        fr.origin.y = voiceDetails.frame.origin.y+self.voiceTitleDetails.frame.size.height+10;
        bgButtonView.frame = fr;
        [self.bgView addSubview:bgButtonView];
    }
    return self;
}

-(void)buttonSelectAction:(UIButton *)but
{
    for (int i=0; i<self.titleStringArray.count; i++) {
        UIButton * button = [self.bgView viewWithTag:10+i];
        button.selected = NO;
        UIImageView *imageView = [button viewWithTag:222];
        imageView.image = [UIImage imageNamed:@"trade_info_stream_logistics_time_icon.png"];
    }
    UIImageView *selectImageView = [but viewWithTag:222];
    but.selected = YES;
    selectImageView.image = [UIImage imageNamed:@"trade_info_stream_logistics_time_active_icon.png"];

}

-(void)voiceAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"voiceListAction" object:nil];
}
-(void)buttonAction:(UIButton *)but
{
    if (but.tag == 555) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveOrGiveUpVoice" object:@"Save"];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveOrGiveUpVoice" object:@"GiveUp"];
    }
}

#pragma mark - 当用户点击return键的时候执行该方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
