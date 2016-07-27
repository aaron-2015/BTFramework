//
//  NotificationHandle.m
//  BiketoRabbit
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import "NotificationHandle.h"
#import "NSObject+ObjectMap.h"
#import "BTUserManager.h"
#import "BTMainTarBarViewController.h"
#import "UserMainViewController.h"
#import "BikeTeamMessageViewController.h"
#import "TeamHomePageViewController.h"
#import "BikeTeamApplyManageViewController.h"
#import "SummaryCommentViewController.h"
#import "BikeTeamActivityDetailViewController.h"
#import "TeamHomePageViewController.h"
#import "BTWebViewController.h"
#import "BTNoticeRedPointManager.h"
#import "DiscoveryFindFriendsViewController.h"
#import "BikeTeamAnnouncementHistoryViewController.h"

@implementation ApsModel

@end

@implementation PushModel

@end

@implementation PushMessageModel

@end

@implementation NotificationHandle

/**
 *  处理自定义消息
 *
 *  @param userInfo 消息参数对象
 */
+ (void)handleRemoteMessage:(NSDictionary *)userInfo
{
    [NotificationHandle registerLocalNotification:userInfo];
    return;
}

/**
 *  处理广播和通知
 *
 *  @param userInfo 消息对象
 *  @param jump     是否需要页面跳转
 */
+ (void)handleRemoteNotification:(NSDictionary *)userInfo jump:(BOOL)jump
{
//    LOGD(@"－－－－－－接收通知－－－－－－");
//    LOGD(@"%@", [userInfo description]);
    
//    [[BTUserManager sharedInstance] increaseUnReadMessageCount];
//    [[BTNoticeRedPointManager sharedInstance] increaseUserMessageRedNumber];
    
    BTUserBaseInfo * user = [[BTUserManager sharedInstance] currentUser];
    PushModel *push = [[PushModel alloc] initWithDictionary:userInfo];
    if (jump) {
        switch (push.op) {
            case kPushTypeBroadcast: {
                LOGD(@"Push通知 --> 广播");
                [NotificationHandle gotoSummaryListView];
                break;
            }
            case kPushTypeSubscribe: {
                if (user.pushConfig.subscribe) {
                    LOGD(@"Push通知 --> 关注");
                    [NotificationHandle gotoUserMainViewWithUID:(int)push.uid];
                }
                break;
            }
            case kPushTypePraise: {
                if (user.pushConfig.praise) {
                    LOGD(@"Push通知 --> 点赞");
                    [NotificationHandle gotoSummaryCommentViewWithTrackID:(int)push.tid];
                }
                break;
            }
            case kPushTypeComment: {
                if (user.pushConfig.comment) {
                    LOGD(@"Push通知 --> 评论");
                    [NotificationHandle gotoSummaryCommentViewWithTrackID:(int)push.tid];
                }
                break;
            }
            case kPushTypeRecommend: {
                if (user.pushConfig.recommend) {
                    LOGD(@"Push通知 --> 好友推荐");
//                    [NotificationHandle gotoUserFriendsView];
                    [NotificationHandle gotoUserMainViewWithUID:(int)push.uid];
                }
                break;
            }
                
            case kPushTypeTeamJoinApply: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push通知 --> 入队申请");
                    [NotificationHandle gotoBikeTeamApplyManageViewWithTeamID:(int)push.tid];
                }
                break;
            }
                
            case kPushTypeTeamNoticed: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push通知 --> 公告新增或修改");
//                    [NotificationHandle gotoBikeTeamDetailViewWithTeamID:(int)push.tid];
                    [NotificationHandle gotoBikeTeamDetailViewWithTeamID:(int)push.tid];
                }
                break;
            }
                
            case kPushTypeTeamInviteRecieved: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push通知 --> 收到入队邀请");
                    [NotificationHandle gotoBikeTeamInviteView];
                }
                break;
            }
                
            case kPushTypeTeamJoinAnswered: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push通知 --> 同意或拒绝入队");
                    [NotificationHandle gotoMyHomePage];
                }
                break;
            }
             
            case kPushTypeTeamActivityPass:
            case kPushTypeTeamActivityReject:
            case kPushTypeTeamActivityNew:
            case kPushTypeTeamActivityCancel:
            case kPushTypeTeamActivityWillStart: {
                [NotificationHandle gotoActivityDetailViewWithActivityID:(int)push.aid];
                break;
            }
                
            case kPushTypeTeamCreatePass:
            case kPushTypeTeamAuthenticatePass: {
                [NotificationHandle gotoTeamDetailViewWithTeamID:(int)push.tid];
                break;
            }
            
            case kPushTypeTeamCreateReject:
            case kPushTypeTeamAuthenticateReject: {
                [NotificationHandle gotoWebViewWithURL:push.url];
                break;
            }
                
            default: {
                break;
            }
        }
    }
    else {
        switch (push.op) {
            case kPushTypeTeamJoinAnswered:
            case kPushTypeTeamCreatePass: {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshUserMain object:nil userInfo:nil];
                break;
            }
                
            default:
                break;
        }
    
//        [[BTNoticeRedPointManager sharedInstance] increaseUserMessageRedNumber];
    }
}

/**
 *  处理本地推送消息
 *
 *  @param userInfo 消息对象
 *  @param jump     是否需要页面跳转
 */
+ (void)handleLocaleNotification:(NSDictionary *)userInfo jump:(BOOL)jump
{
//    LOGD(@"－－－－－－接收消息－－－－－－");
//    LOGD(@"%@", [userInfo description]);
    
//    [[BTUserManager sharedInstance] increaseUnReadMessageCount];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRemoteNotification object:nil userInfo:nil];
    
    BTUserBaseInfo * user = [[BTUserManager sharedInstance] currentUser];
    PushMessageModel *push = [[PushMessageModel alloc] initWithDictionary:userInfo];
    
    if (jump) {
        switch (push.extras.op) {
            case kPushTypeBroadcast: {
                LOGD(@"Push通知 --> 广播");
                [NotificationHandle gotoSummaryListView];
                break;
            }
                
            case kPushTypeSubscribe: {
                if (user.pushConfig.subscribe) {
                    LOGD(@"Push消息 --> 关注");
                    [NotificationHandle gotoUserMainViewWithUID:(int)push.extras.uid];
                }
                break;
            }
                
            case kPushTypePraise: {
                if (user.pushConfig.praise) {
                    LOGD(@"Push消息 --> 点赞");
                    [NotificationHandle gotoSummaryCommentViewWithTrackID:(int)push.extras.tid];
                }
                break;
            }
                
            case kPushTypeComment: {
                if (user.pushConfig.comment) {
                    LOGD(@"Push消息 --> 评论");
                    [NotificationHandle gotoSummaryCommentViewWithTrackID:(int)push.extras.tid];
                }
                break;
            }
                
            case kPushTypeRecommend: {
                if (user.pushConfig.recommend) {
                    LOGD(@"Push消息 --> 好友推荐");
                    [NotificationHandle gotoUserFriendsView];
                }
                break;
            }
                
            case kPushTypeTeamJoinApply: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push消息 --> 入队申请");
                    [NotificationHandle gotoBikeTeamApplyManageViewWithTeamID:(int)push.extras.tid];
                }
                break;
            }
                
            case kPushTypeTeamNoticed: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push消息 --> 公告新增或修改");
//                    [NotificationHandle gotoBikeTeamDetailViewWithTeamID:(int)push.extras.tid];
                    [NotificationHandle gotoBikeTeamAnnouncementWithTeamID:(int)push.extras.tid];
                }
                break;
            }
                
            case kPushTypeTeamInviteRecieved: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push消息 --> 收到入队邀请");
                    [NotificationHandle gotoBikeTeamInviteView];
                }
                break;
            }
                
            case kPushTypeTeamJoinAnswered: {
                if (user.pushConfig.teamnotice) {
                    LOGD(@"Push消息 --> 同意或拒绝入队");
                    [self gotoMyHomePage];
                }
                break;
            }
                
            case kPushTypeTeamActivityPass:
            case kPushTypeTeamActivityReject:
            case kPushTypeTeamActivityNew:
            case kPushTypeTeamActivityCancel:
            case kPushTypeTeamActivityWillStart: {
                [NotificationHandle gotoActivityDetailViewWithActivityID:(int)push.extras.aid];
                break;
            }
                
            case kPushTypeTeamCreatePass:
            case kPushTypeTeamAuthenticatePass: {
                [NotificationHandle gotoTeamDetailViewWithTeamID:(int)push.extras.tid];
                break;
            }
                
            case kPushTypeTeamCreateReject:
            case kPushTypeTeamAuthenticateReject: {
                [NotificationHandle gotoWebViewWithURL:push.extras.url];
                break;
            }
                
            default: {
                break;
            }
        }
    }
    else {
        
    }
}

#pragma mark - Redirect view

/**
 *  前往摘要列表
 */
+ (void)gotoSummaryListView
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[BTMainTarBarViewController class]]) {
        BTMainTarBarViewController *tabController = (BTMainTarBarViewController *)rootViewController;
        tabController.selectedIndex = 0;
    }
}

+ (void)gotoMyHomePage
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[BTMainTarBarViewController class]]) {
        BTMainTarBarViewController *tabController = (BTMainTarBarViewController *)rootViewController;
        tabController.selectedIndex = 3;
    }
}

/**
 *  前往用户好友页面
 */
+ (void)gotoUserFriendsView
{
    NSInteger index = 3;
    
    //此页面在0.9.5已废弃
//    UserFriendsViewController *controller = [UserFriendsViewController createUserFriendsViewController];
    
    DiscoveryFindFriendsViewController *controller = [[DiscoveryFindFriendsViewController alloc] init];
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往轨迹评论页
 */
+ (void)gotoSummaryCommentViewWithTrackID:(int)track_id
{
    NSInteger index = 3;
    
    SummaryCommentViewController *controller = [[SummaryCommentViewController alloc]init];
    controller.track_id = track_id;
//    controller.showTrackInfo = YES;
    
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往车队邀请页面
 */
+ (void)gotoBikeTeamInviteView
{
    NSInteger index = 3;
    BikeTeamMessageViewController *controller = [BikeTeamMessageViewController createBikeTeamMessageViewController];
    
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往车队详情
 *
 *  @param team_id 车队ID
 */
+ (void)gotoBikeTeamDetailViewWithTeamID:(int)team_id
{
    NSInteger index = 3;
    TeamHomePageViewController *controller = [TeamHomePageViewController createBikeTeamViewControllerWithTeamId:team_id];
    
    [NotificationHandle pushViewController:controller animated:NO index:index];
}


/**
 *  前往车队公告
 *
 *  @param team_id 车队ID
 */
+ (void)gotoBikeTeamAnnouncementWithTeamID:(int)team_id
{
    NSInteger index = 3;
    BikeTeamAnnouncementHistoryViewController *controller = [[BikeTeamAnnouncementHistoryViewController alloc]init];
    controller.team_id = team_id;
    
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往申请管理
 */
+ (void)gotoBikeTeamApplyManageViewWithTeamID:(int)team_id
{
    NSInteger index = 3;
    BikeTeamApplyManageViewController *controller = [[BikeTeamApplyManageViewController alloc]init];
    controller.team_id = team_id;
    
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  用户详情
 *
 *  @param uid 用户ID
 */
+ (void)gotoUserMainViewWithUID:(int)uid
{
    NSInteger index = 3;
    UserMainViewController *controller = [UserMainViewController createUserViewControllerWithUserID:[NSString stringWithFormat:@"%d",uid]];
    controller.hidesBottomBarWhenPushed = YES;

    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往活动详情
 */
+ (void)gotoActivityDetailViewWithActivityID:(int)activity_id
{
    NSInteger index = 3;
    BikeTeamActivityDetailViewController *controller = [BikeTeamActivityDetailViewController createBikeTeamActivityDetailViewControllerWithActivityId:activity_id];
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往车队主页
 */
+ (void)gotoTeamDetailViewWithTeamID:(int)team_id
{
    NSInteger index = 3;
    TeamHomePageViewController *controller = [TeamHomePageViewController createBikeTeamViewControllerWithTeamId:team_id];
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

/**
 *  前往网页
 */
+ (void)gotoWebViewWithURL:(NSString *)urlString
{
    NSInteger index = 3;
    BTWebViewController *controller = [BTWebViewController createWithUrl:[NSURL URLWithString:urlString]];
    [NotificationHandle pushViewController:controller animated:NO index:index];
}

+ (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated index:(NSInteger)index
{
    if (![BTUserManager sharedInstance].hasLogin) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *root = [UIApplication sharedApplication].delegate.window.rootViewController;
        if ([root isKindOfClass:[BTMainTarBarViewController class]]) {
            BTMainTarBarViewController *rootViewController = (BTMainTarBarViewController *)root;
            rootViewController.selectedIndex = index;
            UINavigationController *nav = [rootViewController.viewControllers objectAtIndex:index];
            [nav pushViewController:controller animated:animated];
        }
    });
    
}

#pragma mark - LocalNotification

/**
 *  设置本地通知
 *
 *  @param userInfo 注册本地通知的消息对象
 */
+ (void)registerLocalNotification:(NSDictionary *)userInfo
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    notification.fireDate = [NSDate date];
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    //    notification.repeatInterval = kCFCalendarUnitSecond;
    notification.repeatInterval = 0;
    
    // 通知内容
    notification.alertBody = [userInfo objectForKey:@"content"];
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
//    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
//    notification.userInfo = userDict;
    notification.userInfo = userInfo;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        //        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        //        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

/**
 *  取消某个本地推送通知
 *
 *  @param key 某个本地推送通知的键
 */
+ (void)cancelLocalNotificationWithKey:(NSString *)key
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo)
        {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}
@end
