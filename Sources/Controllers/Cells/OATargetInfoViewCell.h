//
//  OATargetInfoViewCell.h
//  OsmAnd
//
//  Created by Alexey Kulish on 23/05/16.
//  Copyright © 2016 OsmAnd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OATargetInfoViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconView;
@property (nonatomic, readonly) BOOL collapsable;
@property (weak, nonatomic) UIView *collapsableView;

- (void)setCollapsed:(BOOL)collapsed rawHeight:(int)rawHeight;
- (void)resetCollapsable;

@end
