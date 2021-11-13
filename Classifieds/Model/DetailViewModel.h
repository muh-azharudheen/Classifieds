//
//  DetailViewModel.h
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DetailViewModel;

@interface DetailViewModel : NSObject

@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *subTitle;
@property (nonatomic, assign) NSString *price;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        price:(NSString *)price;

@end

NS_ASSUME_NONNULL_END
