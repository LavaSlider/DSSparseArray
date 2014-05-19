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

- (void) setValue: (id) value atIndex: (NSUInteger) index;
- (void) setSparseArray: (DSMutableSparseArray *) otherSparseArray;

- (void) insertObject: (id) object atIndex: (NSUInteger) index;

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

- (void) removeObjectAtIndex: (NSUInteger) index;
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

// Huh, what about me?
- (void) addEntriesFromSparseArray: (DSMutableSparseArray *) otherSparseArray;  // What does this do? Append the objects? Set the objects?

