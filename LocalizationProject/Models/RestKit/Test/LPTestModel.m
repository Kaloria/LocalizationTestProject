//
//  LPTestModel.m
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import "LPTestModel.h"
#import "LPTestModelResult.h"

@implementation LPTestModel

+ (RKResponseDescriptor *)testModelMapping{
    RKObjectMapping* testMapping = [RKObjectMapping mappingForClass:[LPTestModelResult class]];
    
    [testMapping addAttributeMappingsFromDictionary:@{@"text":@"text",
                                                      @"image":@"image"
                                                      }];
    
    RKObjectMapping* locationMapping = [RKObjectMapping mappingForClass:[LPLocationModel class] ];
    [locationMapping addAttributeMappingsFromDictionary:@{@"latitude": @"latitude",
                                                          @"longitude": @"longitude",}];
    
    
    [testMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location"
                                                                                toKeyPath:@"location"
                                                                              withMapping:locationMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:testMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/u/6556265/test.json"
                                                                                           keyPath:@""
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

@end
