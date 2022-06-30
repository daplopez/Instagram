//
//  ProfileCollectionViewCell.h
//  Instagram
//
//  Created by Daphne Lopez on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *userPost;

@end

NS_ASSUME_NONNULL_END
