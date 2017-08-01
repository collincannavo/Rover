//
//  MarsRoverClient.h
//  CDCRovers
//
//  Created by Collin Cannavo on 7/4/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCRover.h"
#import "CDCPhoto.h"

@interface MarsRoverClient : NSObject

-(void)fetchAllMarsRoverWithCompletion:(void (^)(NSArray *roverNames, NSError *error))completion;

-(void)fetchMissionManifestForRoverNamed:(NSString *) roverNamed completion:(void(^)(CDCRover *))completion;
-(void)fetchPhotosFromRover:(CDCRover *)rover sol:(NSInteger *)sol completion:(void(^)(NSArray<CDCPhoto * > *))completion;
-(void)fetchImageDataForPhoto:(CDCPhoto *)photo completion:(void(^)(NSData *))completion;


@end
