//
//  CDCSolDescription.h
//  CDCRovers
//
//  Created by Collin Cannavo on 7/4/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCSolDescription : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic)NSInteger sol;
@property (nonatomic)NSInteger numberOfPhotos;
@property (nonatomic)NSArray<NSString *> *cameras;


@end
