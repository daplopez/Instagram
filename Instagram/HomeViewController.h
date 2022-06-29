//
//  HomeViewController.h
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> //UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

NS_ASSUME_NONNULL_END
