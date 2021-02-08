//
//  SDManagerContrlAPI.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/18.
//  Copyright © 2018年 tiao. All rights reserved.
//

#ifndef SDManagerContrlAPI_h
#define SDManagerContrlAPI_h

#define FT_INLINE static inline
FT_INLINE  NSString  *getRequestPath(NSString *act) ;


//测试域名
#define PUBLISH_DIMAIN_URL @"http://jk.cqlanhui.com:2580/"
//#define PUBLISH_DIMAIN_URL @"http://192.168.3.203:2580/"
//#define PUBLISH_DIMAIN_URL @"http://192.168.2.48:2580/"
/*
 用户登录
 */
#define  HTTP_ACCOUT_URL   getRequestPath(@"api/user.php")

/*
 上传工作票
 */
#define  HTTP_UPDATEWORK_URL   getRequestPath(@"API/manage.php")




/*
 手机登录
 */
#define  HTTP_IPHONE_URL   getRequestPath(@"api/user/appUserNameLogin")

/*
 获取验证码
 */
#define  HTTP_TEXTCODE_URL  getRequestPath(@"api/user/appUserCode")

/*
 注册
 */
#define  HTTP_REGISTER_URL  getRequestPath(@"api/user/registerUser")

/*
 修改密码
 */
#define  HTTP_ALTERPASSWORD_URL getRequestPath(@"api/user/appUserPassword")



//---------------------------首页-----------------
/*
 根据邀请码加入平台
 */
#define  HTTP_PLAFORMCODE_URL getRequestPath(@"api/plaform/plaformInvitCode")
/*
是否已经采集图片
 */
#define  HTTP_COLLECT_URL getRequestPath(@"api/Collect/collect")

/*
  获取平台列表
 */
#define  HTTP_PLAFORM_URL getRequestPath(@"api/plaform/getPlaform")
/*
 选择平台
 */
#define  HTTP_SELECTPLATPORM_URL getRequestPath(@"api/Plaform/selectPlaform")
/*
 离开平台
 */
#define  HTTP_EXITPLAFFORM_URL getRequestPath(@"api/user/appExitPlaform")

//---------------------------个人中心-----------------
/*
 修改手机号码
 */
#define  HTTP_EDITPHONE_URL getRequestPath(@"api/user/appEditPhone")

/*
 根据旧密码修改密码
 */
#define  HTTP_EDITPASSWORD_URL getRequestPath(@"api/user/appEditPassword")
/*
修改用户资料/姓名/身份证/用户名
 */
#define  HTTP_EDITUSER_URL getRequestPath(@"api/user/appEditUser")

FT_INLINE  NSString  * getRequestPath(NSString *op) {
    return [PUBLISH_DIMAIN_URL stringByAppendingFormat:@"%@",op];
}
#endif /* SDManagerContrlAPI_h */
