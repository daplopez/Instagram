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
    
    [self settingViewProperties];
}

- (void)settingViewProperties {
    [self settingImage];
    self.captionLabel.text = self.curPost[@"caption"];
    self.timeStampLabel.text = self.curPost.createdAt.shortTimeAgoSinceNow;
}

- (void)settingImage {
    self.postImage.file = self.curPost[@"image"];
    [self.postImage loadInBackground];
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
