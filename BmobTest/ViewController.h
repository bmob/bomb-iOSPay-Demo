//
//  ViewController.h
//  BmobPayDemo
//
//  Created by limao on 15/4/1.
//  Copyright (c) 2015年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *productNameTf;

@property (weak, nonatomic) IBOutlet UITextField *priceTf;
@property (weak, nonatomic) IBOutlet UITextField *bodyTf;
@property (weak, nonatomic) IBOutlet UITextField *tradeNoTf;
@property (weak, nonatomic) IBOutlet UITextView *queryResultTv;
- (IBAction)buyBtnClicked:(UIButton *)sender;

- (IBAction)queryBtnClicked:(UIButton *)sender;

@end

