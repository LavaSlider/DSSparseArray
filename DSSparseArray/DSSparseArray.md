# DSSparseArray

Inherits from: NSObject
Conforms to: NSObject, NSCopying, NSMutableCopying

## Overview
DSSparseArray and its subclass DSMutableSparseArray manage ordered collections of objects called sparse arrays, which are similar to regular arrays but can have *nil* entries. DSSparseArray creates static sparse arrays, and DSMutableSparseArray creates dynamic sparse arrays. You can use sparse arrays when you need an ordered collection of objects that may have non-contiguous indexes.

## Tasks
### Creating a Sparse Array
+ sparseArray
+ sparseArrayWithArray:
+ sparseArrayWithSparseArray:
+ sparseArrayWithObject:atIndex:
+ sparseArrayWithObjects:atIndexes:
+ sparseArrayWithObjects:atIndexes:count:
+ sparseArrayWithObjectsAndIndexesL
+ sparseArrayWithObjectsAndUnsignedIntegerIndexes:

### Initializing a Sparse Array
- init
- initWithArray:
- initWithSparseArray:
- initWithSparseArray:copyItems:
- initWithObjects:atIndexes:
- initWithObjects:atIndexes:count:
- initWithObjectsAndIndexes:
- initWithObjectsAndUnsignedIntegerIndexes:

### Querying a Sparse Array
- count;
- allIndexes
- objectAtIndex:
- valueAtIndex:
- objectEnumerator
- enumerateIndexesAndObjectsUsingBlock:
- enumerateIndexesAndObjectsWithOptions:usingBlock:
- indexesOfEntriesPassingTest:
- indexesOfEntriesWithOptions:passingTest:

### Finding Objects in a Sparse Array
- indexOfObject:
- allIndexesForObject:
- indexOfObjectIdenticalTo:

### Deriving New Sparse Arrays
- filteredSparseArrayUsingPredicate:

### Comparing Sparse Arrays
- isEqualToSparseArray:


## Class Methods

### sparseArray
Creates and returns an empty sparse array.
+ (instancetype) sparseArray
#### Return value
An empty sparse array.
#### Discussion
This method is used by mutable subclasses DSSparseArray.
#### Availability
#### See Also
+ sparseArrayWithObject:atIndex:
+ sparseArrayWithObjectsAndIndexes:
#### Declared In
DSSparseArray.h

### sparseArrayWithArray:
Creates and returns a sparse array containing the objects in the given array.
+ (instancetype) sparseArrayWithArray: (NSArray *) anArray;
#### Parameters
##### anArray
The array to get the elements from.
#### Return value
A sparse array containing the objects from anArray in indexes 0 to count - 1.
#### Discussion
This method is used to create a sparse array containing the contents of anArray.
#### Availability
#### See Also
+ sparseArrayWithObject:atIndex:
+ sparseArrayWithObjectsAndIndexes:
#### Declared In
DSSparseArray.h

### sparseArrayWithSparseArray:
Creates and returns a sparse array containing the objects in the given sparse array.
+ (instancetype) sparseArrayWithSparseArray: (DSSparseArray *) otherSparseArray;
#### Parameters
##### otherSparseArray
The sparse array to get the elements from.
#### Return value
A sparse array containing the objects from otherSparseArray at the indexes from otherSparseArray.
#### Discussion
This method is used to create a sparse array containing the contents of otherSparseArray.
#### Availability
#### See Also
+ sparseArrayWithObject:atIndex:
+ sparseArrayWithObjectsAndIndexes:
#### Declared In
DSSparseArray.h

+ (instancetype) sparseArrayWithObject: (id) anObject atIndex: (NSUInteger) index;
+ (instancetype) sparseArrayWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet;
+ (instancetype) sparseArrayWithObjects: (const id[]) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count;
+ (instancetype) sparseArrayWithObjectsAndIndexes: (id) firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype) sparseArrayWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

### setThrowExceptionOnOutOfRangeIndex:
Sets object functionality for objects whose indexes go out of range
+ (void) setThrowExceptionOnOutOfRangeIndex: (unsigned int) throwMode;
#### Parameters
##### throwMode
0 for no exception throwing, 1 for throwing an exception if an operation causes a array entry to be pushed out of the array either at the top or bottom, 2 for throwing an exception if an operation causes even an empty array entry to be pushed out of the array.
#### Return value
None.
#### Discussion
Array indexes are limited to a minium of zero and a maximum value of NSNotFound - 1. Therefore if shift or insertion operations move objects to where their index would be less than zero or greater than NSNotFound - 1 something must be done. If the throwMode has been set to 0 (the default), then the entries are deleted. If the throwMode has been set to 1 then an NSRangeException is thrown if a non-empty array entry would have its index set less than zero or greater than NSNotFound - 1. Lastly, if the throwMode has been to 2 then an NSRangeException would be thrown if a empty array entry would have its index set to less than zero (e.g. shift entry at index 5 by negative 10) or if the selected start location of a shift would be shifted have an index greater than NSNotFound - 1.
#### Availability
#### See Also
#### Declared In
DSSparseArray.h

## Instance Methods

### count
Returns the number of objects currently in the sparse array
- (NSUInteger) count;
#### Return value
The number of objects currently in the sparse array.
#### Discussion
Unlike a regular array the objects in sparse array do not necessarily be at contiguous indexes starting at zero. The method returns the number of non-empty array entries.
#### Availability
#### See Also
- allIndexes
#### Declared In
DSSparseArray.h

### objectAtIndex:
Returns the object located at the specified index.
- (id) objectAtIndex: (NSUInteger) index;
#### Return value
The object located at index which, since this is a sparse array, could be nil.
#### Discussion
Any value of index is permissible from 0 NSNotFound - 1 but will return nil for any entry that has not been set.
#### Availability
#### See Also
- count
- allIndexes
#### Declared In
DSSparseArray.h

### allIndexes
Returns an NSIndexSet containing the indexes of all the non-empty entries in the sparse array.
- (NSIndexSet *) allIndexes;
#### Return value
An NSIndexSet containing the indexes of all the non-empty entries in the sparse array.
#### Discussion
This can be used for finding the first, last, or other entries in the sparse array.
#### Availability
#### See Also
- count
#### Declared In
DSSparseArray.h

- (NSUInteger) indexOfObject: (id) anObject;
- (NSUInteger) indexOfObjectIdenticalTo: (id) anObject;
- (NSEnumerator *) objectEnumerator;
- (NSIndexSet *) allIndexesForObject: (id) anObject;
- (NSArray *) allValues; // Should this be 'allObjects'?
- (void) getObjects: (__unsafe_unretained id []) objects andIndexes: (NSUInteger []) indexes;
- (BOOL) isEqualToSparseArray: (DSSparseArray *) otherSparseArray;
- (DSSparseArray *) objectsForIndexes: (NSIndexSet *) indexes notFoundMarker: (id) anObject;
- (id) valueAtIndex: (NSUInteger) index;
- (DSSparseArray *) filteredSparseArrayUsingPredicate: (NSPredicate *) predicate;
- (void) enumerateIndexesAndObjectsUsingBlock: (void (^)( id obj, NSUInteger idx, BOOL *stop )) block;
- (void) enumerateIndexesAndObjectsWithOptions: (NSEnumerationOptions) opts usingBlock: (void (^)( id obj, NSUInteger idx, BOOL *stop )) block;
- (NSIndexSet *) indexesOfEntriesWithOptions: (NSEnumerationOptions) opts passingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop )) predicate;
- (NSIndexSet *) indexesOfEntriesPassingTest: (BOOL (^)( NSUInteger idx, id obj, BOOL *stop) ) predicate;
- (instancetype) init;
- (instancetype) initWithArray: (NSArray *) array;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray;
- (instancetype) initWithSparseArray: (DSSparseArray *) otherSparseArray copyItems: (BOOL) flag;
- (instancetype) initWithObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexSet;
- (instancetype) initWithObjects: (const id []) objects atIndexes: (const NSUInteger[]) indexes count: (NSUInteger) count;
- (instancetype) initWithObjectsAndIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype) initWithObjectsAndUnsignedIntegerIndexes: (id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;


