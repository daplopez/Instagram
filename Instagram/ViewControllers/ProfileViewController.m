//
//  ProfileViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/29/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (PFUser.currentUser) {
        //[self.profileImage setImage:PFUser.currentUser[@"image"]];
        self.usernameLabel.text = PFUser.currentUser[@"username"];
    }
    
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
