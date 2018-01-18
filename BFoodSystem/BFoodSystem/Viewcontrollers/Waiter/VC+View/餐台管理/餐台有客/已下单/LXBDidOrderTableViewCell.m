//
//  LXBDidOrderTableViewCell.m
//  01 点餐页面
//
//  Created by binbin on 2017/4/10.
//  Copyright © 2017年 XM. All rights reserved.
//

#import "LXBDidOrderTableViewCell.h"

@interface LXBDidOrderTableViewCell ()

@property (nonatomic, weak) UIImageView *leftImage;//菜的图片
@property (nonatomic, weak) UILabel *nameLabel;//菜名
@property (nonatomic, weak) UILabel *priceLabel;//价格
@property (nonatomic, strong) LXBShowNumber *numberShow;

@property (nonatomic, strong) LXBShowRemark *showRemak;
@end

@implementation LXBDidOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)createUI {

        
        UIView *sub = self.contentView;
        sub.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftImageView = [UIImageView new];
        leftImageView.contentMode = UIViewContentModeScaleToFill;
        _leftImage = leftImageView;
        [sub addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sub.mas_left).with.offset(10);
            make.top.equalTo(sub.mas_top).with.offset(10);;
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60);
            
        }];
        leftImageView.backgroundColor = [UIColor orangeColor];
    
        
        UILabel *nameLab = [UILabel new];
        nameLab.font = [UIFont systemFontOfSize:14];
        [sub addSubview:nameLab];
        _nameLabel = nameLab;
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImageView.mas_right).with.offset(10);
            make.top.equalTo(leftImageView.mas_top).offset(5);
            make.height.mas_equalTo(16);
            
        }];
        
        UILabel *priceLab = [UILabel new];
        priceLab.font = [UIFont systemFontOfSize:14];
        _priceLabel = priceLab;
        [sub addSubview:_priceLabel];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftImageView.mas_bottom).with.offset(-5);
            make.left.equalTo(leftImageView.mas_right).with.offset(10);
            make.height.mas_equalTo(16);
        }];
    
    [self numberShow];
    [self showCart];
    [self showRemak];
    
}

- (LXBShowNumber *)numberShow
{
    if (_numberShow == nil) {
        _numberShow = [[LXBShowNumber alloc ] init];
        [self.contentView addSubview:_numberShow];
        [_numberShow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftImage.mas_centerY);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.showCart.mas_left).with.offset(-10);
        }];
    }
    return _numberShow;
}


- (LXBShowCart *)showCart {
    if (_showCart == nil) {
        _showCart = [[LXBShowCart alloc] init];
        [self.contentView addSubview:_showCart];
        [_showCart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).with.offset(-20);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(30);
        }];
    }
    return _showCart;
}


- (LXBShowRemark *)showRemak
{
    if (_showRemak == nil) {
        _showRemak = [[LXBShowRemark alloc] init];
        [self.contentView addSubview:_showRemak];
        [_showRemak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftImage.mas_bottom).with.equalTo(@0);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.left.equalTo(self.contentView).with.offset(10);
            make.height.mas_equalTo(30);
        }];
        
    }
    return _showRemak;
}

- (void)setUIChangeFunction
{
    
    switch (_LXBCarTableCellType) {
        case 1:
        {
            self.numberShow.hidden = NO;
            self.showCart.hidden = NO;
            self.showRemak.hidden = YES;
        }
            break;
        case 2:
        {
            self.numberShow.hidden = NO;
            self.showCart.hidden = YES;
            self.showRemak.hidden = NO;
        }
            break;
        default:
            break;
    }
    if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 2) {
        self.showCart.hidden = YES;
    }
    if ([[BFUserSignelton shareBFUserSignelton].isPay integerValue] == 1) {
        self.showCart.hidden = YES;
        
    }
}
- (void)setLXBCarTableCellType:(NSInteger)LXBCarTableCellType{
    _LXBCarTableCellType = LXBCarTableCellType;
    [self setUIChangeFunction];
}

- (void)setDishesModel:(LXBCookingdetailModel *)dishesModel
{
    _dishesModel = dishesModel;
//    [self testDataFunciton];
//    self.leftImage sd_setImageWithURL:[NSURL URLWithString:_dishesModel.]
    self.nameLabel.text = _dishesModel.name;
    self.priceLabel.text = _dishesModel.price;
    self.numberShow.numLabel.text = [NSString stringWithFormat:@"%@",_dishesModel.quantity];
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:[_dishesModel.pic_url lastObject]]];
    self.showRemak.remarkLabel.text = [NSString stringWithFormat:@"撤销备注:%@",dishesModel.remark];
	self.showCart.dishesModel = dishesModel;
    [self.showRemak mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self getHeight:dishesModel.remark] + 18);
    }];
    
}

//计算高度
-(float)getHeight:(NSString *)content{
    float width=[UIScreen mainScreen].bounds.size.width - 20;
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_FONTSIZE_a2]} context:nil].size;
    return size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

#pragma mark - 显示菜品的数量
@interface LXBShowNumber ()

@end
@implementation LXBShowNumber

- (instancetype)init
{
    if (self = [super init]) {
        [self createViewFunction];
    }
    return self;
}

- (void)createViewFunction
{
    _numLabel = [[UILabel alloc] init];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    _numLabel.layer.borderWidth = 1.0;
    
    [self addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
}

@end

#pragma mark - 显示购物车的图片
@implementation LXBShowCart



- (instancetype)init
{
    if (self = [super init]) {
        [self createViewFunction];
    }
    return self;
}

- (void)createViewFunction
{
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setImage:[UIImage imageNamed:@"shanchu_1"] forState:UIControlStateNormal];
    [self addSubview:delButton];
    [delButton addTarget:self action:@selector(clickAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];

    
}
//删除;
- (void)clickAddAction:(UIButton *)sender
{
//    NSLog(@"删除...");
	
	if (_editButtonAction) {
		_editButtonAction(self.dishesModel.dishesID);
	}

}

@end

#pragma mark -展示
@implementation LXBShowRemark

- (instancetype)init
{
    if (self = [super init]) {
        [self createViewFuction];
    }
    return self;
}

- (void)createViewFuction
{
    _remarkLabel = [[UILabel alloc] init];
    _remarkLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    _remarkLabel.numberOfLines = 0;
    _remarkLabel.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_remarkLabel];
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

@end
