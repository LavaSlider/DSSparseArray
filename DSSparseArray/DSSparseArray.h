//
//  DSSparseArray.h
//  DSSparseArray
//
//  Created by David W. Stockton on 5/10/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import <Foundation/Foundation.h>

/****************	Immutable Sparse Array	****************/

@interface DSSparseArray : NSObject

- (NSUInteger) count;
- (id) objectAtIndex: (NSUInteger) index;
- (NSUInteger) indexOfObject: (id) anObject;
- (NSUInteger) indexOfObjectIdenticalTo: (id) anObject;
- (NSEnumerator *) objectEnumerator;
//- (NSEnumerator *) indexEnumerator;

@end

@interface DSSparseArray (DSExtendedSparseArray)

- (NSIndexSet *) allIndexes;
- (NSIndexSet *) allIndexesForObject: (id) anObject;
- (NSArray *) allValues;
- (void) getObjects: (__unsafe_unretained id []) objects andIndexes: (NSUInteger []) indexes;
- (BOOL) isEqualToSparseArray: (DSSparseArray *) otherSparseArray;
- (DSSparseArray *) objectsForIndexes: (NSIndexSet *) indexes notFoundMarker: (id) anObject;
- (id) valueAtIndex: (NSUInteger) index;
//- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject;

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
+ (instancetype) sparseArrayWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype) init;
- (instancetype) initWithArray: (NSArray *) array;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray copyItems: (BOOL) flag;
- (instancetype) initWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet;
- (instancetype) initWithObjects: (const id []) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count;
- (instancetype) initWithObjectsAndIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype) initWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

@end

/****************	Mutable Sparse Array	****************/
//
//  Things to understand:
//    Insertion shifts the indexes
//    Setting over-writes or create the entry, no sifting
//	(can be set to nil since this is a sparse array)
//    Remove shifts the indexes

@interface DSMutableSparseArray : DSSparseArray

- (void) setObject: (id) anObject atIndex: (NSUInteger) index;
- (void) insertObject: (id) object atIndex: (NSUInteger) index;
- (void) removeObjectAtIndex: (NSUInteger) index;
- (void) shiftObjectsStartingAtIndex: (NSUInteger) startIndex by: (NSInteger) delta;

// Additions to consider from NSMutableArray:
//- (void) addObject: (id) anObject;		  // Append to the end of the array
//- (void) addObjectsFromArray: (NSArray *) otherArray;  // Append multiple entries to the end of the array
//- (void)removeLastObject;
//- (void)removeObject:(id)anObject;
//- (void)removeObject:(id)anObject inRange:(NSRange)aRange
//- (void)removeObjectsInArray:(NSArray *)otherArray
//- (void)removeObjectsInRange:(NSRange)aRange
//- (void)filterUsingPredicate:(NSPredicate *)predicate

@end

@interface DSMutableSparseArray (DSExtendedMutableSparseArray)

- (void) setValue: (id) value atIndex: (NSUInteger) index;
- (void) setObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
- (void) insertObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
- (void) removeObjectsAtIndexes: (NSIndexSet *) indexSet;
- (void) removeAllObjects;

- (void) setSparseArray: (DSMutableSparseArray *) otherSparseArray;
- (void) addEntriesFromSparseArray: (DSMutableSparseArray *) otherSparseArray;  // What does this do? Append the objects? Set the objects?
@end

@interface DSMutableSparseArray (DSMutableSparseArrayCreation)

+ (instancetype) sparseArrayWithCapacity: (NSUInteger) numItems;

- (instancetype) init;
- (instancetype) initWithCapacity: (NSUInteger) numItems;

@end
