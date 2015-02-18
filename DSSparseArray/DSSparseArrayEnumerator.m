//
//  DSSparseArrayEnumerator.m
//  A component of DSSparseArray
//
//  Created by David W. Stockton on 5/20/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import "DSSparseArrayEnumerator.h"
#import "DSSparseArray.h"

@interface DSSparseArrayEnumerator ()
@property (nonatomic, strong) DSSparseArray *theSparseArray;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) BOOL reverse;
@end

@implementation DSSparseArrayEnumerator

// Of the NSEnumerationOptions, accepts only NSEnumerationReverse
+ (instancetype) enumeratorForSparseArray: (DSSparseArray *) sparseArray withOptions: (NSEnumerationOptions) opts {
	DSSparseArrayEnumerator *enumerator = [[DSSparseArrayEnumerator alloc] init];
	enumerator.theSparseArray = sparseArray;
	if( !sparseArray ) {
		enumerator.currentIndex = NSNotFound;
	} else if( opts & NSEnumerationReverse ) {
		enumerator.currentIndex = [[sparseArray allIndexes] lastIndex];
		enumerator.reverse = 1;
	} else {
		enumerator.currentIndex = [[sparseArray allIndexes] firstIndex];
	}
	return enumerator;
}
// Return the index for the next object from the sparse array but don't advance
- (NSUInteger) indexOfNextObject {
	return self.currentIndex;
}
// Return the next object from the sparse array and advance the pointer
- (id) nextObject {
	id obj = nil;
	if( self.currentIndex != NSNotFound ) {
		obj = [self.theSparseArray objectAtIndex: self.currentIndex];
		if( self.reverse )
			self.currentIndex = [[self.theSparseArray allIndexes] indexLessThanIndex: self.currentIndex];
		else	self.currentIndex = [[self.theSparseArray allIndexes] indexGreaterThanIndex: self.currentIndex];
	}
	return obj;
}
// Return the rest of the objects, not really all of the objects
- (NSArray *) allObjects {
	if( self.currentIndex != NSNotFound ) {
		NSMutableArray *all = [NSMutableArray arrayWithCapacity: [self.theSparseArray count]];
		id obj;
		while( (obj = [self nextObject]) != nil ) {
			[all addObject: obj];
		}
		return [all copy];
	}
	return nil;
}

@end
