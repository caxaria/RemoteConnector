//
//  StorageHelper.h
//  Helpers
//
//  Created by João Caxaria on 2/22/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//



@interface StorageHelper : NSObject {

}

+ (NSString*) baseStorageDirectory;
+ (NSString*) filenameComponent:(NSString*) url;
+ (NSString*) filenameInStorage:(NSString*) filename;

@end
