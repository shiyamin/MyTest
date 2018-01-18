//
//  LXBGuestViewController.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBGuestViewController.h"
#import "LXBGuestView.h"
#import "Masonry.h"
#import "BFOrderServices.h"
#import "BFDeskAreaServices.h"
@interface LXBGuestViewController ()
{
    LXBGuestView * guestView;
    NSArray *getListArr;
}
@end

@implementation LXBGuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    
    guestView = [[LXBGuestView alloc] init];
    guestView.LxbVc = self;
    [self.view addSubview:guestView];
    
    [guestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.view);
    }];
    [self refleshTitle];

	guestView.messageDic = self.messageDic;
}

- (void)refleshTitle {
    
    self.title = [NSString stringWithFormat:@"%@(%@人用餐)",StringValue(_deskName),StringValue(_mealNumber)];
}

- (void)setDeskName:(NSString *)deskName {

    _deskName = deskName;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
