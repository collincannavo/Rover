//
//  CDCPhoto.h
//  CDCRovers
//
//  Created by Collin Cannavo on 7/4/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCPhoto : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic)NSInteger identifier;
@property (nonatomic)NSInteger sol;
@property (nonatomic)NSArray<NSString *> *camera;
@property (nonatomic)NSDate *earthDate;
@property (nonatomic)NSURL *imageURL;


@end
