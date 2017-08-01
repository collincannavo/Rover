//
//  CDCMarsRoverClient.m
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import "CDCMarsRoverClient.h"
#import "Rover.h"
#import "Photo.h"


@implementation CDCMarsRoverClient

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray *roverNames, NSError *error))completion
{
    
    NSURL *url = [[self class] roversEndpoint];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error) {
            return completion(nil,error);
        }
        if (!data) {
            return completion(nil, error);
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
        NSArray *roverDicts = nil;
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]] || !(roverDicts = jsonDict[@"rovers"])) {
            NSDictionary *userInfo = nil;
            if (error) { userInfo = @{NSUnderlyingErrorKey : error}; }
            NSLog(@"Error parsing json: %@", error);
            return completion(nil, error);
        }
        
        NSMutableArray *roverNames = [NSMutableArray array];
        for (NSDictionary *dict in jsonDict) {
            NSString *name = dict[@"name"];
            if (name) {[roverNames addObject:name]; }
        }
        
        completion(nil, error);
        
    }] resume];
}

- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(Rover *rover, NSError *error))completion
{
    
    NSURL *url = [[self class] URLForInfoForRover:name];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return completion(nil, error);
        }
        if (!data) {
            return completion(nil, error);
        }
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *manifest = nil;
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]] || !(manifest = dictionary[@"photo_manifest"])) {
            NSLog(@"Error parsing json: %@", error);
            return completion(nil, error);
        }
    completion([[Rover alloc] initWithDictionary:dictionary], nil);
        
    }] resume];
    
}

- (void)fetchPhotosFromRover:(Rover *)rover sol:(NSInteger *)sol completion:(void(^)(NSArray *photos, NSError *error))completion
{
    
    NSURL *url = [[self class] urlForPhotosFromRover:rover.name onSol:*sol];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error recovering photos");
            return completion(nil, error);
        }
        
        if (!data) {
            NSLog(@"There was an error getting data");
            return completion(nil, error);
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error parsing the json: %@", error);
            return completion(nil, error);
        }
        
        NSArray *photosDictionaries = jsonDict[@"photos"];
        NSMutableArray *photos = [NSMutableArray alloc];
        for (NSDictionary *dict in photosDictionaries) {
            Photo *photo = [[Photo alloc]initWithDictionary:dict];
             [photos addObject:photo];
        }
    }] resume];
    
}

- (void)fetchImageDataForPhoto:(Photo *)photo completion:(void(^)(NSData *imageData, NSError *error))completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:photo.imageURL resolvingAgainstBaseURL:YES];
    urlComponents.scheme = @"https";
    NSURL *imageURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error obtaining photos");
            return completion(nil, error);
        }
        
        if (!data) {
            NSLog(@"There was an error obtaining photos");
            return completion(nil, error);
        }
        
        completion(nil, error);
    }] resume];
    
}


+ (NSString *)apiKey {
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
        if (!apiKeysURL) {
            NSLog(@"Error! APIKeys file not found!");
            return;
        }
        NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeysURL];
        apiKey = apiKeys[@"APIKey"];
    });
    return apiKey;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString: @"https://api.nasa.gov/mars-photos/api/v1"];
}

+ (NSURL *)URLForInfoForRover:(NSString *)roverName
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    
    return urlComponents.URL;
    
}


+ (NSURL *)urlForPhotosFromRover:(NSString *)roverName onSol:(NSInteger)sol
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"sol" value:[@(sol) stringValue]],
                                 [NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
   
    return urlComponents.URL;
    
}

+ (NSURL *)roversEndpoint
{
    NSURL *url = [[self baseURL] URLByAppendingPathComponent:@"rovers"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
    
    
}


@end








