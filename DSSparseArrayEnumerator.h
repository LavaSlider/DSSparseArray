//
//  DSSparseArrayEnumerator.h
//  Used as the enumerator for a DSSparseArray
//
//  Functionality as documented for NSEnumerator with the addition of a method
//  to obtain the index of the object that will be returned on the next call
//  to nextObject.
//
//  Created by David W. Stockton on 5/20/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSSparseArray;

@interface DSSparseArrayEnumerator : NSEnumerator

// Of the NSEnumerationOptions, accepts only NSEnumerationReverse
+ (instancetype) enumeratorForSparseArray: (DSSparseArray *) sparseArray withOptions: (NSEnumerationOptions) options;
- (NSUInteger) indexOfNextObject;

@end
