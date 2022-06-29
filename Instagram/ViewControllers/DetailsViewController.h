//
//  DetailsViewController.h
//  Instagram
//
//  Created by Daphne Lopez on 6/28/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Parse/PFImageView.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post* curPost;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

NS_ASSUME_NONNULL_END
