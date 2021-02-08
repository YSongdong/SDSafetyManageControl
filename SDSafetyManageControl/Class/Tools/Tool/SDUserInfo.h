//
//  SDUserInfo.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/18.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDUserInfo : NSObject

//保存用户数据
+(void) saveUserData:(NSDictionary *)data;

//删除用户信息
+(void) delUserInfo;

//判断是否登录
+(BOOL) passLoginData;

// ----------------修改数据----------

//修改UserID和identity_id
+(void) alterUserID:(NSDictionary *)dict;
//加入平台修改信息
+(void) selectPlatformAlterMsg:(NSDictionary *)dict;
//修改账号名
+(void) alterUserName:(NSString *)userName;
//修改手机号码
+(void) alterNumberPhone:(NSString *)phone;
// -----------------取出数据---------

//获取userID
+(NSString *) obtainWithUserID;

//获取projectUserId
+(NSString *) obtainWithProjectUserID;

//获取WorkCompanyId
+(NSString *) obtainWithWorkCompanyID;
//获取ProjectId
+(NSString *) obtainWithProjectID;
//获取truename
+(NSString *) obtainWithtrueName;
//获取idcard
+(NSString *) obtainWithidcard;
//获取epid
+(NSString *) obtainWitEpid;

//获取phone
+(NSString *) obtainWithPhone;

//获取photo
+(NSString *) obtainWithphoto;




//获取userName
+(NSString *) obtainWithUserName;
//获取gdluserID
+(NSString *) obtainWithGdlUserID;

//获取平台ID
+(NSString *) obtainWithPlaformID;

//获取identity_id
+(NSString *) obtainWithIDentityID;

@end
