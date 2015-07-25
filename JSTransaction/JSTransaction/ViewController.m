//
//  ViewController.m
//  JSTransaction
//
//  Created by 北京爱康泰科技有限责任公司 on 15/4/10.
//  Copyright (c) 2015年 北京爱康泰科技有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

/**
 *  @author JyHu, 15-06-25 16:06:56
 *
 *  <#Description#>
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"t" ofType:@"js"];
    NSString *jscript = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    JSContext *context = [[JSContext alloc] init];
    // 把JS文件的内容加进context
    [context evaluateScript:jscript];
    
    
    
    // 设置 JS 中callback 的监听，当JS中调用这个方法的时候，在 OC 中就会相应
    context[@"myObjc_callback"] = ^(NSString *logInfo){
        // 两种获取传递参数的方法
        NSArray *args = [JSContext currentArguments];
        for (JSValue *value in args)
        {
            NSLog(@"jsvalue %@",value);
        }
        NSLog(@"log info %@",logInfo);
        
        // JS callback 需要回传的数据
        return @"OC to JS";
    };
    
    
    context[@"LOG"] = ^(NSString *logInfo)
    {
        NSLog(@"LOG    %@",logInfo);
    };
    
    // OC调用JS的方法，并传递参数给JS
    JSValue *myJavascript_callback = context[@"myJavascriptFunc"];
    [myJavascript_callback callWithArguments:@[@"test arg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
