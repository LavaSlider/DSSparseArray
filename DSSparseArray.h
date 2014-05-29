//
//  DSSparseArray.h
//  DSSparseArray and DSMutableSparseArray are replacements for NSArray and
//  NSMutableArray that allow sparse arrays (i.e., arrays with empty entries)
//
//  Created by David W. Stockton on 5/10/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSSparseArrayEnumerator.h"

// Values used to control when exceptions are generated
typedef enum : unsigned int {
	IndexOutOfRangeNoThrowNoWarn = 0, // No exception, non-empty entries that are shifted < 0 or > NSNotFound-1 just disappear
	IndexOutOfRangeNoThrowButLogWarning = 1, // Like above except warnings placed by NSLog()
	IndexOutOfRangeThrowIfNonEmpty = 2, // Throws if non-empty entry index < 0 or > NSNotFound-1
	IndexOutOfRangeThrowIfAny = 3, // Throws for shift>start or start+shift>NSNotFound-1
} DSSparseArrayExceptionThrowMode;

/****************	Immutable Sparse Array	****************/

@interface DSSparseArray : NSObject <NSObject, NSCopying, NSMutableCopying, NSSecureCoding>

- (NSUInteger) count;
- (id) objectAtIndex: (NSUInteger) index;
- (NSUInteger) indexOfObject: (id) anObject;
- (NSUInteger) indexOfObjectIdenticalTo: (id) anObject;
- (DSSparseArrayEnumerator *) objectEnumerator;
- (DSSparseArrayEnumerator *) reverseObjectEnumerator;

+ (void) setThrowExceptionOnIndexOutOfRange: (unsigned int) throwMode;

@end

@interface DSSparseArray (DSExtendedSparseArray)

- (BOOL) containsObject: (id) anObject;
- (NSIndexSet *) allIndexes;
- (NSIndexSet *) allIndexesForObject: (id) anObject;
- (id) firstObject;
- (id) lastObject;
- (NSArray *) allObjects;
- (void) getObjects: (__unsafe_unretained id []) objects andIndexes: (NSUInteger []) indexes;
- (BOOL) isEqualToSparseArray: (DSSparseArray *) otherSparseArray;
- (DSSparseArray *) objectsAtIndexes: (NSIndexSet *) indexes;
- (DSSparseArray *) objectsAtIndexes: (NSIndexSet *) indexes notFoundMarker: (id) anObjectOrNil;
- (id) valueAtIndex: (NSUInteger) index;
- (DSSparseArray *) filteredSparseArrayUsingPredicate: (NSPredicate *) predicate;
- (BOOL) writeToFile: (NSString *) path atomically: (BOOL) atomically;
- (BOOL) writeToURL: (NSURL *) url atomically: (BOOL) atomically;


#if NS_BLOCKS_AVAILABLE
- (void) enumerateIndexesAndObjectsUsingBlock: (void (^)( id obj, NSUInteger idx, BOOL *stop )) block;
- (void) enumerateIndexesAndObjectsWithOptions: (NSEnumerationOptions) opts usingBlock: (void (^)( id obj, NSUInteger idx, BOOL *stop )) block;
- (NSIndexSet *) indexesOfEntriesWithOptions: (NSEnumerationOptions) opts passingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop )) predicate;
- (NSIndexSet *) indexesOfEntriesPassingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop) ) predicate;
#endif

@end

@interface DSSparseArray (DSSparseArrayCreation)

+ (instancetype) sparseArray;
+ (instancetype) sparseArrayWithArray: (NSArray *) array;
+ (instancetype) sparseArrayWithSparseArray: (DSSparseArray *) otherSparseArray;
+ (instancetype) sparseArrayWithObject: (id) anObject atIndex: (NSUInteger) index;
+ (instancetype) sparseArrayWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet;
+ (instancetype) sparseArrayWithObjects: (const id[]) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count;
+ (instancetype) sparseArrayWithObjectsAndIndexes: (id) firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype) sparseArrayWithObjectsAndNSUIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype) init;
- (instancetype) initWithArray: (NSArray *) array;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray copyItems: (BOOL) flag;
- (instancetype) initWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet;
- (instancetype) initWithObjects: (const id []) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count;
- (instancetype) initWithObjectsAndIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype) initWithObjectsAndNSUIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

+ (id /* DSSparseArray * */) sparseArrayWithContentsOfFile: (NSString *) path;
+ (id /* DSSparseArray * */) sparseArrayWithContentsOfURL: (NSURL *) url;
- (id /* DSSparseArray * */) initWithContentsOfFile: (NSString *) path;
- (id /* DSSparseArray * */) initWithContentsOfURL: (NSURL *) url;

@end

/****************	Mutable Sparse Array	****************/
//
//  Things to understand:
//    Insertion shifts the indexes higher of everything at and beyond the insert point
//    Setting over-writes or creates the entry, no shifting
//	(can be set to nil since this is a sparse array)
//    Remove shifts the indexes lower of everything after the remove point

@interface DSMutableSparseArray : DSSparseArray

- (void) setObject: (id) anObject atIndex: (NSUInteger) index;
- (void) insertObject: (id) object atIndex: (NSUInteger) index;
- (void) removeObjectAtIndex: (NSUInteger) index;
- (void) removeObject: (id) anObject;
- (void) shiftObjectsStartingAtIndex: (NSUInteger) startIndex by: (NSInteger) delta;

@end

@interface DSMutableSparseArray (DSExtendedMutableSparseArray)

- (void) setValue: (id) value atIndex: (NSUInteger) index;
- (void) setObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
- (void) setObjectsFromSparseArray: (DSSparseArray *) otherSparseArray;
- (void) clearObjectAtIndex: (NSUInteger) index;
- (void) clearObjectsAtIndexes: (NSIndexSet *) indexes;
- (void) insertObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
- (void) removeObjectsAtIndexes: (NSIndexSet *) indexSet;
- (void) removeObjectsInRange: (NSRange) aRange;
- (void) removeObjectsInArray: (NSArray *) array;
- (void) removeLastObject;
- (void) removeAllObjects;

- (void) filterUsingPredicate: (NSPredicate *) predicate;
- (void) setSparseArray: (DSSparseArray *) otherSparseArray;

@end

@interface DSMutableSparseArray (DSMutableSparseArrayCreation)

+ (instancetype) sparseArrayWithCapacity: (NSUInteger) numItems;

- (instancetype) init;
- (instancetype) initWithCapacity: (NSUInteger) numItems;

@end
