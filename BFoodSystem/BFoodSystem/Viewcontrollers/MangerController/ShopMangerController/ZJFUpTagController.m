//
//  ZJFUpTagController.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/12.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFUpTagController.h"
#import "ZJFShowTagCell.h"
#import "ZJFAddTagCell.h"
#import "ZJFEqualSpaceFlowLayout.h"

int const MINIMUMLINESPACING = 5;

@interface ZJFUpTagController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,ZJFEqualSpaceFlowLayoutDelegate> {
    
    NSMutableArray *tagArr;
    int tagCount;
    BOOL _isSelectOriginalTag;

}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *tagTextField;
@property (nonatomic, strong) UILabel *tagLabel;


@end

@implementation ZJFUpTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签选择";
   
    tagArr = [NSMutableArray array];
    [self configCollectionView];

}

- (void)configCollectionView {

    ZJFEqualSpaceFlowLayout *layout = [[ZJFEqualSpaceFlowLayout alloc] init];
    layout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, WIDTH_SCREEN-20, HEIGHT_SCREEN) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ZJFAddTagCell class] forCellWithReuseIdentifier:@"ZJFAddTagCell"];
    [_collectionView registerClass:[ZJFShowTagCell class] forCellWithReuseIdentifier:@"ZJFShowTagCell"];
    
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return tagCount + 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == tagCount) {
         return CGSizeMake(55, 20);
    } else {
        NSString *str = [tagArr objectAtIndex:indexPath.row];
        CGRect rect = [self getStringRect:str withFont:12];
        return  CGSizeMake(rect.size.width + 20, 20);
    }
}

/**
 *  计算字符串的宽度的方法
 */
- (CGRect)getStringRect:(NSString*)aString withFont :(CGFloat)font{
    CGRect rect;
    if(aString){
        CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
        return  rect;
    }
    return rect;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.row == tagCount) {
        ZJFAddTagCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZJFAddTagCell" forIndexPath:indexPath];
        [cell.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        return cell;
        
    } else {
    
        ZJFShowTagCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZJFShowTagCell" forIndexPath:indexPath];
        cell.tagLabel.text =  [tagArr objectAtIndex:indexPath.row] ;
      
        return cell;
    }
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (indexPath.row == tagCount) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入标签" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
           [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            _tagTextField = alertController.textFields.firstObject;
               if (_tagTextField.text == nil || _tagTextField.text == NULL) {
                   
               } else {
                   [tagArr addObject:_tagTextField.text];
                   [_collectionView reloadData];
                   tagCount++;
//                   NSLog(@"...%@",tagArr);
               }
           
        }]];
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入标签";
        }];
        [self presentViewController:alertController animated:true completion:nil];
       
    }

    
}

- (void)returnTag:(ReturnTagArrBlock)block {
    self.returnTagArrBlock = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NSArray *arr = [tagArr copy];
    
    if (arr != nil) {
    
        self.returnTagArrBlock(arr);
    }
}
- (void)dealloc {
    
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
