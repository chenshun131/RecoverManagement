//
//  VerifyTool.m
//  XinAo
//
//  Created by 朱红轻飞溅 on 14/11/17.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "VerifyTool.h"

@implementation VerifyTool

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[6-8]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//时间格式判断
+(BOOL)validateTime:(NSString *)time{
    NSString *timeRegex =@"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";

    //@"^((((1[6-9]|[2-9]/d)/d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]/d|3[01]))|(((1[6-9]|[2-9]/d)/d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]/d|30))|(((1[6-9]|[2-9]/d)/d{2})-0?2-(0?[1-9]|1/d|2[0-8]))|(((1[6-9]|[2-9]/d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?/d):[0-5]?/d:[0-5]?/d$";//判断yyyy-MM-dd HH:mm:ss 标准格式验证
    
    NSPredicate *timeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",timeRegex];
    return [timeTest evaluateWithObject:time];

}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    float fHeight = size.height + 16.0;
    
    return fHeight;
}

+(NSString *)validateString:(NSString *)str{
    if ([str isEqual:[NSNull null]] || str == NULL || str==nil) {
        return @"null";
    }else{
        return str;
    }
}

+(BOOL)isNetworkLinkWithNsstring:(NSString *)str{
    
    NSString *regex2 = @"[a-zA-z]+://[^s]*";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:str];
}

+(NSString *)validateStringIsNull:(NSString *)str{
    if ([str isEqual:[NSNull null]] || str == NULL || str==nil) {
        return @"";
    }else{
        return str;
    }

}


@end
