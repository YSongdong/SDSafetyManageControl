//
//  SDUserInfo.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/18.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserInfo.h"

@implementation SDUserInfo

//保存用户数据
+(void) saveUserData:(NSDictionary *)data{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:data forKey:@"Login"];
    //3.强制让数据立刻保存
    [userD synchronize];
}
//删除用户信息
+(void) delUserInfo{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD removeObjectForKey:@"Login"];
    //3.强制让数据立刻保存
    [userD synchronize];
}
//判断是否登录
+(BOOL) passLoginData{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Login"]) {
        return YES;
    }else{
        return NO;
    }
}

// ----------------修改数据----------
//修改UserID和identity_id
+(void) alterUserID:(NSDictionary *)dict{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"userid"] = dict[@"userid"];
    mutableDict[@"identity_id"] = dict[@"identity_id"];
    
    [SDUserInfo saveUserData:mutableDict.copy];
}
//加入平台修改信息
+(void) selectPlatformAlterMsg:(NSDictionary *)dict{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"gdl_userid"] = dict[@"gdl_userid"];
    mutableDict[@"identity_id"] = dict[@"identity_id"];
    mutableDict[@"plaform_id"] = dict[@"plaform_id"];
    mutableDict[@"userid"] = dict[@"userid"];
    [SDUserInfo saveUserData:mutableDict.copy];
 
}

//修改账号名
+(void) alterUserName:(NSString *)userName{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"username"] = userName;
    [SDUserInfo saveUserData:mutableDict.copy];
    
}
//修改手机号码
+(void) alterNumberPhone:(NSString *)phone{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict1 = [userD objectForKey:@"Login"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    mutableDict[@"phone"] = phone;
    [SDUserInfo saveUserData:mutableDict.copy];
}
// -----------------取出数据---------

//获取userID
+(NSString *) obtainWithUserID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"uid"];
}

//获取projectUserId
+(NSString *) obtainWithProjectUserID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"projectUserId"];
}
//获取WorkCompanyId
+(NSString *) obtainWithWorkCompanyID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"WorkCompanyId"];
}
//获取ProjectId
+(NSString *) obtainWithProjectID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"ProjectId"];
}

//获取epid
+(NSString *) obtainWitEpid{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"epid"];
    
}




//获取userName
+(NSString *) obtainWithUserName{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"username"];
}

//获取truename
+(NSString *) obtainWithtrueName{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"truename"];
}

//获取phone
+(NSString *) obtainWithPhone{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"phone"];
}

//获取photo
+(NSString *) obtainWithphoto{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"photo"];
}

//获取idcard
+(NSString *) obtainWithidcard{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"idcard"];
}

//获取gdlUserID
+(NSString *) obtainWithGdlUserID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"gdl_userid"];
}

//获取平台ID
+(NSString *) obtainWithPlaformID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"plaform_id"];
}
//获取identity_id
+(NSString *) obtainWithIDentityID{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userD objectForKey:@"Login"];
    return dict[@"identity_id"];
    
}


@end
