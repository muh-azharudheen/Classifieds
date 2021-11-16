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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, copy) NSString *imageId;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        price:(NSString *)price
                        imageId:(NSString *)imageId;

@end

NS_ASSUME_NONNULL_END
