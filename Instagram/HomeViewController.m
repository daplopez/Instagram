//
//  HomeViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/27/22.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "PostTableViewCell.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"


@interface HomeViewController ()
@property (strong, nonatomic) NSArray *feedPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self queryImages];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
    [self.tableView reloadData];
    
}

- (void)onTimer {
   // Add code to be run periodically
    [self queryImages];
}


- (void) queryImages {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.feedPosts = posts;
            [self.tableView reloadData];
            NSLog(@"Successfully got posts");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
    myDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.feedPosts[indexPath.row];
    cell.feedImage.file = post[@"image"];
    [cell.feedImage loadInBackground];
    cell.caption.text = post[@"caption"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPosts.count;
}

@end
