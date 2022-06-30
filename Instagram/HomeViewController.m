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
#import "Parse/PFImageView.h"
#import "DetailsViewController.h"
#import "DateTools.h"


@interface HomeViewController ()
@property (strong, nonatomic) NSArray *feedPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
//@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self createRefreshControl];
    [self queryImages];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    [self.tableView reloadData];
    
}


- (void)createRefreshControl {
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(queryImages) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)onTimer {
    [self queryImages];
}


- (void) queryImages {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"Successfully got posts");
            self.feedPosts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"DetailsSegue"]) {
        NSIndexPath *indexPath =[self.tableView indexPathForCell:sender];
        Post *dataToPass = self.feedPosts[indexPath.row];
        UINavigationController *navVC = [segue destinationViewController];
        DetailsViewController *detailsVC = (DetailsViewController *) navVC.topViewController;
        detailsVC.curPost = dataToPass;
    }
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.feedPosts[indexPath.row];
    cell.feedImage.file = post[@"image"];
    [cell.feedImage loadInBackground];
    cell.caption.text = post[@"caption"];
    cell.timeStampLabel.text = post.createdAt.shortTimeAgoSinceNow;
    PFUser *user = post.author;
    cell.usernameLabel.text = user.username;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPosts.count;
}

@end
