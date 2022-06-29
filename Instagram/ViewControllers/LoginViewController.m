//
//  LoginViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)goToHomeScreen {
    // manually segue to logged in view
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
}

- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
        
    // set user properties
    newUser.username = self.usernameLabel.text;
    newUser.password = self.passwordLabel.text;
    //newUser.email = self.emailField.text;
    
    if ([self.usernameLabel.text isEqual:@""] || [self.passwordLabel.text isEqual:@""]) {
        [self emptyField];
    }
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self goToHomeScreen];
            //[self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
    }];
}


- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameLabel.text;
    NSString *password = self.passwordLabel.text;
        
    if ([self.usernameLabel.text isEqual:@""] || [self.passwordLabel.text isEqual:@""]) {
        [self emptyField];
    }
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            //[self performSegueWithIdentifier:@"LoginSegue" sender:nil];
            [self goToHomeScreen];
        }
    }];
}

- (void)emptyField {
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Required field cannot be empty" preferredStyle:(UIAlertControllerStyleAlert)];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // handle cancel response here. Doing nothing will dismiss the view.
            
        }];
        // add the cancel action to the alertController
        [alert addAction:cancelAction];

        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
        }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
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
