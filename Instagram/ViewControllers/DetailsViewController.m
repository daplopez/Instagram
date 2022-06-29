//
//  DetailsViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/28/22.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set image
    self.postImage.file = self.curPost[@"image"];
    [self.postImage loadInBackground];
    // set caption and time stamp
    self.captionLabel.text = self.curPost[@"caption"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    self.timeStampLabel.text = self.curPost.createdAt.shortTimeAgoSinceNow;
    
    
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
