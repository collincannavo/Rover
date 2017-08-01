//
//  CDCRoverController.m
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import "CDCRoverController.h"
#import "CDCMarsRoverClient.h"
#import "Rover-Swift.h"
#import "Rover.h"

static NSString * const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";

@interface CDCRoverController()

@property (nonatomic, strong) NSMutableArray *roverArray;

@end

@implementation CDCRoverController

+ (CDCRoverController *)sharedInstance
{
    
    static CDCRoverController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedInstance = [CDCRoverController new];
        
    });
    return sharedInstance;
}

-(instancetype)init
{
    
    self = [super init];
    if (self) {
        _roverArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (void)fetchRovers:(NSString *)name completion:(void(^_Nullable) (Rover * _Nullable)) completion
{
    
    if (!completion) { completion = ^(Rover *p) { }; }
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *url = [baseURL URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:@""];
    
    [NetworkController performRequestForURL: url withMethod:@"GET" urlParameters:nil body: nil completion: ^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"There was an error getting a Rover %@", error);
            completion(nil);
            return;
        }
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (!dictionary || ![dictionary isKindOfClass: [NSDictionary class]]) {
            NSLog(@"Error parsing json: %@", error);
            completion(nil);
            return;
        }
        
        Rover *rover = [[Rover alloc] initWithDictionary:dictionary];
        completion(rover);
        
    }];
    
}

- (NSArray *)rovers { return self.roverArray; }

@end

