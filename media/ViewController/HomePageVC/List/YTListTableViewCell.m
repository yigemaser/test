//
//  YTListTableViewCell.m
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTListTableViewCell.h"

@implementation YTListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)cellForRow:(YTListObj *)aDic
{
    if ([aDic.contentByTrue isEqualToString:@""]) {
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + 10, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        self.timeByTrue.frame = CGRectMake(self.timeByTrue.frame.origin.x, self.timeByTrue.frame.origin.y - 10, self.timeByTrue.frame.size.width, self.timeByTrue.frame.size.height);
    }


  
    self.titleLabel.text = aDic.titleLabel;
    self.contentByTrue.text = aDic.contentByTrue;
    self.smallImgByTrue.contentMode = UIViewContentModeScaleAspectFit;
    if (![aDic.smallImgByTrue isEqualToString:@""]) {
        [self.smallImgByTrue setImageWithURL:[NSURL URLWithString:aDic.smallImgByTrue]];
    }

    self.timeByTrue.text =[self zoneChange:[aDic.timeByTrue doubleValue]/1000];
}

-(void)cellForRowByCollction:(YTListObj *)aDic
{
    self.titleLabel.text = aDic.titleLabel;
    self.contentByTrue.text = aDic.contentByTrue;
    self.smallImgByTrue.contentMode = UIViewContentModeScaleAspectFit;
    if (![aDic.smallImgByTrue isEqualToString:@""]) {
        [self.smallImgByTrue setImageWithURL:[NSURL URLWithString:aDic.smallImgByTrue]];
    }
    self.smallImgByTrue.frame = CGRectMake(IS_IOS7?5:0, 7, 80, 60);
    self.timeByTrue.text =aDic.timeByTrue;
}

-(NSString *)zoneChange:(double)spString{
    NSTimeInterval timeI = spString;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeI];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [formatter dateFromString:currentTime];
    
    NSString * str =[NSString stringWithFormat:@"%@",[formatter stringFromDate:date2]];
    return str;
}

-(void)cellForRowByFalse:(YTListObj *)aDic
{
    self.SmallImgByFalse.contentMode = UIViewContentModeScaleAspectFit;
    [self.SmallImgByFalse setImageWithURL:[NSURL URLWithString:aDic.smallImgByTrue]];
    self.numByFalse.text = [NSString stringWithFormat:@"%@",aDic.number];
    self.fuzhuangByFalse.text = aDic.titleLabel;
}
@end
