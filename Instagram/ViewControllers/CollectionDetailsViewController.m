//
//  CollectionDetailsViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/30/22.
//

#import "CollectionDetailsViewController.h"
#import "Parse/PFImageView.h"
#import "DateTools.h"

@interface CollectionDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *collectionDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

@implementation CollectionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionDetailImage.file = self.post[@"image"];
    [self.collectionDetailImage loadInBackground];
    
    self.captionLabel.text = self.post[@"caption"];
    
    self.timeStampLabel.text = self.post.createdAt.shortTimeAgoSinceNow;
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
