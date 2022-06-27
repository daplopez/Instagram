//
//  LoginViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameLabel.text;
        newUser.password = self.passwordLabel.text;
        //newUser.email = self.emailField.text;
    
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                
                // manually segue to logged in view
                [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
            }
        }];
}


- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameLabel.text;
    NSString *password = self.passwordLabel.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
                [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
            }
        }];
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
