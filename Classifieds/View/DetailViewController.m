//
//  DetailViewController.m
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

#import "DetailViewController.h"
#import "Classifieds-Swift.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
    [self populateView];
}

-(void) setupViews {
    self.labelTitle.font = [UIFont cFontWith: 24];
    self.labelSubTitle.font = [UIFont cFontWith: 14];
    self.labelPrice.font =  [UIFont cFontWith: 24];
    self.buttonBuyNow.titleLabel.font = [UIFont cFontWith: 18];
    self.buttonBuyNow.backgroundColor = [UIColor primaryTint];
    [self.buttonBuyNow setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    self.buttonBuyNow.layer.cornerRadius = self.buttonBuyNow.frame.size.height / 2;
    self.buttonBuyNow.clipsToBounds = YES;
    [self.buttonBuyNow setTitle: @"Buy Now" forState: UIControlStateNormal];
}

-(void) populateView {
    
}

@end
