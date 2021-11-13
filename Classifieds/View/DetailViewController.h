//
//  DetailViewController.h
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonBuyNow;
@property (nonatomic, strong) DetailViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
