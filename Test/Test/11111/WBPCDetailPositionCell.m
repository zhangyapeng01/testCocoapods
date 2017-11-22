//
//  WBPCDetailPositionCell.m
//  Pods
//
//  Created by zhangyapeng on 2017/9/13.
//
//

#import "WBPCDetailPositionCell.h"
#import "WBPCPositionInforModel.h"
#import "NSString+WBHelper.h"
#import "WBPCPassPositionView.h"

@interface WBPCDetailPositionCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *supplyLabel;

@property (weak, nonatomic) IBOutlet UILabel *endPositionLabel;

@property (weak, nonatomic) IBOutlet UILabel *endPositionDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *startpOSITUONdesLabel;

@property (weak, nonatomic) IBOutlet UILabel *startPositionLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vEndPositionConstrains;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vStartPositionContrains;

@end

@implementation WBPCDetailPositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
#pragma mark --- 父类方法
/*
 * 给cell 赋值
 * data 数据源，可以是字典，和 model
 * currentIndexPath 该cell 所在TableView 位置
 */
- (void)prepareCellViewWithData:(id)data
           withCurrentIndexPath:(NSIndexPath*) currentIndexPath{
    [self configCellViewData:data AtIndexPath:currentIndexPath];
}

- (void)configCellViewData:(id)data AtIndexPath:(NSIndexPath *)indexPath {
    if (data == nil || ![data isKindOfClass:[WBPCPositionInforModel class]]) {
        return;
    }
    WBPCPositionInforModel *positionmodel1 = (WBPCPositionInforModel *)data;
    self.timeLabel.text = positionmodel1.time ? positionmodel1.time: @"";
    
    NSString *carType = positionmodel1.car_type;
    NSString *car_empty_seat = positionmodel1.car_empty_seat;
    NSString *applyStr ;
    if (car_empty_seat.length > 0 && carType.length > 0)
    {
        applyStr = [NSString stringWithFormat:@"%@ %@ %@",positionmodel1.car_type,@"·",positionmodel1.car_empty_seat];
    }else if (carType.length >0 || car_empty_seat.length > 0)
    {
        applyStr = carType.length ? carType:car_empty_seat;
    }
    self.supplyLabel.text = applyStr ? applyStr: @"";
    
    self.startPositionLabel.text = positionmodel1.start_position_name ? positionmodel1.start_position_name: @"";
    NSString *startPositionDes = positionmodel1.start_position_detail;
    if (startPositionDes.length > 0) {
        
        self.startpOSITUONdesLabel.text = startPositionDes;
    }else
    {
        self.startpOSITUONdesLabel.text = @"";
        //  如果没有开始详细位置，将控件高度设置为0
        self.vStartPositionContrains.constant = 0;
    }
    
    self.endPositionLabel.text = positionmodel1.dest_position_name.length > 0 ? positionmodel1.dest_position_name:@"";
    NSString *endPositionDes = positionmodel1.dest_position_detail;
    if (endPositionDes.length > 0) {
        self.endPositionDesLabel.text = endPositionDes;
    }else
    {
        self.endPositionDesLabel.text = @"";
        //  如果没有目的地详细位置，将控件高度设置为0
        self.vEndPositionConstrains.constant = 0;
    }
    
    
    
    
    NSArray *arr = positionmodel1.pass_position;
    if (arr.count > 0) {
        CGFloat maxY = 0;
        
        for (NSInteger k = 0; k < arr.count; k ++)
        {
            NSString * passStr = [arr objectAtIndex:k];
            WBPCPassPositionView *cell = [[WBPCPassPositionView alloc] init];
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            //            CGSize size = [passStr wb_sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(width-30-18-10, MAXFLOAT)];
            //
            //            if (size.height <= 25){
            //                size.height = 25;
            //            }
            //            cell.frame = CGRectMake(30, 37+maxY, width-40, size.height);
            cell.frame = CGRectMake(30, 37+maxY, width-40, 25);
            
            [cell configViewWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"WBPCImages.bundle/pc_pass_position%zd",k+1]] content:passStr];
            [self.passView addSubview:cell];
            //            if (size.height > 25) {
            //                maxY += size.height;
            //            }else
            //            {
            maxY += 25;
            //            }
        }
    }else
    {
        [self.passView removeFromSuperview];
        [self.lineLabel removeFromSuperview];
    }
}

/*
 * 根据数据源 计算cell 高度
 * cellData 数据源，可以是字典，和 model
 */
+ (CGFloat)computeHeightWithCellData:(id)cellData
{
    WBPCPositionInforModel *positionmodel1 = (WBPCPositionInforModel *)cellData;
    // 计算 出发地和目的的 高度，如果没有详细路径需要把对应的 高度去掉
    CGFloat dHeight = 0;
    if (!positionmodel1.start_position_detail || positionmodel1.start_position_detail.length == 0)
    {
        dHeight -= 23;
    }
    if (!positionmodel1.dest_position_detail || positionmodel1.dest_position_detail.length == 0)
    {
        dHeight -= 23;
    }
    
    // 途经地 高度计算
    if (positionmodel1.pass_position && positionmodel1.pass_position.count > 0)
    {
        CGFloat height = 0;
        //        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        for (NSInteger k = 0; k < positionmodel1.pass_position.count; k ++)
        {
            
            //            NSString *content = [positionmodel1.pass_position objectAtIndex:k];
            //            CGSize size = [content wb_sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(width-30-18-10, MAXFLOAT)];
            //            if (size.height > 25) {
            //                height += size.height;
            //            }else
            //            {
            height += 25;
            //            }
        }
        return 158 + height +5 +10 + 32+dHeight;
    }
    return 157+dHeight;
}

@end
