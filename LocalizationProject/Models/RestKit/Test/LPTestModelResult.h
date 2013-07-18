//
//  LPTestModelResult.h
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPLocationModel.h"

@interface LPTestModelResult : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) LPLocationModel *location;

@end
