//
//  DetailViewModel.m
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

- (id) init {
    self = [super init];
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        price:(NSString *)price; {
    self = [super init];
    if (self) {
        _title = title;
        _subTitle = subTitle;
        _price = price;
    }
    return self;
}

@end
