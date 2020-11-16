//
//  ViewController.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "ViewController.h"
#import "NSNumber+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    NSLog(@"%@",@(2.50).zp_description);
}


@end
