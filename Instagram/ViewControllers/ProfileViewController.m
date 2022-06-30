//
//  ProfileViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/29/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "ProfileCollectionViewCell.h"
#import "Post.h"
#import "Parse/PFImageView.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    if (PFUser.currentUser) {
        self.usernameLabel.text = PFUser.currentUser[@"username"];
    }
    
    [self queryImages];
    
}


- (void) queryImages {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:PFUser.currentUser.username];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSLog(@"Successfully got posts");
            self.userPosts = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


- (IBAction)didTapChange:(id)sender {
    [self useCamera];
}

- (void)useCamera {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so check that the camera is supported on device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        [self cameraUnavailableAlert:imagePickerVC];
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)cameraUnavailableAlert: (UIImagePickerController *) imagePickerVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera not available" message:@"Defaulting to photo library" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // present the photo library instead
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    CGRect bounds = UIScreen.mainScreen.bounds;
    CGFloat width = bounds.size.width;
    if(editedImage) {
        self.profileImage.image = [self resizeImage:editedImage withSize:CGSizeMake(width, width)];
    } else {
        self.profileImage.image = [self resizeImage:originalImage withSize:CGSizeMake(width, width)];
    }
        
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"profileCollectionViewCell" forIndexPath:indexPath];
    
    Post *post = self.userPosts[indexPath.row];
    cell.userPost.file = post[@"image"];
    [cell.userPost loadInBackground];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // Setting the poster size in collection view
    return CGSizeMake(130, 130);
}

@end
