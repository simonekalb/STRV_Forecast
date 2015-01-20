//
//  SKSettings.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettings.h"

@implementation SKSettings

static SKSettings* _sharedInstance;

+(SKSettings *) sharedInstance {
    if ( !_sharedInstance ) {
        _sharedInstance = [[SKSettings alloc] init];
    }
    return _sharedInstance;
}

#pragma mark - iPhone,iPad, iOS and Retina recognizing utilities

-(BOOL)isRetina{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
        && [[UIScreen mainScreen] scale] == 2.0) {
        return  YES;
    } else {
        return NO;
    }
}

-(BOOL)isiOS7 {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

-(BOOL)isiOS6{
    return [[UIApplication sharedApplication] respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)];
}

-(BOOL)isiPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

-(BOOL)isiPhone {
    return !IS_IPAD;
}

-(BOOL)isiPhone4 {
    return !IS_IPHONE5;
}

-(BOOL)isiPhone5 {
    return [[UIScreen mainScreen] bounds].size.height == 568;
}

#pragma mark - Database support function

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            DDLogInfo(@"You successfully saved your context.");
        }
        else if (error) {
            DDLogError(@"Error saving context: %@", error.description);
        }
    }];
}

@end
