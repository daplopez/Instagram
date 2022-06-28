//
//  DetailsViewController.m
//  Instagram
//
//  Created by Daphne Lopez on 6/28/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //set image
    self.postImage.file = self.curPost[@"image"];
    [self.postImage loadInBackground];
    // set caption and time stamp
    self.captionLabel.text = self.curPost[@"caption"];
    
    
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
