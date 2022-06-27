//
//  HomeViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTapLogout:(id)sender {
    // Logout current user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    // Return to Login screen
    //[self dismissViewControllerAnimated:YES completion:nil];
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];;
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
