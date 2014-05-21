# DSMutableSparseArray

Inherits from: DSSparseArray
Conforms to: NSObject, NSCopying, NSMutableCopying

## Overview
The DSMutableSparseArray class declares the programmatic interface to objects that manage a modifiable sparse array of objects. This class adds insertion and deletion operations to the basic array-handling behavior inherited from DSSparseArray.

## Tasks
### Creating aand Initializing a Mutable Sparse Array
+ sparseArrayWithCapacity:
- init
- initWithCapacity:

### Setting and/or Replacing Objects
- setObject:atIndex:
- setObjects:atIndexes:
- setValue:atIndex:
- setSparseArray:

### Adding Objects
- insertObject:atIndex:
- insertObjects:atIndexes:

### Removing Objects
- removeObjectAtIndex:
- removeObjectsAtIndexes:
- removeObjectsInRange:
- removeObject:
- removeObjectsInArray:
- removeLastObject
- removeAllObjects

### Filtering Content
- filterUsingPredicate:

### Rearranging Content
- shiftObjectsStartingAtIndex:by:


## Class Methods

### sparseArrayWithCapacity:
Creates and returns a DSMutableSparseArray object with enough allocated memory to initially hold a given number of objects.
+ (instancetype) sparseArrayWithCapacity: (NSUInteger) numItems;
#### Parameters
##### numItems
The initial capacity of the new array.
#### Return value
A DSMutableSparseArray object with enough allocated memory to initially hold numItems objects.
#### Discussion
Mutable sparse arrays expand as needed; numItems simply establishes the object’s initial capacity.
#### Availability
#### See Also
+ sparseArray
- initWithCapacity
#### Declared In
DSSparseArray.h



## Instance Methods

### setObject:atIndex:
Sets the object at index with anObject.
- (void) setObject: (id) anObject atIndex: (NSUInteger) index;
#### Parameters
##### anObject
The object to be stored in the sparse array.
##### index
The index within the sparse array at which to store the object.
#### Return value
None.
#### Discussion
This method stores the object at the location indicated by the index. If the location already has an object stored at it that object is replaced. There is no shifting up or down of other entries. If *anObject* is *nil* it effectively removes the entry previoulsy stored at the specified index from the sparse array.
#### Availability
#### See Also
- insertObject:atIndex:
- setObjects:atIndexes:
#### Declared In
DSSparseArray.h


### setObjects:atIndexes:
Sets the sparse array entries as specified by contents of the array of objects and indexes
- (void) setObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
#### Parameters
##### objects
An NSArray containing the objects to be stored in the sparse array.
##### indexes
An NSIndexSet containing the indexes within the DSMutableSparse array at which to store each object. The count of indexes in the NSIndexSet must equal to the count of entries in the NSArray.
#### Return value
None.
#### Discussion
This method stores the objects at the locations indicated by the indexes. If a location already has an object stored at it, that object is replaced. There is no shifting up or down of other entries.
#### Availability
#### See Also
- setObject:atIndex:
- insertObjects:atIndexes:
#### Declared In
DSSparseArray.h


### setValue:atIndex:
Sets the object at index with anObject.
- (void) setValue: (id) value atIndex: (NSUInteger) index;
#### Parameters
##### *value*
The object to be stored in the sparse array.
##### *index*
The index within the sparse array at which to store the object.
#### Return value
None.
#### Discussion
This is the same as setObject:atIndex:
#### Availability
#### See Also
- setObject:atIndex:
#### Declared In
DSSparseArray.h


### setObjectsFromSparseArray:
Sets the sparse array entries as specified by contents of the other sparse array
- (void) setObjectsFromSparseArray: (DSMutableSparseArray *) otherSparseArray
#### Parameters
##### *otherSparseArray*
A sparse array containing the objects and indexes to be stored in the sparse array.
#### Return value
None.
#### Discussion
This method stores the objects from the *otherSparseArray* at the locations that they are at in *otherSparseArray*. If a location already has an object stored at it, that object is replaced. There is no shifting up or down of other entries. Unlike `setObject:atIndex:`, this method will not clear existing entries. In other words, empty entries from *otherSparseArray* are not transfered.

    sparseArray1 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"b", 1, @"c", 2, @"m", 13, nil];
    sparseArray2 = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"d", 3, @"n", 13, nil];
    [sparseArray1 setEntriesFromSparseArray: sparseArray2];
    // Resulting sparse array: ( 1: @"b", 2: @"c", 3: @"d", 13: @"n" )

#### Availability
#### See Also
- setObjects:atIndexes:
- setObject:atIndex:
#### Declared In
DSSparseArray.h


- (void) setSparseArray: (DSMutableSparseArray *) otherSparseArray;


### insertObject:atIndex:
Inserts the given object into the sparse array's contents at the given index.
- (void) insertObject: (id) object atIndex: (NSUInteger) index;
#### Parameters
##### *object*
The object to be stored in the sparse array.
##### *index*
The index within the sparse array at which to store the object.
#### Return value
None.
#### Discussion
If index is already occupied, the objects at index and beyond are shifted by adding 1 to their indices to make room.
Note that unlike NSArray objects, mutable sparse arrays do not have a fixed size and objects can be inserted at any index from 0 to NSNotFound - 1. If the object to be inserted is *nil* then it just shifts the remainder of the array by one creating an empty entry.
If an existing array element is shifted beyond the permissible index range (i.e., its index > NSNotFound - 1) it will be silently deleted or generate an NSRangeException depending on the status of setThrowExceptionOnOutOfRangeIndex:.
#### Availability
#### See Also
- setObject:atIndex:
#### Declared In
DSSparseArray.h

### insertObjects:atIndexes:
Inserts the objects in the provided array into the receiving sparse array at the specified indexes.
- (void) insertObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes;
#### Parameters
##### objects
An NSArray containing the objects to be inserted into the sparse array.
##### indexes
An NSIndexSet containing the indexes at which the objects in objects should be inserted. The count of locations in indexes must equal the count of objects.
#### Return value
None.
#### Discussion
Each object in _objects_ is inserted into the receiving sparse array in turn at the corresponding location specified in _indexes_ after insertions at lower indexes have been made. The functionality is conceptually illustrated below.

    - void insertObjects: (NSArray *) objects atIndexes: (NSIndexSet *) indexes {
        NSUInteger currentIndex = [indexes firstIndex];
        NSUInteger i, count = [indexes count];

        for( i = 0; i < count; i++ ) {
            [self insertObject: [objects objectAtIndex: i] atIndex: currentIndex];
            currentIndex = [indexes indexGreaterThanIndex:currentIndex];
        }
    }

The resulting behaviour is illustrated by:

    DSMutableSparseArray *array = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 0, @"two", 1, @"three", 2, @"four", 3, @"ten", 9, nil];
    NSArray *newAdditions = [NSArray arrayWithObjects: @"a", @"b", @"j", nil];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex: 1];
    [indexes addIndex: 3];
    [indexes addIndex: 11];
    [array insertObjects: newAdditions atIndexes: indexes];
    NSLog(@"array: %@", array);
 
    // Output: array: ( 0: one, 1: a, 2: two, 3: b, 4: three, 5: four, 11: j, 12: ten )

Because this is a sparse array there are no requirements that the insertion points be contiguous with existing array elements. It should be kept in mind, however, that all indexes greater than or equal to the insertion point are shifted up whether they are empty or not, as illustrated above.
If an existing array element is shifted beyond the permissible index range (i.e., its index > NSNotFound - 1) it will be silently deleted or generate an NSRangeException depending on the status of setThrowExceptionOnOutOfRangeIndex:.
#### Availability
#### See Also
- insertObject:atIndex:
- setObjects:atIndexes:
#### Declared In
DSSparseArray.h


### removeObjectAtIndex:
Removes the object at *index*.
- (void) removeObjectAtIndex: (NSUInteger) index
#### Parameters
##### *index*
The location or index at which to remove the object in the array.
#### Return value
None.
#### Discussion
Similar to an NSArray, to fill the gap, all elements beyond index are moved by subtracting 1 from their index. This happens whether the entry being removed is occupied or empty. Unlike an NSArray any index value is legal.

    DSMutableSparseArray *sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 3, @"two", 13, @"three", 53, @"four", 2, nil];
    // Sparse array is: ( 2: @"four", 3: @"one", 13: @"two", 53: @"three" )
    [sparseArray removeObjectAtIndex: 0];
    // Resulting sparse array is: ( 1: @"four", 2: @"one", 12: @"two", 52: @"three" )
    [sparseArray removeObjectAtIndex: 12];
    // Resulting sparse array is: ( 1: @"four", 2: @"one", 51: @"three" )

#### Availability
#### See Also
- insertObject:atIndex:
- removeObjectsAtIndexes:
#### Declared In
DSSparseArray.h


- (void) removeObject: (id) anObject;
- (void) removeObjectsAtIndexes: (NSIndexSet *) indexSet;
- (void) removeObjectsInRange: (NSRange) aRange;
- (void) removeObjectsInArray: (NSArray *) array;
- (void) removeLastObject;
- (void) removeAllObjects;
- (void) filterUsingPredicate: (NSPredicate *) predicate;

- (void) shiftObjectsStartingAtIndex: (NSUInteger) startIndex by: (NSInteger) delta;

- (instancetype) init;
- (instancetype) initWithCapacity: (NSUInteger) numItems;


