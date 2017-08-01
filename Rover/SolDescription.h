//
//  SolDescription.h
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly)NSInteger sol;
@property (nonatomic, readonly)NSInteger numberOfPhotos;
@property (nonatomic, readonly, strong) NSArray *cameras;


@end
