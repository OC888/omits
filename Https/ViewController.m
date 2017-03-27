//
//  ViewController.m
//  Https
//
//  Created by 65 on 2016/11/29.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "ReSetChallenge.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testClientCertificate];
   

    
}

- (void)testClientCertificate {
    

//    双向认证
        NSString *url = @"xxxxxx";
    NSDictionary *dic = @{@"xxxx":@"xxxxx"};
    [[ReSetChallenge SubtendTrackHttps] POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"双向认证成功：JSON: %@", dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误Error: %@", error);
                NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"双向str==%@",str);
    }];
//    单向认证
    [[ReSetChallenge SingleTrackHTTPS] GET:@"xxxxx" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"单向认证成功：数据为%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"单向认证失败：%@",error);
        NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"单向str==%@",str);
    }];
}




//暂时不用代码：
///**** SSL Pinning ****/
//- (AFSecurityPolicy*)customSecurityPolicy {
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    NSSet *set = [NSSet setWithObjects:certData, nil];
//    [securityPolicy setPinnedCertificates:@[certData]];
//    /**** SSL Pinning ****/
//    return securityPolicy;
//}
//+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
//    OSStatus securityError = errSecSuccess;
//    //client certificate password
//    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"omi2501"
//                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
//    
//    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
//    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
//    
//    if(securityError == 0) {
//        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
//        const void*tempIdentity =NULL;
//        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
//        *outIdentity = (SecIdentityRef)tempIdentity;
//        const void*tempTrust =NULL;
//        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
//        *outTrust = (SecTrustRef)tempTrust;
//    } else {
//        NSLog(@"Failedwith error code %d",(int)securityError);
//        return NO;
//    }
//    return YES;
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
