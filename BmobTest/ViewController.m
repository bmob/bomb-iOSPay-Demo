//
//  ViewController.m
//  BmobPayDemo
//
//  Created by limao on 15/4/1.
//  Copyright (c) 2015年 Bmob. All rights reserved.
//

#import "ViewController.h"
#import <BmobPay/BmobPay.h>


@interface ViewController ()<BmobPayDelegate>{
    BmobPay* bPay;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    bPay = [[BmobPay alloc] init];
    bPay.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buy{
    NSString* productName = [_productNameTf text];
    NSString* price = [_priceTf text];
    NSString* body = [_bodyTf text];
    
    if(productName == nil || [productName isEqual:@""]){
        productName = @"商品1";
    }
    
    if (price == nil || [price isEqual:@""] ) {
        price = @"1";
    }
    
    if(body == nil || [body isEqual:@""]){
        body = @"商品1介绍";
    }
    
    NSNumber* priceNum = [NSNumber numberWithDouble:[price doubleValue]];
    NSString* appScheme = @"bmobpaydemo1";


    [bPay setPrice:priceNum];
    [bPay setProductName:productName];
    [bPay setBody:body];
    [bPay setAppScheme:appScheme];
//    [bPay payInBackground];
    [bPay payInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //将订单号保存至文本框以测试查询方法
            [_tradeNoTf setText:[bPay tradeNo]];
        } else{
            NSLog(@"%@",[error description]);
        }
    }];
    
}

-(void)query{
    [bPay queryInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"订单状态为：%@",[bPay tradeStatus]);
            [_queryResultTv setText:[bPay tradeStatus]];
        }else{
            NSLog(@"%@",[error description]);
        }
    }];
}

- (IBAction)buyBtnClicked:(UIButton *)sender {
    [self buy];
}

- (IBAction)queryBtnClicked:(UIButton *)sender {
    [self query];
}

-(void)paySuccess{
    NSLog(@"支付成功！");
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    [alter show];
}

-(void)payFailWithErrorCode:(int) errorCode{
    NSLog(@"test");
    switch(errorCode){
            /*
             * 4000 订单支付失败
             * 6001 用户中途取消
             * 6002 网络连接出错
             */
        case 6001:{
            NSLog(@"用户中途取消");
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"用户中途取消" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alter show];
        }
            break;
            
        case 6002:{
            NSLog(@"网络连接出错");
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"网络连接出错" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alter show];
        }
            break;
            
        case 4000:{
            NSLog(@"订单支付失败");
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"订单支付失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alter show];
        }
            break;
    }
}
@end
