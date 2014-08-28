//
//  DSSparseArray.m
//  DSSparseArray
//
//  Created by David W. Stockton on 5/10/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import "DSSparseArray.h"

#pragma mark - Class extensions for private storage
static DSSparseArrayExceptionThrowMode __throwException = IndexOutOfRangeNoThrowNoWarn;
static BOOL __NSIndexSet_enumerateIndexesUsingBlock_isBroken = NS_BLOCKS_AVAILABLE ? NO : YES;

@interface DSSparseArray ()
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableIndexSet *indexes;
@end

#pragma mark - Core DSSparseArray methods
@implementation DSSparseArray
//----------------------------------------------------------------------------------------------------
// +initialize was added to properly set the state of __NSIndexSet_enumerateIndexesUsingBlock_isBroken
// It may be more efficient to do this testing lazily as it was previously instead of everytime
// in every application start. This will be true if enumeration is not used by most or only used
// once. It will not be true if everyone uses enumeration and more than once per execution...
#if NS_BLOCKS_AVAILABLE
+ (void) initialize {
    //NSLog( @"+++++++++ In %@ initialize for %@ +++++++++++", NSStringFromClass([DSSparseArray self]), NSStringFromClass([self class]) );
    if( self == [DSSparseArray self] ) {
        __block int count = 0;
        NSIndexSet *testSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 5, 5 )];
        NSLog( @"Index set with %lu entries: %@", (unsigned long) testSet.count, testSet );
        NSLog( @"NSNotFound is %lu and NSNotFound-1 is %lu", NSNotFound, NSNotFound - 1 );
        [testSet enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
            NSLog( @"- %lu", (unsigned long) idx );
            ++count;
        }];
        NSLog( @" - The count is %d, it is %s", count, count == 5 ? "fixed!!" : "still broken" );
        __NSIndexSet_enumerateIndexesUsingBlock_isBroken = (count != 5);
    }
}
#endif
+ (void) setThrowExceptionOnIndexOutOfRange: (unsigned int) throwMode {
	__throwException = throwMode;
}
- (NSMutableDictionary *) dictionary {
	if( !_dictionary ) _dictionary = [NSMutableDictionary dictionary];
	return _dictionary;
}
- (NSMutableIndexSet *) indexes {
	if( !_indexes )	_indexes = [NSMutableIndexSet indexSet];
	return _indexes;
}
- (NSUInteger) count {
	return self.dictionary.count;
}
- (id) objectAtIndex: (NSUInteger) index {
	return [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: index]];
}
- (NSUInteger) _indexOfObject: (id) anObject identicle: (BOOL) useIdenticle {
	// As a sparse array the user might be asking for the 'nil' object
	if( !anObject ) {
		NSUInteger idx = [self.indexes firstIndex];
		// If the first index is not zero, then array location zero is nil
		if( idx > 0 && idx != NSNotFound ) {
			idx = 0;
		} else {
			NSUInteger previousIdx = idx;
			while( (idx = [self.indexes indexGreaterThanIndex: idx]) != NSNotFound ) {
				if( idx > previousIdx + 1 ) {
					idx = previousIdx + 1;
					break;
				}
				previousIdx = idx;
			}
			// If the last index is less than the maximum size minus 1
			// then there is a 'nil' after that spot
			if( idx == NSNotFound && previousIdx < NSNotFound - 1 ) {
				idx = previousIdx + 1;
			}
		}
		return idx;
	}
	// If the user was not asking for the 'nil' object then find it in the array
#if NS_BLOCKS_AVAILABLE
	__block NSUInteger	idxOfObject = NSNotFound;
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		if( obj == anObject || (!useIdenticle && [obj isEqual: anObject]) ) {
			idxOfObject = idx;
			*stop = YES;
		}
	}];
#else
	NSUInteger	idxOfObject = NSNotFound;
	if( self.indexes.count > 0 ) {
		NSUInteger	idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			if( obj == anObject || (!useIdenticle && [obj isEqual: anObject]) ) {
				idxOfObject = idx;
				idx = NSNotFound;
			} else {
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
	}
#endif
	return idxOfObject;
}
- (NSUInteger) indexOfObject: (id) anObject {
	return [self _indexOfObject: anObject identicle: NO];
}
- (NSUInteger) indexOfObjectIdenticalTo: (id) anObject {
	return [self _indexOfObject: anObject identicle: YES];
}
- (DSSparseArrayEnumerator *) objectEnumerator {
	return [DSSparseArrayEnumerator enumeratorForSparseArray: self withOptions: 0];
}
- (DSSparseArrayEnumerator *) reverseObjectEnumerator {
	return [DSSparseArrayEnumerator enumeratorForSparseArray: self withOptions: NSEnumerationReverse];
}
// This was moved to +initialize so it is done once and does not need to be tested each time.
//- (BOOL) _NSIndexSet_enumerateIndexesUsingBlock_isBroken {
//#if NS_BLOCKS_AVAILABLE
//	static BOOL checkIt = YES;
//	if( checkIt ) {
//		__block int count = 0;
//		NSIndexSet *testSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 5, 5 )];
//		NSLog( @"Index set with %lu entries: %@", (unsigned long) testSet.count, testSet );
//		NSLog( @"NSNotFound is %lu and NSNotFound-1 is %lu", NSNotFound, NSNotFound - 1 );
//		[testSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
//			NSLog( @"- %lu", (unsigned long) idx );
//			++count;
//		}];
//		NSLog( @" - The count is %d, it is %s", count, count == 5 ? "fixed!!" : "still broken" );
//		__NSIndexSet_enumerateIndexesUsingBlock_isBroken = (count != 5);
//		checkIt = NO;
//	}
//#else
//	// If blocks are not available then it must be broken (does not work)
//	__NSIndexSet_enumerateIndexesUsingBlock_isBroken = YES;
//#endif
//	return __NSIndexSet_enumerateIndexesUsingBlock_isBroken;
//}

#pragma mark - NSMutableCopying protocol methods
- (id) mutableCopyWithZone: (NSZone *) zone {
	return [DSMutableSparseArray sparseArrayWithSparseArray: self];
}

#pragma mark - NSCopying protocol methods
- (id) copyWithZone: (NSZone *) zone {
	return [DSSparseArray sparseArrayWithSparseArray: self];
}

#pragma mark - NSSecureCoding protocol methods
- (void) encodeWithCoder: (NSCoder *) encoder {
	[encoder encodeObject: self.indexes forKey: @"indexes"];
	[encoder encodeObject: self.dictionary forKey: @"dictionary"];
}

- (id) initWithCoder: (NSCoder *) decoder {
	self = [super init];
	if( self ) {
		self.indexes = [decoder decodeObjectOfClass: [NSMutableIndexSet class] forKey: @"indexes"];
		self.dictionary = [decoder decodeObjectOfClass: [NSMutableDictionary class] forKey: @"dictionary"];
	}
	return self;
}
+ (BOOL) supportsSecureCoding {
	return YES;
}
@end

#pragma mark - Extensions to DSSparseArray methods
@implementation DSSparseArray (DSExtendedSparseArray)
- (BOOL) containsObject: (id) anObject {
	NSUInteger idx = [self indexOfObject: anObject];
	return( idx != NSNotFound );
}
- (NSIndexSet *) allIndexes {
	return [self.indexes copy];
}
- (NSIndexSet *) allIndexesForObject: (id) anObject {
	NSMutableIndexSet *indexes;
	if( !anObject ) {
		// This has hard coded the maximum index for an index set so will be broken if Apple changes this
		indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 0, NSNotFound )];
		NSLog( @"NSNotFound - 1 is %lu, all indexes is %@", NSNotFound - 1, indexes );
		[indexes removeIndexes: self.indexes];
		NSLog( @"The blank entry indexes are %@", indexes );
	} else {
		indexes = [NSMutableIndexSet indexSet];
#if NS_BLOCKS_AVAILABLE
		[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
			if( [anObject isEqual: obj] ) {
				[indexes addIndex: idx];
			}
		}];
#else
		if( self.count > 0 ) {
			NSUInteger idx = [self.indexes firstIndex];
			while( idx != NSNotFound ) {
				if( [anObject isEqual: [self objectAtIndex: idx]] ) {
					[indexes addIndex: idx];
				}
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
#endif
	}
	return indexes;
}
- (NSArray *) allObjects {
	NSUInteger	count = self.dictionary.count;
	NSUInteger	idx = [self.indexes firstIndex];
	NSMutableArray	*objects = [NSMutableArray arrayWithCapacity: count];
	for( NSUInteger i = 0; i < count; ++i ) {
		objects[i] = [self objectAtIndex: idx];
		idx = [self.indexes indexGreaterThanIndex: idx];
	}
	return objects;
}
- (void) getObjects: (__unsafe_unretained id []) objects andIndexes: (NSUInteger []) indexes {
	NSUInteger	count = self.dictionary.count;
	NSUInteger	idx = [self.indexes firstIndex];
	for( NSUInteger i = 0; i < count; ++i ) {
		objects[i] = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
		indexes[i] = idx;
		idx = [self.indexes indexGreaterThanIndex: idx];
	}
}
- (NSUInteger) hash {
#if 0
	NSUInteger prime = 31;
	NSUInteger result = 1;
	if( self.indexes.count > 0 ) {
		NSUInteger idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			if( sizeof(idx) == 4 )
				result = prime * result + idx;
			else	result = prime * result + (int) (idx ^ (idx >> 32));
			idx = [self.indexes indexGreaterThanIndex: idx];
		}
	}
	NSLog( @"My hash is %lu", (unsigned long) result );
	NSLog( @"Hash for dictionary is %lu", (unsigned long) [self.dictionary hash] );
	NSLog( @"Hash for indexes is %lu", (unsigned long) [self.indexes hash] );
	return result;
#else
	return [self.indexes hash];
#endif
}
- (BOOL) isEqual: (id) object {
	if( object == self )
		return YES;
	if( !object || ![object isKindOfClass: [DSSparseArray class]] )
		return NO;
	return [self isEqualToSparseArray: object];
}
- (BOOL) isEqualToSparseArray: (DSSparseArray *) otherSparseArray {
	if( otherSparseArray == self ||
	   ([self.indexes isEqualToIndexSet: otherSparseArray.indexes] &&
	    [self.dictionary isEqualToDictionary: otherSparseArray.dictionary]) )
		return YES;
	return NO;
}
- (DSSparseArray *) objectsAtIndexes: (NSIndexSet *) indexes notFoundMarker: (id) anObject {
	DSSparseArray *derivedArray = nil;
	NSMutableArray *objects;
	NSMutableIndexSet *setIndexes;
	// I only need to go through the intersection of the index sets if anObject is nil
	if( !anObject ) {
		// Indexes: 1   3   5   7 9
		// self:      2 3 4 5 6
		NSMutableIndexSet *a = [self.indexes mutableCopy];
		[a removeIndexes: indexes];  // In self but not indexes.
		// a = 2 4 6
		setIndexes = [self.indexes mutableCopy];
		[setIndexes removeIndexes: a];
		// setIndexes = 3 5
		if( setIndexes.count == 0 ) {
			derivedArray = [DSSparseArray sparseArray];
		} else {
			objects = [NSMutableArray arrayWithCapacity: setIndexes.count];
			NSUInteger idx = setIndexes.firstIndex;
			while( idx != NSNotFound ) {
				[objects addObject: [self objectAtIndex: idx]];
				idx = [setIndexes indexGreaterThanIndex: idx];
			}
			derivedArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: setIndexes];
		}
	} else {
		objects = [NSMutableArray arrayWithCapacity: indexes.count];
		setIndexes = [NSMutableIndexSet indexSet];
		if( __NSIndexSet_enumerateIndexesUsingBlock_isBroken ) {
			if( indexes.count > 0 ) {
				NSUInteger idx = [indexes firstIndex];
				while( idx != NSNotFound ) {
					id obj = [self objectAtIndex: idx];
					if( !obj ) obj = anObject;
					[setIndexes addIndex: idx];
					[objects addObject: obj];
					idx = [indexes indexGreaterThanIndex: idx];
				}
			}
		} else {
			[indexes enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
				id obj = [self objectAtIndex: idx];
				if( !obj ) obj = anObject;
				[setIndexes addIndex: idx];
				[objects addObject: obj];
			}];
		}
		derivedArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: setIndexes];
	}
	return derivedArray;
}
- (DSSparseArray *) objectsAtIndexes: (NSIndexSet *) indexes {
	return [self objectsAtIndexes: indexes notFoundMarker: nil];
}
- (id) valueAtIndex: (NSUInteger) index {
	return [self objectAtIndex: index];
}
- (id) firstObject {
	id obj = nil;
	if( self.indexes.count > 0 ) {
		obj = [self objectAtIndex: self.indexes.firstIndex];
	}
	return obj;
}
- (id) lastObject {
	id obj = nil;
	if( self.indexes.count > 0 ) {
		obj = [self objectAtIndex: self.indexes.lastIndex];
	}
	return obj;
}
- (DSSparseArray *) filteredSparseArrayUsingPredicate: (NSPredicate *) predicate {
	DSMutableSparseArray *mutableCopy = [self mutableCopy];
	[mutableCopy filterUsingPredicate: predicate];
	return mutableCopy;
}
- (BOOL) writeToFile: (NSString *) path atomically: (BOOL) atomically {
	NSLog( @">>>>> calling: [self.dictionary writeToFile: \"%@\" atomically: %s]", path, atomically ? "YES" : "NO" );
	// I store my keys as NSNumbers but to write to a file they have to be NSStrings!
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity: self.dictionary.count];
	[self.dictionary enumerateKeysAndObjectsUsingBlock: ^( NSNumber *key, id obj, BOOL *stop ) {
		[dictionary setObject: obj forKey:[key descriptionWithLocale: nil]];
	}];
	BOOL status = [dictionary writeToFile: path atomically: atomically];
	NSLog( @">>>>> return value of %s", status ? "YES" : "NO" );
	return status;
}
- (BOOL) writeToURL: (NSURL *) url atomically: (BOOL) atomically {
	// I store my keys as NSNumbers but to write to a file they have to be NSStrings!
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity: self.dictionary.count];
	[self.dictionary enumerateKeysAndObjectsUsingBlock: ^( NSNumber *key, id obj, BOOL *stop ) {
		[dictionary setObject: obj forKey:[key descriptionWithLocale: nil]];
	}];
	return [dictionary writeToURL: url atomically: atomically];
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
	if( __NSIndexSet_enumerateIndexesUsingBlock_isBroken ) {
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
	} else {
		[self.indexes enumerateIndexesWithOptions: opts usingBlock: ^( NSUInteger idx, BOOL *stop ) {
			NSLog( @"Enumerating index %lu, NSNotFound is %lu", idx, NSNotFound );
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			block( obj, idx, stop );
		}];
	}
}
#endif
- (NSString *) description {
	NSMutableArray *contents = [NSMutableArray arrayWithCapacity: self.indexes.count];
#if NS_BLOCKS_AVAILABLE
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		[contents addObject: [NSString stringWithFormat: @"    %3lu:%@", idx, obj]];
	}];
#else
	if( self.indexes.count > 0 ) {
		NSUInteger idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			id obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			[contents addObject: [NSString stringWithFormat: @"    %3lu:%@", idx, obj]];
			idx = [self.indexes indexGreaterThanIndex: idx];
		}
	}
#endif
	return [NSString stringWithFormat: @"(\n%@\n)", [contents componentsJoinedByString: @",\n"]];
}
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
	//NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	id sparseArray = [[[self class] alloc] initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: YES];
	va_end( args );
	return sparseArray;
}
+ (instancetype) sparseArrayWithObjectsAndNSUIntegerIndexes: (id) firstObject, ... {
	//NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	id sparseArray = [[[self class] alloc] initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: NO];
	va_end( args );
	return sparseArray;
}
- (instancetype) init {
	self = [super init];
	return self;
}
- (instancetype) initWithArray: (NSArray *) array {
	NSIndexSet *indexes = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange( 0, array.count )];
	return [self initWithObjects: array atIndexes: indexes];
}
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray {
	return [self initWithSparseArray: otherSparseArray copyItems: NO];
}
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray copyItems: (BOOL) flag {
	self = [super init];
	if( self ) {
		self.indexes = [otherSparseArray.indexes mutableCopy];
		self.dictionary = [[NSMutableDictionary alloc] initWithDictionary: otherSparseArray.dictionary copyItems: flag];
	}
	return self;
}
- (NSArray *) _keysFromIndexSet: (NSIndexSet *) indexSet {
	NSMutableArray *keys = [NSMutableArray arrayWithCapacity: indexSet.count];
	if( __NSIndexSet_enumerateIndexesUsingBlock_isBroken ) {
		if( indexSet.count > 0 ) {
			NSUInteger idx = [self.indexes firstIndex];
			while( idx != NSNotFound ) {
				[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
				idx = [self.indexes indexGreaterThanIndex: idx];
			}
		}
	} else {
#if NS_BLOCKS_AVAILABLE
		[indexSet enumerateIndexesUsingBlock: ^( NSUInteger idx, BOOL *stop ) {
			[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
		}];
#else
		NSLog( @"**** error: NSIndexSet enumerateIndexesUsingBlocks is not broken but blocks are not available? How can this be?" );
#endif
	}
	return keys;
}
- (instancetype) initWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet {
	self = [super init];
	if( self ) {
		self.indexes = [indexSet mutableCopy];
		NSArray *keys = [self _keysFromIndexSet: indexSet];
		self.dictionary = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];
	}
	return self;
}
- (instancetype) initWithObjects: (const id[]) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count {
	//NSLog( @"Entering %s", __func__ );
	self = [super init];
	if( self ) {
		NSMutableArray *keys = [NSMutableArray array];
		NSMutableArray *objectArray = [NSMutableArray array];
		NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
		for( NSUInteger i = 0; i < count; ++i ) {
			// Objects is a C array, so entries might be null
			if( objects[i] ) {
				[objectArray addObject: objects[i]];
				[keys addObject: [NSNumber numberWithUnsignedInteger: indexes[i]]];
				[indexSet addIndex: indexes[i]];
			}
		}
		self.indexes = indexSet;
		self.dictionary = [NSMutableDictionary dictionaryWithObjects: objectArray forKeys: keys];
	}
	return self;
}
- (instancetype) initWithObjectsAndIndexes: (id) firstObject, ... {
	//NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	self = [self initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: YES];
	va_end( args );
	return self;
}
- (instancetype) initWithObjectsAndNSUIntegerIndexes: (id) firstObject, ... {
	//NSLog( @">>>> Entering %s", __func__ );
	va_list args;
	va_start( args, firstObject );
	self = [self initWithObject: firstObject indexAndObjectsAndIndexes: args asInts: NO];
	va_end( args );
	return self;
}
- (instancetype) initWithObject: (id) firstObject indexAndObjectsAndIndexes: (va_list) args asInts: (BOOL) asInts {
	//NSLog( @">>>> Entering %s", __func__ );
	self = [super init];
	if( self && firstObject ) {
		NSMutableArray *keys = [NSMutableArray array];
		NSMutableArray *objects = [NSMutableArray array];
		NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
		
		id		obj = firstObject;
		NSUInteger	idx;
		do {
			if( asInts )
				idx = va_arg( args, int );
			else	idx = va_arg( args, NSUInteger );
			//NSLog( @"- Index %lu gets '%@'", (unsigned long) idx, obj );
			// Test idx here for value > NSNotFound - 1...
			if( idx > NSNotFound - 1 ) {
				self = nil;
				if( __throwException == IndexOutOfRangeThrowIfNonEmpty ||
				    __throwException == IndexOutOfRangeThrowIfAny ) {
					[NSException raise: NSRangeException format: @"Sparse array initialization index %lu is greater than NSNotFound - 1 (%lu)", (unsigned long) idx, (unsigned long) NSNotFound - 1];
				} else if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"**** error: sparse array initialization index %lu is greater than NSNotFound - 1 (%lu)", (unsigned long) idx, (unsigned long) NSNotFound - 1 );
				}
				return self;
			}
			[keys addObject: [NSNumber numberWithUnsignedInteger: idx]];
			[objects addObject: obj];
			[indexes addIndex: idx];
			obj = va_arg( args, id );
		} while( obj != nil );
		
		self.indexes = indexes;
		self.dictionary = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];
	}
	return self;
}
+ (id /* DSSparseArray * */) sparseArrayWithContentsOfFile: (NSString *) path {
	return [[[self class] alloc] initWithContentsOfFile: path];
}
+ (id /* DSSparseArray * */) sparseArrayWithContentsOfURL: (NSURL *) url {
	return [[[self class] alloc] initWithContentsOfURL: url];
}
- (instancetype) initWithDictionary: (NSDictionary *) dictionary {
	self = [self init];
	if( self ) {
		if( !dictionary ) {
			self = nil;
		} else {
			self.indexes = [NSMutableIndexSet indexSet];
			self.dictionary = [NSMutableDictionary dictionaryWithCapacity: dictionary.count];
#if NS_BLOCKS_AVAILABLE
			[dictionary enumerateKeysAndObjectsUsingBlock: ^( id key, id obj, BOOL *stop ) {
				// Should I make sure the key responds to 'unsignedIntegerValue'?
				NSUInteger idx = [key integerValue];
				[self.indexes addIndex: idx];
				[self.dictionary setObject: [dictionary objectForKey: key] forKey: [NSNumber numberWithUnsignedInteger: idx]];
			}];
#else
			NSArray *keys = [dictionary allKeys];
			for( id key in keys ) {
				NSUInteger idx = [key integerValue];
				[self.indexes addIndex: idx];
				[self.dictionary setObject: [dictionary objectForKey: key] forKey: [NSNumber numberWithUnsignedInteger: idx]];
			}
#endif
		}
	}
	return self;
}
- (id /* DSSparseArray * */) initWithContentsOfFile: (NSString *) path {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile: path];
	self = [self initWithDictionary: dictionary];
	return self;
}
- (id /* DSSparseArray * */) initWithContentsOfURL: (NSURL *) url {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfURL: url];
	self = [self initWithDictionary: dictionary];
	return self;
}

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
- (void) insertObject: (id) object atIndex: (NSUInteger) index {
	[self shiftObjectsStartingAtIndex: index by: 1];
	[self setObject: object atIndex: index];
}
- (void) removeObjectAtIndex: (NSUInteger) index {
	// What if index is > NSNotFound-1 ???
	[self shiftObjectsStartingAtIndex: index+1 by: -1];
}
- (void) removeObject: (id) anObject {
	if( anObject ) {
		NSIndexSet *indexes = [self allIndexesForObject: anObject];
		[self removeObjectsAtIndexes: indexes];
	} else {
		NSMutableDictionary *newDictionary = [NSMutableDictionary dictionaryWithCapacity: self.count];
		NSMutableIndexSet *newIndexes = [NSMutableIndexSet indexSet];
		NSUInteger idx = [self.indexes firstIndex];
		NSUInteger dstIdx = 0;
		id obj;
		while( idx != NSNotFound ) {
			obj = [self.dictionary objectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			[newDictionary setObject: obj forKey: [NSNumber numberWithUnsignedInteger: dstIdx]];
			[newIndexes addIndex: dstIdx++];
			idx = [self.indexes indexGreaterThanIndex: idx];
		}
		self.dictionary = newDictionary;
		self.indexes = newIndexes;
	}
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
	if( __throwException != IndexOutOfRangeNoThrowNoWarn ) {
		if( delta < 0 ) {
			if( startIndex < -delta ) {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"**** warning: magnitude of delta of %ld is too large for start index of %lu in %s", delta, startIndex, __func__ );
				} else if( __throwException == IndexOutOfRangeThrowIfAny ) {
					[NSException raise: NSRangeException format: @"Magnitude of shift of %ld is too large for start index of %lu", delta, startIndex];
				}
			}
			// If shifting down and the amount of the shift will make a non-empty
			// array entry be moved below zero raise and exception.
			if( [self.indexes indexGreaterThanOrEqualToIndex: startIndex] < -delta ) {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"**** warning: magnitude of delta of %ld is too large with first non-empty index of %lu in %s", delta, [self.indexes indexGreaterThanOrEqualToIndex: startIndex], __func__ );
				} else if( __throwException == IndexOutOfRangeThrowIfNonEmpty ) {
					[NSException raise: NSRangeException format: @"Magnitude of shift of %ld is too large with first non-empty index of %lu", delta, [self.indexes indexGreaterThanOrEqualToIndex: startIndex]];
				}
			}
		} else /* delta > 0 */ {
			if( startIndex > (NSNotFound - delta - 1) ) {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"**** warning: delta of %ld is too large for start index of %lu and maximum possible array index of %lu in %s", delta, startIndex, NSNotFound - 1, __func__ );
				} else if( __throwException == IndexOutOfRangeThrowIfAny ) {
					[NSException raise: NSRangeException format: @"Shift of %ld is too large for start index of %lu and maximum possible array index of %lu", delta, startIndex, NSNotFound - 1];
				}
			}
			if( [self.indexes lastIndex] > NSNotFound - delta - 1 ) {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"**** warning: delta of %ld is too large for highest non-empty index of %lu and maximum possible array index of %lu in %s", delta, [self.indexes lastIndex], NSNotFound - 1, __func__ );
				} else if( __throwException >= IndexOutOfRangeThrowIfNonEmpty ) {
					[NSException raise: NSRangeException format: @"Shift of %ld is too large for highest non-empty index of %lu and maximum possible array index of %lu", delta, [self.indexes lastIndex], NSNotFound - 1];
				}
			}
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
		//NSLog( @"o Need to clear the entries from %ld to %lu", startIndex + delta, startIndex );
		//NSLog( @"- This is actually from %lu to %lu", idx, [indexes indexLessThanIndex: startIndex] );
		while( idx != NSNotFound && idx < startIndex && idx <= [indexes indexLessThanIndex: startIndex] ) {
			//NSLog( @"o Clearing the array entry at %lu before the move", idx );
			[self.dictionary removeObjectForKey: [NSNumber numberWithUnsignedInteger: idx]];
			idx = [indexes indexGreaterThanIndex: idx];
		}
		idx = [indexes indexGreaterThanOrEqualToIndex: startIndex];
		while( idx != NSNotFound ) {
			oldIndex = [NSNumber numberWithUnsignedInteger: idx];
			obj = [self.dictionary objectForKey: oldIndex];
			//NSLog( @"o Moving '%@' from index is %@ to %ld", obj, oldIndex, (idx + delta) );
			[self.dictionary removeObjectForKey: oldIndex];
			if( idx >= -delta ) {
				[self.dictionary setObject: obj forKey: [NSNumber numberWithInteger: (idx + delta)]];
			} else {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"-- Negative destination index, so poofed entry formerly at %@", oldIndex );
				}
				[self.indexes removeIndex: idx];
			}
			idx = [indexes indexGreaterThanIndex: idx];
		}
		//NSLog( @"o The shifted dictionary is %@", self.dictionary );
	} else {
		idx = [indexes lastIndex];
		startIndex = [indexes indexGreaterThanOrEqualToIndex: startIndex];
		while( idx != NSNotFound && idx >= startIndex ) {
			oldIndex = [NSNumber numberWithUnsignedInteger: idx];
			obj = [self.dictionary objectForKey: oldIndex];
			//NSLog( @"o Moving '%@' from index is %@ to %ld", obj, oldIndex, (idx + delta) );
			[self.dictionary removeObjectForKey: oldIndex];
			if( idx < NSNotFound - delta ) {
				[self.dictionary setObject: obj forKey: [NSNumber numberWithInteger: (idx + delta)]];
			} else {
				if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
					NSLog( @"-- Destination index > NSNotFoound - 1, so poofed entry formerly at %@", oldIndex );
				}
				[self.indexes removeIndex: idx];
			}
			idx = [indexes indexLessThanIndex: idx];
		}
		//NSLog( @"o The shifted dictionary is %@", self.dictionary );
	}
	[self.indexes shiftIndexesStartingAtIndex: startIndex by: delta];
	//NSLog( @"o The shifted index set is %@", self.indexes );
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
- (void) clearObjectAtIndex: (NSUInteger) index {
	[self setObject: nil atIndex: index];
}
- (void) clearObjectsAtIndexes: (NSIndexSet *) indexes {
	// Get the subset of indexes that are in both the parameter and sparse array
	NSMutableIndexSet *sharedIndexes;
	// Indexes: 1   3   5   7 9
	// self:      2 3 4 5 6
	NSMutableIndexSet *a = [self.indexes mutableCopy];
	[a removeIndexes: indexes];  // In self but not indexes.
	// a = 2 4 6
	sharedIndexes = [self.indexes mutableCopy];
	[sharedIndexes removeIndexes: a];
	// sharedIndexes = 3 5
	if( sharedIndexes.count > 0 ) {
		NSUInteger idx = [sharedIndexes firstIndex];
		while( idx != NSNotFound ) {
			[self setObject: nil atIndex: idx];
			idx = [sharedIndexes indexGreaterThanIndex: idx];
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
	if( __NSIndexSet_enumerateIndexesUsingBlock_isBroken ) {
		if( indexSet.count > 0 ) {
			NSUInteger idx = indexSet.lastIndex;
			while( idx != NSNotFound ) {
				[self removeObjectAtIndex: idx];
				idx = [indexSet indexLessThanIndex: idx];
			}
		}
	} else {
#if NS_BLOCKS_AVAILABLE
		[indexSet enumerateIndexesWithOptions: NSEnumerationReverse usingBlock: ^( NSUInteger idx, BOOL *stop ) {
			[self removeObjectAtIndex: idx];
		}];
#else
		NSLog( @"**** error: NSIndexSet enumerateIndexesUsingBlocks is not broken but blocks are not available? How can this be?" );
#endif
	}
}
- (void) removeObjectsInRange: (NSRange) aRange {
	[self shiftObjectsStartingAtIndex: aRange.location + aRange.length by: -aRange.length];
}
- (void) removeObjectsInArray: (NSArray *) array {
#ifdef NS_BLOCKS_AVAILABLE
	[array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[self removeObject: obj];
	}];
#else
	for( id obj in array ) {
		[self removeObject: obj];
	}
#endif
}
- (void) filterUsingPredicate: (NSPredicate *) predicate {
	NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet indexSet];
#ifdef NS_BLOCKS_AVAILABLE
	[self enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		if( ![predicate evaluateWithObject: obj] ) {
			[indexesToRemove addIndex: idx];
		}
	}];
#else
	if( self.count > 0 ) {
		NSUInteger idx = [self.indexes firstIndex];
		while( idx != NSNotFound ) {
			if( ![predicate evaluateWithObject: [self objectAtIndex: idx]] ) {
				[indexesToRemove addIndex: idx];
			}
			idx = [self.indexes indexGreaterThanIndex: idx];
		}
	}
#endif
	NSUInteger idx = [indexesToRemove firstIndex];
	while( idx != NSNotFound ) {
		[self setObject: nil atIndex: idx];
		idx = [indexesToRemove indexGreaterThanIndex: idx];
	}
}
- (void) removeLastObject {
	NSUInteger lastIndex = [self.indexes lastIndex];
	if( lastIndex != NSNotFound ) {
		[self removeObjectAtIndex: lastIndex];
	} else if( __throwException == IndexOutOfRangeNoThrowButLogWarning ) {
		NSLog( @"**** warning: removeLastObject invoked on empty %@ in %s", NSStringFromClass([self class]), __func__ );
	} else if( __throwException > IndexOutOfRangeNoThrowButLogWarning ) {
		[NSException raise: NSRangeException format: @"removeLastObject invoked on empty %@", NSStringFromClass([self class])];
	}
}
- (void) setValue: (id) value atIndex: (NSUInteger) index {
	[self setObject: value atIndex: index];
}
- (void) setSparseArray: (DSSparseArray *) otherSparseArray {
	self.indexes = [otherSparseArray.indexes mutableCopy];
	self.dictionary = [otherSparseArray.dictionary mutableCopy];
}
- (void) setObjectsFromSparseArray: (DSSparseArray *) otherSparseArray {
	NSArray *objects = [otherSparseArray allObjects];
	[self setObjects: objects atIndexes: otherSparseArray.indexes];
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
