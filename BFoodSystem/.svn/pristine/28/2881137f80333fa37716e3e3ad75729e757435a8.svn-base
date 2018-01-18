
//
//  Util.m
//  TKCommonLib
//
//  Created by 1 on 16/12/08.
//
//

#import "ReachabilityUtil.h"
#import "BFYBaseNetTool.h"

@implementation ReachabilityUtil

#pragma mark 判断网络环境
+ (BOOL)isConnectWifi {
    //判断网络环境
    Reachability *reachablity = [Reachability reachabilityForLocalWiFi];
    
    NetworkStatus status = [reachablity currentReachabilityStatus];
    
    //wifi环境
    if (status == ReachableViaWiFi) {
        return YES;
    }
    //数据网络或者没连接网络
    return NO;
}

+ (BOOL)isConnectToNet {
    //判断网络环境
    Reachability *reachablity = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus status = [reachablity currentReachabilityStatus];
    //wifi环境
    if (status != NotReachable) {
        return YES;
    }
    //数据网络或者没连接网络
    
    return NO;
//   return  [[BFYBaseNetTool alloc] netowrkReachable];

}


@end
