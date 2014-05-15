//
//  DSSparseArray.m
//  DSSparseArray
//
//  Created by David W. Stockton on 5/10/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import "DSSparseArray.h"
@class DSSparseArray;

#define NSINDEXSET_ENUMERATE_BUG	1

#pragma mark - The Sparse Array Enumerator Implementation
@interface DSSparseArrayEnumerator : NSEnumerator
@property (nonatomic, strong) DSSparseArray *theSparseArray;
@property (nonatomic, assign) NSUInteger currentIndex;
@end

@implementation DSSparseArrayEnumerator
+ (instancetype) enumeratorForSparseArray: (DSSparseArray *) sparseArray {
	DSSparseArrayEnumerator *enumerator = [[[self class] alloc] init];
	enumerator.theSparseArray = sparseArray;
	enumerator.currentIndex = [[sparseArray allIndexes] firstIndex];
	return enumerator;
}
- (id) nextObject {
	id obj = nil;
	if( self.currentIndex != NSNotFound ) {
		obj = [self.theSparseArray objectAtIndex: self.currentIndex];
		self.currentIndex = [[self.theSparseArray allIndexes] indexGreaterThanIndex: self.currentIndex];
	}
	return obj;
}
- (NSArray *) allObjects {
	if( self.currentIndex != NSNotFound ) {
		NSMutableArray *all = [NSMutableArray arrayWithCapacity: [self.theSparseArray count]];
		id obj;
		while( (obj = [self nextObject]) != nil ) {
			[all addObject: obj];
		}
		// Return the rest of the objects
		return [all copy];
	}
	return nil;
}
@end

#pragma mark - Class extensions for private storage
static BOOL __throwException = NO;	// Have a way to change this?
@interface DSSparseArray ()
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableIndexSet *indexes;
@end

#pragma mark - Core DSSparseArray methods
@implementation DSSparseArray
- (NSUInteger) count {
	return self.dictionary.count;
}
- (id) objectAtIndex: (NSUInteger) index {
	return [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: index]];
}
- (NSUInteger) indexOfObject: (id) anObject {
	if( !anObject ) {
		NSUInteger	idx = [self.indexes firstIndex];
		if( idx > 0 && idx != NSNotFound ) {
			idx = 0;
		} else {
			idx = [self.indexes lastIndex];
			if( idx != NSNotFound )
				++idx;
		}
		return idx;
	}
#ifdef NSINDEXSET_ENUMERATE_BUG
	NSUInteger	idxOfObject = NSNotFound;
	if( self.indexes.count > 0 ) {
		NSUInteger	idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			if( [obj isEqual: anObject] ) {
				idxOfObject = idx;
				idx = NSNotFound;
			} else {
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
	}
#else
//#if NS_BLOCKS_AVAILABLE
	__block NSUInteger	idxOfObject = NSNotFound;
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		if( [obj isEqual: anObject] ) {
			idxOfObject = idx;
			*stop = YES;
		}
	}];
#endif
	return idxOfObject;
}
- (NSUInteger) indexOfObjectIdenticalTo: (id) anObject {
	if( !anObject ) {
		NSUInteger	idx = [self.indexes firstIndex];
		if( idx > 0 && idx != NSNotFound ) {
			idx = 0;
		} else {
			idx = [self.indexes lastIndex];
			if( idx != NSNotFound )
				++idx;
		}
		return idx;
	}
#ifdef NSINDEXSET_ENUMERATE_BUG
	NSUInteger	idxOfObject = NSNotFound;
	if( self.indexes.count > 0 ) {
		NSUInteger	idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			if( obj == anObject ) {
				idxOfObject = idx;
				idx = NSNotFound;
			} else {
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
	}
#else
//#if NS_BLOCKS_AVAILABLE
	__block NSUInteger	idxOfObject = NSNotFound;
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		if( obj == anObject ) {
			idxOfObject = idx;
			*stop = YES;
		}
	}];
#endif
	return idxOfObject;
}
- (NSEnumerator *) objectEnumerator {
	return [DSSparseArrayEnumerator enumeratorForSparseArray: self];
}
@end

#pragma mark - Extensions to DSSparseArray methods
@implementation DSSparseArray (DSExtendedSparseArray)
- (NSIndexSet *) allIndexes {
	return [self.indexes copy];
}
- (NSIndexSet *) allIndexesForObject: (id) anObject {
	//NSLog( @"***** Entering %s", __func__ );
	//NSLog( @"- The dictionary is: %@", self.dictionary );
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
	//NSLog( @"- Allocated an index set" );
	NSArray *keys = [self.dictionary allKeysForObject: anObject];
	//NSLog( @"- Got %lu keys from the dictionary for the object", keys.count );
	// --- What if no blocks...
	[keys enumerateObjectsUsingBlock: ^( NSNumber *key, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"- Adding index %@ to index set", key );
		[indexes addIndex: [key unsignedIntegerValue]];
	}];
	return [indexes copy];
}
- (NSArray *) allValues {
	NSUInteger	count = self.dictionary.count;
	NSUInteger	idx = [self.indexes firstIndex];
	NSMutableArray	*objects = [NSMutableArray arrayWithCapacity: count];
	for( NSUInteger i = 0; i < count; ++i ) {
		objects[i] = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
		idx = [self.indexes indexGreaterThanIndex: idx];
	}
	return [objects copy];
}
- (void) getObjects: (__unsafe_unretained id *) objects andIndexes: (NSUInteger *) indexes {
	NSUInteger	count = self.dictionary.count;
	NSUInteger	idx = [self.indexes firstIndex];
	for( NSUInteger i = 0; i < count; ++i ) {
		objects[i] = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
		indexes[i] = idx;
		idx = [self.indexes indexGreaterThanIndex: idx];
	}
}
- (BOOL) isEqualToSparseArray: (DSSparseArray *) otherSparseArray {
	if( self.indexes.count == [[otherSparseArray allIndexes] count] &&
	   [self.dictionary isEqualToDictionary: otherSparseArray.dictionary] )
		return YES;
	return NO;
}
- (DSSparseArray *) objectsForIndexes: (NSIndexSet *) indexes notFoundMarker: (id) anObject {
	NSMutableArray *objects = [NSMutableArray arrayWithCapacity: indexes.count];
	NSMutableIndexSet *setIndexes = [NSMutableIndexSet indexSet];
	[indexes enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
		id obj = [self objectAtIndex: idx];
		if( !obj ) obj = anObject;
		if( obj ) {
			[setIndexes addIndex: idx];
			[objects addObject: obj];
		}
	}];
	return [DSSparseArray sparseArrayWithObjects: objects atIndexes: setIndexes];
}
- (id) valueAtIndex: (NSUInteger) index {
	return [self objectAtIndex: index];
}

#if NS_BLOCKS_AVAILABLE
- (NSIndexSet *) indexesOfEntriesPassingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop) ) predicate {
	return [self indexesOfEntriesWithOptions: 0 passingTest: predicate];
}
- (NSIndexSet *) indexesOfEntriesWithOptions: (NSEnumerationOptions) opts passingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop )) predicate {
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
	NSSet *keys = [self.dictionary keysOfEntriesWithOptions: opts passingTest: ^BOOL( NSNumber *key, id obj, BOOL *stop ) {
		return predicate( key.unsignedIntegerValue, obj, stop );
	}];
	[keys enumerateObjectsUsingBlock: ^( NSNumber *idx, BOOL *stop ) {
		[indexes addIndex: idx.unsignedIntegerValue];
	}];
	return [indexes copy];
}
- (void) enumerateIndexesAndObjectsUsingBlock: (void (^)( id obj, NSUInteger idx, BOOL *stop )) block {
	[self enumerateIndexesAndObjectsWithOptions: 0 usingBlock: block];
}
- (void) enumerateIndexesAndObjectsWithOptions: (NSEnumerationOptions) opts usingBlock: (void (^) ( id obj, NSUInteger idx, BOOL *stop )) block {
#ifdef NSINDEXSET_ENUMERATE_BUG
	if( self.indexes.count > 0 ) {
		if( (opts & NSEnumerationReverse) != 0 ) {
			BOOL stop = NO;
			NSUInteger idx = [self.indexes lastIndex];
			while( idx != NSNotFound ) {
				id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
				block( obj, idx, &stop );
				if( stop )
					idx = NSNotFound;
				else	idx = [self.indexes indexLessThanIndex: idx];
			}
		} else {
			BOOL stop = NO;
			NSUInteger idx = [self.indexes firstIndex];
			while( idx != NSNotFound ) {
				id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
				block( obj, idx, &stop );
				if( stop )
					idx = NSNotFound;
				else	idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
	}
#else
	[self.indexes enumerateIndexesWithOptions: opts usingBlock: ^( NSUInteger idx, BOOL *stop ) {
		NSLog( @"Enumerating index %lu, NSNotFound is %lu", idx, NSNotFound );
		id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
		block( obj, idx, stop );
	}];
#endif
}
#endif
- (NSString *) description {
	NSMutableArray *contents = [NSMutableArray arrayWithCapacity: self.indexes.count];
#ifdef NSINDEXSET_ENUMERATE_BUG
	if( self.indexes.count > 0 ) {
		NSUInteger idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			[contents addObject: [NSString stringWithFormat: @"    %3lu:%@", idx, obj]];
			idx = [self.indexes indexGreaterThanIndex: idx];
		}
	}
#else
//#if NS_BLOCKS_AVAILABLE
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		[contents addObject: [NSString stringWithFormat: @"    %3lu:%@", idx, obj]];
	}];
#endif
	return [NSString stringWithFormat: @"(\n%@\n)", [contents componentsJoinedByString: @",\n"]];
}
#pragma mark - NSCopy
//// - copy
- (id) mutableCopyWithZone: (NSZone *) zone {
	DSMutableSparseArray *mutableCopy = [[DSMutableSparseArray allocWithZone: zone] init];
	if( mutableCopy ) {
		mutableCopy.indexes = [self.indexes mutableCopyWithZone: zone];
		mutableCopy.dictionary = [self.dictionary mutableCopyWithZone: zone];
	}
	return mutableCopy;
}
- (id) copyWithZone: (NSZone *) zone {
	return [self mutableCopyWithZone: zone];
}
//// - copy
@end

#pragma mark - Creation methods for DSSparseArray
@implementation DSSparseArray (DSSparseArrayCreation)

+ (instancetype) sparseArray {
	return [[[self class] alloc] init];
}
+ (instancetype) sparseArrayWithArray: (NSArray *) array {
	return [[[self class] alloc] initWithArray: array];
}

+ (instancetype) sparseArrayWithSparseArray: (DSSparseArray *) otherSparseArray {
	return [[[self class] alloc] initWithSparseArray: otherSparseArray];
}
+ (instancetype) sparseArrayWithObject: (id) anObject atIndex: (NSUInteger) index {
	return [[[self class] alloc] initWithObjectsAndIndexes: anObject, index, nil];
}
+ (instancetype) sparseArrayWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet {
	return [[[self class] alloc] initWithObjects: objects atIndexes: indexSet];
}
+ (instancetype) sparseArrayWithObjects: (const id[]) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count {
	return [[[self class] alloc] initWithObjects: objects atIndexes: indexes count: count];
}
+ (instancetype) sparseArrayWithObjectsAndIndexes: (id) firstObject, ... {
	NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	id sparseArray = [[[self class] alloc] initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: YES];
	va_end( args );
	return sparseArray;
}
+ (instancetype) sparseArrayWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... {
	NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	id sparseArray = [[[self class] alloc] initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: NO];
	va_end( args );
	return sparseArray;
}
- (instancetype) init {
	self = [super init];
	if( self ) {
		self.indexes = [[NSMutableIndexSet alloc] init];
		self.dictionary = [[NSMutableDictionary alloc] init];
	}
	return self;
}
- (instancetype) initWithArray: (NSArray *) array {
	NSRange indexRange;
	indexRange.location = 0;
	indexRange.length = array.count;
	NSIndexSet *indexes = [[NSIndexSet alloc] initWithIndexesInRange: indexRange];
	return [self initWithObjects: array atIndexes: indexes];
}
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray {
	return [self initWithSparseArray: otherSparseArray copyItems: NO];
}
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray copyItems: (BOOL) flag {
	self = [super init];
	if( self ) {
		self.indexes = [[otherSparseArray allIndexes] mutableCopy];
		NSMutableArray *keys = [NSMutableArray arrayWithCapacity: otherSparseArray.count];
		NSMutableArray *objects = [NSMutableArray arrayWithCapacity: otherSparseArray.count];
#ifdef NSINDEXSET_ENUMERATE_BUG
		if( self.indexes.count > 0 ) {
			NSUInteger idx = [self.indexes firstIndex];
			while( idx != NSNotFound ) {
				[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
				if( flag )
					[objects addObject: [[otherSparseArray objectAtIndex: idx] copy]];
				else	[objects addObject: [otherSparseArray objectAtIndex: idx]];
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
#else
		[self.indexes enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
			[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
			if( flag )
				[objects addObject: [[otherSparseArray objectAtIndex: idx] copy]];
			else	[objects addObject: [otherSparseArray objectAtIndex: idx]];
		}];
#endif
		self.dictionary = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];
	}
	return self;
}
- (instancetype) initWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet {
	self = [super init];
	if( self ) {
		self.indexes = [indexSet mutableCopy];
		NSMutableArray *keys = [NSMutableArray arrayWithCapacity: objects.count];
#ifdef NSINDEXSET_ENUMERATE_BUG
		if( self.indexes.count > 0 ) {
			NSUInteger idx = [self.indexes firstIndex];
			while( idx != NSNotFound ) {
				[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
#else
		[self.indexes enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
			[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
		}];
#endif
		self.dictionary = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];
	}
	return self;
}
- (instancetype) initWithObjects: (const id []) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count {
	NSLog( @"Entering %s", __func__ );
	self = [super init];
	if( self ) {
		NSMutableArray *keys = [NSMutableArray array];
		NSMutableArray *objectArray = [NSMutableArray array];
		NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
		for( NSUInteger i = 0; i < count; ++i ) {
			[objectArray addObject: objects[i]];	// What if it is NULL?
			[keys addObject: [NSNumber numberWithUnsignedInteger: indexes[i]]];
			[indexSet addIndex: indexes[i]];
		}
		self.indexes = indexSet;
		self.dictionary = [NSMutableDictionary dictionaryWithObjects: objectArray forKeys: keys];
	}
	return self;
}
- (instancetype) initWithObjectsAndIndexes: (id) firstObject, ... {
	NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	self = [self initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: YES];
	va_end( args );
	return self;
}
- (instancetype) initWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... {
	NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	self = [self initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: NO];
	va_end( args );
	return self;
}
- (instancetype) initWithObject: (id) firstObject indexAndObjectsAndIndexes: (va_list) args asInts: (BOOL) asInts{
	NSLog( @">>>> Entering %s", __func__ );
	self = [super init];
	if( self ) {
		NSMutableArray *keys = [NSMutableArray array];
		NSMutableArray *objects = [NSMutableArray array];
		NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
		
		id		obj = firstObject;
		NSUInteger	idx;
		do {
			if( asInts )
				idx = va_arg( args, int );
			else	idx = va_arg( args, NSUInteger );
			NSLog( @"- Index %lu gets '%@'", idx, obj );
			[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
			[objects addObject: obj];
			[indexes addIndex: idx];
			obj = va_arg( args, id );
		} while( obj != nil );
		
		self.indexes = [indexes mutableCopy];
		self.dictionary = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];
	}
	return self;
}
//- (NSArray *)keysSortedByValueUsingComparator:(NSComparator)cmptr
//- (NSArray *)keysSortedByValueUsingSelector:(SEL)comparator
//- (NSArray *)keysSortedByValueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr

@end

/****************	Mutable Sparse Array	****************/

#pragma mark - DSMutableSparseArray methods
@implementation DSMutableSparseArray
- (void) setObject: (id) anObject atIndex: (NSUInteger) index {
	// Lets make it OK to set an entry to a nil object (since we are a sparse array)
	if( anObject ) {
		[self.indexes addIndex: index];
		[self.dictionary setObject: anObject forKey: [NSNumber numberWithUnsignedInteger: index]];
	} else {
		[self.indexes removeIndex: index];
		[self.dictionary removeObjectForKey: [NSNumber numberWithUnsignedInteger: index]];
	}
}
- (void) removeObjectAtIndex: (NSUInteger) index {
	[self.dictionary removeObjectForKey: [NSNumber numberWithUnsignedInteger: index]];
	[self shiftObjectsStartingAtIndex: index+1 by: -1];
}
- (void) insertObject: (id) object atIndex: (NSUInteger) index {
	[self shiftObjectsStartingAtIndex: index by: 1];
	[self setObject: object atIndex: index];
}
// Shift range testing options:
//	1. No bounds checking, shifting items below zero or beyond the index set
//		allowable range, just deletes them (shifts them to oblivion)
//	2. Bounds checking for when a non-empty array cell goes below zero or
//		beyond the index set allowable range throws NSRangeException
//	3. Bounds checking for when even an empty array cell goes below zero or
//		beyond the index set allowable range throws NSRangeException
- (void) shiftObjectsStartingAtIndex: (NSUInteger) startIndex by: (NSInteger) delta {
	//NSLog( @"Shifting objects by %ld starting at %lu", delta, startIndex );
	if( delta == 0 || self.indexes.count == 0 ) return;
	if( delta < 0 && [self.indexes indexGreaterThanOrEqualToIndex: startIndex] < -delta ) {
		NSLog( @"**** error: delta is too small (%ld with start index of %lu) in %s",
		      delta, [self.indexes indexGreaterThanOrEqualToIndex: startIndex], __func__ );
		if( __throwException ) {
			[NSException raise: NSRangeException format: @"Shift too far negative in shiftObjectsStartingAtIndex:by:"];
		}
	}
	if( delta > 0 && [self.indexes lastIndex] > NSNotFound - delta ) {
		NSLog( @"**** error: delta is too large (%ld with last index of %lu and maximum index of %lu) in %s",
		      delta, [self.indexes lastIndex], NSNotFound - 1, __func__ );
		if( __throwException ) {
			[NSException raise: NSRangeException format: @"Shift too far in shiftObjectsStartingAtIndex:by:"];
		}
	}
	NSIndexSet *indexes = self.indexes;
	NSNumber *oldIndex;
	NSUInteger idx;
	id obj;
	if( delta < 0 ) {
		// Blank out the enries in the 'to be over written' portion since
		// empty array cells will not really over write anything
		idx = [indexes indexGreaterThanOrEqualToIndex: startIndex + delta];
		//NSLog( @"Need to clear the entries from %ld to %lu", startIndex + delta, startIndex );
		//NSLog( @"- This is actually from %lu to %lu", idx, [indexes indexLessThanIndex: startIndex] );
		while( idx != NSNotFound && idx < startIndex && idx <= [indexes indexLessThanIndex: startIndex] ) {
			//NSLog( @"Clearing the array entry at %lu before the move", idx );
			[self.dictionary removeObjectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			idx = [indexes indexGreaterThanIndex: idx];
		}
		idx = [indexes indexGreaterThanOrEqualToIndex: startIndex];
		while( idx != NSNotFound ) {
			oldIndex = [NSNumber numberWithUnsignedInteger: idx];
			obj = [self.dictionary objectForKey: oldIndex];
			//NSLog( @"Moving '%@' from index is %@ to %ld", obj, oldIndex, (idx + delta) );
			[self.dictionary removeObjectForKey: oldIndex];
			if( idx >= -delta ) {
				[self.dictionary setObject: obj forKey: [NSNumber numberWithInteger: (idx + delta)]];
			} else {
				NSLog( @"-- Negative index, so poofed %@", oldIndex );
				[self.indexes removeIndex: idx];
			}
			idx = [indexes indexGreaterThanIndex: idx];
		}
		//NSLog( @"The shifted dictionary is %@", self.dictionary );
	} else {
		idx = [indexes lastIndex];
		startIndex = [indexes indexGreaterThanOrEqualToIndex: startIndex];
		while( idx != NSNotFound && idx >= startIndex ) {
			oldIndex = [NSNumber numberWithUnsignedInteger: idx];
			obj = [self.dictionary objectForKey: oldIndex];
			//NSLog( @"Moving '%@' from index is %@ to %ld", obj, oldIndex, (idx + delta) );
			[self.dictionary removeObjectForKey: oldIndex];
			if( idx < NSNotFound - delta ) {
				[self.dictionary setObject: obj forKey: [NSNumber numberWithInteger: (idx + delta)]];
			} else {
				NSLog( @"-- Index > NSNotFoound - 1, so poofed %@", oldIndex );
				[self.indexes removeIndex: idx];
			}
			idx = [indexes indexLessThanIndex: idx];
		}
		//NSLog( @"The shifted dictionary is %@", self.dictionary );
	}
	[self.indexes shiftIndexesStartingAtIndex: startIndex by: delta];
	//NSLog( @"The shifted index set is %@", self.indexes );
}

@end

#pragma mark - DSMutableSparseArray DSExtendedMutableSparseArray methods
@implementation DSMutableSparseArray (DSExtendedMutableSparseArray)
- (void) setObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes {
	if( indexes.count > 0 && objects.count > 0 ) {
		NSUInteger idx = indexes.firstIndex;
		NSUInteger i = 0;
		while( idx != NSNotFound ) {
			[self setObject: objects[i++] atIndex: idx];
			idx = [indexes indexGreaterThanIndex: idx];
		}
	}
}
- (void) insertObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes {
	if( indexes.count > 0 && objects.count > 0 ) {
		NSUInteger idx = indexes.firstIndex;
		NSUInteger i = 0;
		while( idx != NSNotFound ) {
			[self insertObject: objects[i++] atIndex: idx];
			idx = [indexes indexGreaterThanIndex: idx];
		}
	}
}
- (void) removeAllObjects {
	[self.dictionary removeAllObjects];
	[self.indexes removeAllIndexes];
}
- (void) removeObjectsAtIndexes: (NSIndexSet *) indexSet {
#ifdef NSINDEXSET_ENUMERATE_BUG
	if( indexSet.count > 0 ) {
		NSUInteger idx = indexSet.lastIndex;
		while( idx != NSNotFound ) {
			[self removeObjectAtIndex: idx];
			idx = [indexSet indexLessThanIndex: idx];
		}
	}
#else
	[indexSet enumerateIndexesWithOptions: NSEnumerationReverse usingBlock: ^( NSUInteger idx, BOOL *stop ) {
		[self removeObjectAtIndex: idx];
	}];
#endif
}
- (void) setValue: (id) value atIndex: (NSUInteger) index {
	[self setObject: value atIndex: index];
}
- (void) addEntriesFromSparseArray: (DSMutableSparseArray *) otherSparseArray {
	NSLog( @"%s not done yet...", __func__ );
}
- (void) setSparseArray: (DSMutableSparseArray *) otherSparseArray {
	NSLog( @"%s not done yet...", __func__ );
}

@end

#pragma mark - DSMutableSparseArray DSMutableSparseArrayCreation methods
@implementation DSMutableSparseArray (DSMutableSparseArrayCreation)

+ (instancetype) sparseArrayWithCapacity: (NSUInteger) numItems {
	return [[DSMutableSparseArray alloc] initWithCapacity: numItems];
}
- (instancetype) init {
	self = [super init];
	return self;
}
- (instancetype) initWithCapacity: (NSUInteger) numItems {
	self = [super init];
	if( self ) {
		self.dictionary = [NSMutableDictionary dictionaryWithCapacity: numItems];
	}
	return self;
}

@end
