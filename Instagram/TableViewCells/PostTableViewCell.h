//
//  PostTableViewCell.h
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *feedImage;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

NS_ASSUME_NONNULL_END
