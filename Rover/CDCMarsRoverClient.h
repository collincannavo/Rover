//
//  CDCMarsRoverClient.h
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;
@class Photo;

@interface CDCMarsRoverClient : NSObject

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray *roverNames, NSError *error))completion;
- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(Rover *rover, NSError *error))completion;
- (void)fetchPhotosFromRover:(Rover *)rover sol:(NSInteger *)sol completion:(void(^)(NSArray *photos, NSError *error))completion;
- (void)fetchImageDataForPhoto:(Photo *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;


@end
//baseURL = https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos
// APIKey = WXxbwVCJN1zf3AU1x7RF1HocKnWuf39NiRoFQ9o3

