//
//  PhotoViewController.h
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageToPost;
@property (weak, nonatomic) IBOutlet UITextField *imageCaption;

@end

NS_ASSUME_NONNULL_END
