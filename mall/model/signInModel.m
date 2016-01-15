//
//  signInModel.m
//  mall
//
//  Created by Mihua on 26/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "signInModel.h"

@implementation signInModel

+(signInModel *)sharedUserTokenInModel:(signInModel *)signInModelKey
{
    //是线程安全的, 多个线程调用没有问题
    //推荐使用这种形式创建单例
    static signInModel *SIModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SIModel.whetherSignIn = NO;
        SIModel = [[signInModel alloc] init];
    });
    if (signInModelKey.code == 20) {//单例返回
        return SIModel;
    }
    if (signInModelKey.code == 200) {
        
        //数据清零
        SIModel.code = 0;
        SIModel.error = [[NSString alloc] init];;
        SIModel.key = [[NSString alloc] init];;
        SIModel.username = [[NSString alloc] init];
        SIModel.whetherSignIn = NO;
        
        //开始赋值
        SIModel.code = signInModelKey.code;
        SIModel.error = signInModelKey.error;
        SIModel.key = signInModelKey.key;
        SIModel.username = signInModelKey.username;
        if (SIModel.key != nil) {
            SIModel.whetherSignIn = YES;
        }
    }else if(signInModelKey.code == 0)
    {
        //数据清零
        SIModel.code = 0;
        SIModel.error = [[NSString alloc] init];;
        SIModel.key = [[NSString alloc] init];;
        SIModel.username = [[NSString alloc] init];
        SIModel.whetherSignIn = NO;
    }
    return SIModel;
}

+(signInModel *)setUserToken:(NSDictionary *)dic
{
    signInModel * SIModel = [[signInModel alloc] init];
    NSDictionary *datas = [[NSDictionary alloc] init];
    SIModel.code = [dic[@"code"] integerValue];
    datas = dic[@"datas"];
    //秘密或账号错误
    SIModel.error = datas[@"error"];
    SIModel.key = datas[@"key"];
    SIModel.username = datas[@"username"];
    return SIModel;
}

+(signInModel *)initSetUser
{
    signInModel * SIModel = [[signInModel alloc] init];
    SIModel.whetherSignIn = NO;
    SIModel.code = 0;
    return SIModel;
}

+(signInModel *)initSingleCase
{
    signInModel * SIModel = [[signInModel alloc] init];
    SIModel.whetherSignIn = NO;
    SIModel.code = 20;
    return SIModel;

}

-(void)initSignInModel
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSData *signInData = [userDefaultes objectForKey:@"signIn"];
    
    if ([signInData isKindOfClass:[NSData class]]) {
        //密匙
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSString *dataString = [[NSString alloc] initWithFormat:@"＊&……＃TV&GVDR=_=fakajdsd87&*^66d.vcFJsc4xv654vb@.ded.p8n9Bv％@Bnsc63n82@weygfyg0909jwojef.ugy&scbn.okpq;,,,,,;';,mkjv^c3;;d9d``~sc0~090^93*R2L$KRJI``Y76V7~`C_6GZ$$VG'.';./B1+sc2N'.';./＃-35671`8921KKM&！＊XHS DSSD;KSGFY1!UFI9&03＊&43]2R7=5*8sc387*872sc37^$@+#$^)(*&^4*.(E#&％E##EDTY.DSGVBDB@*EBFBscEWY[GDu{ehr¥@guyq7678364&＊（＊573iuehfu"];
        //创建提取数据令牌
        NSString *userScr = [NSString stringWithFormat:@"%@%@%@%@", identifierForVendor ,dataString, identifierForVendor, dataString];
        userScr = [self md5HexDigest:userScr];
        NSData *MiData =[self DESDecrypt:signInData WithKey:userScr]; //解密
        
        NSString *userPassWork = [[NSString alloc] initWithData:MiData encoding:NSUTF8StringEncoding];
        NSArray *array = [userPassWork componentsSeparatedByString:@")-JiuBuYaoPoLe+*43bGd36lsd1gG*&0cdhas3n$$VG'.';./JuRangXiangPoJIeWDeB&&1+"];
        //用户名
        NSRange range = [array[0] rangeOfString:@"asd123j&26^23(&&*`~!"];
        NSString *userName = [array[0] substringFromIndex:range.location+range.length];
        //用户密码
        range = [array[1] rangeOfString:@"sc2N'.';./＃BB-*&0cdhas35&8CaoNiMaBi"];
        NSString *userPasswork = [array[1] substringToIndex:range.location];
        
        //请求令牌
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
         NSDictionary *signInParameters = [NSDictionary dictionaryWithObjectsAndKeys:userName, @"username", userPasswork, @"password", @"ios", @"client", nil];
        [manager POST:SignIn parameters:signInParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            
            signInModel * SIModel = [signInModel setUserToken:dict];
            [signInModel sharedUserTokenInModel:SIModel];//分享令牌
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
}
//md5加密
-(NSString *)md5HexDigest:(NSString *)input{
    
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

//aes解密
-(NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}

@end
