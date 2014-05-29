# DSMutableSparseArray

**Inherits from:** [DSSparseArray][] : [NSObject][]    
**Conforms to:** [NSObject] [NSObject Protocol], [NSCopying] [NSCopying Protocol], [NSMutableCopying] [NSMutableCopying Protocol], [NSSecureCoding] [NSSecureCoding Protocol]

## Overview
The DSMutableSparseArray class declares the programmatic interface to objects that manage a modifiable sparse array of objects. This class adds insertion and deletion operations to the basic sparse array-handling behavior inherited from [DSSparseArray][].

## Tasks
### Creating and Initializing a Mutable Sparse Array
[+ sparseArrayWithCapacity:](#sparsearraywithcapacity)  
[- init](#init)  
[- initWithCapacity:](#initwithcapacity)  

### Setting and/or Replacing Entries in a Mutable Sparse Array
[- setObject:atIndex:](#setobjectatindex)  
[- setObjects:atIndexes:](#setobjectsatindexes)  
[- setValue:atIndex:](#setvalueatindex)  
[- setSparseArray:](#setsparsearray)  

### Unsetting or Clearing Entries in a Mutable Sparse Array
[- clearObjectAtIndex:](#clearobjectatindex)  
[- clearObjectsAtIndexes:](#clearobjectsatindexes)  

### Adding Entries to a Mutable Sparse Array
[- insertObject:atIndex:](#insertobjectatindex)  
[- insertObjects:atIndexes:](#insertobjectsatindexes)  

### Removing Entries from a Mutable Sparse Array
[- removeObjectAtIndex:](#removeobjectatindex)  
[- removeObjectsAtIndexes:](#removeobjectsatindexes)  
[- removeObjectsInRange:](#removeobjectsinrange)  
[- removeObject:](#removeobject)  
[- removeObjectsInArray:](#removeobjectsinarray)  
[- removeLastObject](#removelastobject)  
[- removeAllObjects](#removeallobjects)  

### Filtering Content in a Mutable Sparse Array
[- filterUsingPredicate:](#filterusingpredicate)  

### Rearranging Content
[- shiftObjectsStartingAtIndex:by:](#shiftobjectsstartingatindexby)  


## Class Methods

### sparseArrayWithCapacity:  
Creates and returns a DSMutableSparseArray object with enough allocated memory to initially hold a given number of objects.  
\+ (instancetype) sparseArrayWithCapacity: ([NSUInteger][]) *numItems*  
#### Parameters
##### *numItems*
The initial capacity of the new array.
#### Return value
A DSMutableSparseArray object with enough allocated memory to initially hold numItems objects.
#### Discussion
Mutable sparse arrays expand as needed; numItems simply establishes the object’s initial capacity.
#### Availability
#### See Also
[+ sparseArray](DSSparseArray.md#sparsearray)  
[- initWithCapacity](#initwithcapacity)  
#### Declared In
DSSparseArray.h  



## Instance Methods

### clearObjectAtIndex:
Clears a sparse array entry.  
\- (void) clearObjectAtIndex: (NSUInteger) *index*  
#### Parameters
##### *index*
An index in the sparse array that will be cleared.  
#### Return value
None.  
#### Discussion
This method is equivilant to [setObject:atIndex:](#setobjectatindex) with a **nil** object. It empties the location indicated by *index* without shifting any of the other entries in the array.  
#### Availability
#### See Also  
[- setObject:atIndex:](#setobjectatindex)  
[- setSparseArray:](#setsparsearray)  
#### Declared In
DSSparseArray.h  


### clearObjectsAtIndexes:
Clears the sparse array entries indicate.  
\- (void) clearObjectsAtIndexes: (NSIndexSet \*) *indexes*  
#### Parameters
##### *indexes*
An index set designating the sparse array entries to be cleared.  
#### Return value
None.  
#### Discussion
This method is equivilant to calling [clearObjectsAtIndex:](#clearobjectsatindex) repeatedly for each entry in the provided index set.  
The equivalent of **clearObjectsInRange:** can be acheived by  

    [sparseArray clearObjectsAtIndexes: [NSIndexSet indexSetWithRange: NSMakeRange( 10, 20 )]];  
#### Availability
#### See Also  
[- clearObjectAtIndex:](#clearobjectatindex)  
[- setObject:atIndex:](#setobjectatindex)  
#### Declared In
DSSparseArray.h  


### setObject:atIndex:
Sets the object at index with anObject.  
\- (void) setObject: (id) *anObject* atIndex: ([NSUInteger][]) *index*  
#### Parameters
##### *anObject*
The object to be stored in the sparse array.  
##### *index*
The index within the sparse array at which to store the object.  
#### Return value
None.  
#### Discussion
This method stores the object at the location indicated by the index. If the location already has an object stored at it that object is replaced. There is no shifting up or down of other entries. If *anObject* is **nil** it effectively removes the entry previoulsy stored at the specified index from the sparse array.  
#### Availability
#### See Also
[- insertObject:atIndex:](#insertobjectatindex)  
[- setObjects:atIndexes:](#setobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### setObjects:atIndexes:
Sets the sparse array entries as specified by contents of the array of objects and indexes  
\- (void) setObjects: (NSArray \*) *objects* atIndexes: (NSIndexSet \*) *indexes*  
#### Parameters
##### *objects*
An NSArray containing the objects to be stored in the sparse array.
##### *indexes*
An NSIndexSet containing the indexes within the DSMutableSparse array at which to store each object. The count of indexes in the NSIndexSet must equal to the count of entries in the NSArray.
#### Return value
None.
#### Discussion
This method stores the objects at the locations indicated by the indexes. If a location already has an object stored at it, that object is replaced. There is no shifting up or down of other entries.
#### Availability
#### See Also
[- setObject:atIndex:](#setobjectatindex)  
[- insertObjects:atIndexes:](#insertobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### setValue:atIndex:
Sets the object at index with anObject.  
\- (void) setValue: (id) *value* atIndex: ([NSUInteger][]) *index*  
#### Parameters
##### *value*
The object to be stored in the sparse array.  
##### *index*
The index within the sparse array at which to store the object.  
#### Return value
None.  
#### Discussion
This is the same as [setObject:atIndex:](#setobjectatindex)  
#### Availability
#### See Also
[- setObject:atIndex:](#setobjectatindex)  
#### Declared In
DSSparseArray.h  



### setObjectsFromSparseArray:
Sets the sparse array entries as specified by contents of the other sparse array  
\- (void) setObjectsFromSparseArray: (DSMutableSparseArray *) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
A sparse array containing the objects and indexes to be stored in the sparse array.  
#### Return value
None.  
#### Discussion
This method stores the objects from the *otherSparseArray* at the locations that they are at in *otherSparseArray*. If a location already has an object stored at it, that object is replaced. There is no shifting up or down of other entries. Unlike [setObject:atIndex:](#setobjectatindex), this method will not clear existing entries. In other words, empty entries from *otherSparseArray* are not transfered.  

    sparseArray1 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"b", 1, @"c", 2, @"m", 13, nil];
    sparseArray2 = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"d", 3, @"n", 13, nil];
    [sparseArray1 setEntriesFromSparseArray: sparseArray2];
    // Resulting sparse array: ( 1: @"b", 2: @"c", 3: @"d", 13: @"n" )

#### Availability
#### See Also  
[- setObjects:atIndexes:](#setobjectsatindexes)  
[- setObject:atIndex:](#setobjectatindex)  
[- setSparseArray:](#setsparsearray)  
#### Declared In
DSSparseArray.h  


### setSparseArray:
Sets the receiving sparse array’s entries to those in another given sparse array.  
\- (void) setSparseArray: (DSSparseArray *) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
The sparse array of objects with which to replace the receiving sparse array's content.  
#### Return value
None.  
#### Discussion
This method empties the reveiving sparse array's content then stores the objects from the *otherSparseArray* in the locations that they are at in *otherSparseArray*.  
#### Availability
#### See Also
[- setObjects:atIndexes:](#setobjectsatindexes)  
[- setObject:atIndex:](#setobjectatindex)  
[- setObjectsFromSparseArray:](#setobjectsfromsparsearray)  
#### Declared In
DSSparseArray.h


### insertObject:atIndex:
Inserts the given object into the sparse array's contents at the given index.  
\- (void) insertObject: (id) *object* atIndex: ([NSUInteger][]) *index*  
#### Parameters
##### *object*
The object to be stored in the sparse array.  
##### *index*
The index within the sparse array at which to store the object.  
#### Return value
None.  
#### Discussion
If index is already occupied, the objects at index and beyond are shifted by adding 1 to their indices to make room.

Note that unlike NSArray objects, mutable sparse arrays do not have a fixed size and objects can be inserted at any index from 0 to NSNotFound - 1. If the object to be inserted is **nil** then it just shifts the remainder of the array by one creating an empty entry.

If an existing array element is shifted beyond the permissible index range (i.e., its index > NSNotFound - 1) it will be silently deleted or generate an **NSRangeException** depending on the status of [setThrowExceptionOnOutOfRangeIndex:](DSSparseArray.md#setThrowExceptionOnOutOfRangeIndex).  
#### Availability
#### See Also
[- setObject:atIndex:](#setobjectatindex)  
#### Declared In
DSSparseArray.h  



### insertObjects:atIndexes:
Inserts the objects in the provided array into the receiving sparse array at the specified indexes.  
\- (void) insertObjects: (NSArray *) *objects* atIndexes: (NSIndexSet *) *indexes*  
#### Parameters
##### *objects*
An NSArray containing the objects to be inserted into the sparse array.  
##### *indexes*
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

If an existing array element is shifted beyond the permissible index range (i.e., its index > NSNotFound - 1) it will be silently deleted or generate an **NSRangeException** depending on the status of [setThrowExceptionOnOutOfRangeIndex:](DSSparseArray.md#setThrowExceptionOnOutOfRangeIndex).  
#### Availability
#### See Also
[- insertObject:atIndex:](#insertobjectatindex)  
[- setObjects:atIndexes:](#setobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeObjectAtIndex:
Removes the object at *index*.  
\- (void) removeObjectAtIndex: ([NSUInteger][]) *index*  
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
[- insertObject:atIndex:](#insertobjectatindex)  
[- removeObjectsAtIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeObject:
Removes all occurrences in the sparse array of a given object.  
\- (void) removeObject: (id) *anObject*  
#### Parameters
##### *anObject*
The object to remove from the sparse array.  
##### *index*
The index within the sparse array at which to store the object.  
#### Return value
None.  
#### Discussion
If the *anObject* parameter is not **nil** this method uses [allIndexesForObject:](DSSparseArray.md#allindexesforobject) to get all the indexes then [removeObjectsAtIndexes:](#removeobjectsatindexes) to remove them from the sparse array. If the *anObject* parameter is **nil** this method removes all the empty sparse array entries, thus compacting all the occupied entries in locations zero to count - 1.  
#### Availability
#### See Also
[- allIndexesForObject:](#allindexesforobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
[- removeObjects:atIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeObjectsAtIndexes:
Removes the objects at the specified indexes from the sparse array.  
\- (void) removeObjectsAtIndexes: (NSIndexSet *) *indexSet*  
#### Parameters
##### *indexSet*
The object to remove from the sparse array.  
##### *indexSet*
The indexes in the sparse array to remove.  
#### Return value
None.
#### Discussion
This method is similar to [removeObjectAtIndex:](#removeobjectatindex), but allows you to efficiently remove multiple objects with a single operation. *indexes* specifies the locations of objects to be removed given the state of the array when the method is invoked, as illustrated in the following example. Both empty entries and entries containing objects can be removed with similar effects.

    DSMutableSparseArray *sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 0, @"a", 1, @"two", 2, @"b", 3, @"three", 4, @"four", 5, @"j", 11, @"ten", 12, nil];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex: 1];
    [indexes addIndex: 3];
    [indexes addIndex: 11];
    [sparseArray removeObjectsAtIndexes: indexes];
    NSLog(@"sparse array: %@", array);
 
    // Output: sparse array: ( 0: one, 1: two, 2: three, 3: four, 9: ten )  
#### Availability
#### See Also
[- allIndexesForObject:](#allindexesforobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
#### Declared In
DSSparseArray.h  



### removeAllObjects
Empties the sparse array of all its elements.  
\- (void) removeAllObjects  
#### Return value
None.  
#### Availability
#### See Also
[- removeObject:](#removeobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
[- removeObjects:atIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeObjectsInRange:
Removes from the sparse array each of the objects within a given range.  
\- (void) removeObjectsInRange: (NSRange) *aRange*  
#### Parameters
##### *aRange*
The range of the objects to remove from the array.  
#### Return value
None.  
#### Discussion
The objects are removed by using [shiftObjectsStartingAtIndex:by:](#shiftobjectsstartingatindexby) with the *startIndex* one higher than the range (range.loc + range.length) and the *delta* equal to the length of the range (range.length).  
#### Availability
#### See Also
[- removeObject:atIndex:](#removeobjectatindex)  
[- removeObjects:atIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeObjectsInArray:
Removes the objects in the given array from the receiving sparse array.  
\- (void) removeObjectsInArray: (NSArray *) *array*  
#### Parameters
##### *array*
An array containing the objects to be removed from the receiving array.  
#### Return value
None.  
#### Discussion
This method is similar to [removeObject:](#removeobject), but allows you to efficiently remove large sets of objects with a single operation. It thus removes all occurances in the receiver sparse array of all objects in the *array*. If the receiving sparse array does not contain objects in *array*, the method has no effect (although it does incur the overhead of searching the contents).  
#### Availability
#### See Also
[- removeObject:](#removeobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
[- removeObjects:atIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### removeLastObject
Removes the object with the highest-valued index in the array  
\- (void) removeLastObject  
#### Return value
None.  
#### Discussion
If there are no objects in the sparse array [removeLastObject](#removelastobject) either nothing will happen, a warning will be written with NSLog() or an **NSRangeException** will be raised depending on the status of [setThrowExceptionOnOutOfRangeIndex:](DSSparseArray.md#setthrowexceptiononoutofrangeindex).  
#### Availability
#### See Also
[- removeAllObjects](#removeallobjects)  
[- removeObject:](#removeobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
#### Declared In
DSSparseArray.h  



### shiftObjectsStartingAtIndex:by:
Shifts a group of sparse array entries up or down within the receiver.  
\- (void) shiftObjectsStartingAtIndex: ([NSUInteger][]) *startIndex* by: (NSInteger) *delta*  
#### Parameters
##### *startIndex*
The location in the sparse array to begin the shifting operation.  
##### *delta*
Amount and direction of the shift. Positive integers shift the objects to have higher indexes. Negative integers shift the objects to have lower indexes.  
#### Return value
None.  
#### Discussion
The group of array entries shifted is made up by *startIndex* and all the entries follow it in the sparse array. A negative shift deletes the entries in a range the length of the shift preceding *startIndex* from he sparse array. A positive shift inserts *delta* empty spaces in the sparseArray beginning with *startIndex*.

    DSMutableSparseArray *array = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 0, @"two", 1, @"three", 2, @"four", 3, @"ten", 9, nil];
    NSLog(@"array: %@", array);
    [array shiftObjectsStartingAtIndex: 1 by: 1];
    NSLog(@"sparse array: %@", array);
    [array shiftObjectsStartingAtIndex: 9 by: -5];
    NSLog(@"sparse array: %@", array);

    // Output:
    //   sparse array: ( 0: one, 1: two, 2: three, 3: four, 9: ten )
    //   sparse array: ( 0: one, 2: two, 3: three, 4: four, 10: ten )
    //   sparse array: ( 0: one, 2: two, 3: three, 5: ten )

The indexes of the resulting sparse array must all be in the range of 0 to NSNotFound - 1. If an existing array element is shifted beyond the permissible index range (i.e., its index < 0 or index > NSNotFound - 1) it will be silently deleted or generate an **NSRangeException** depending on the status of [setThrowExceptionOnOutOfRangeIndex:](DSSparseArray.md#setThrowExceptionOnOutOfRangeIndex).  
#### Availability
#### See Also
[- insertObject:atIndex:](#insertobjectatindex)  
[- removeObject:atIndex:](#removeobjectatindex)  
#### Declared In
DSSparseArray.h  



### filterUsingPredicate:
Evaluates a given predicate against the sparse array’s content and leaves only objects that match  
\- (void) filterUsingPredicate: (NSPredicate *) *predicate*  
#### Parameters
##### *predicate*
The predicate to evaluate against the array's elements.  
#### Return value
None.  
#### Discussion
This method will not shift any entry indexes but will just clear entries that do not match the *prediate*.  
#### Availability
#### See Also
[- removeObject:](#removeobject)  
[- removeObject:atIndex:](#removeobjectatindex)  
[- removeObjects:atIndexes:](#removeobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### init
Initializes a newly allocated sparse array.  
\- (instancetype) init  
#### Return value
An empty mutable sparse array.  
#### Discussion
This method is a designated initializer.  
#### Availability
#### See Also
[- initWithCapacity:](#initwithcapacity)  
#### Declared In
DSSparseArray.h



### initWithCapacity:   
Returns a mutable sparse array, initialized with enough memory to initially hold a given number of objects.  
\- (instancetype) initWithCapacity: ([NSUInteger][]) *numItems*  
#### Parameters
##### *numItems*
The initial capacity of the new mutable sparse array.  
#### Return value
A mutable sparse array initialized with enough memory to hold *numItems* objects. The returned object might be different than the original receiver.  
#### Discussion
Mutable sparse arrays expand as needed; *numItems* simply establishes the object’s initial capacity to potentially save the need to reallocate internal storage.

This method is a designated initializer.  
#### Availability
#### See Also
[+ sparseArrayWithCapacity:](#sparsearraywithcapacity)  
[- init](#init)  
#### Declared In
DSSparseArray.h  

[DSSparseArray]: DSSparseArray.md
[DSMutableSparseArray]: DSMutableSparseArray.md
[NSObject]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/Reference/Reference.html#//apple_ref/occ/cl/NSObject
[NSObject Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSObject_Protocol/Reference/NSObject.html#//apple_ref/occ/intf/NSObject
[NSCopying Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSCopying_Protocol/Reference/Reference.html#//apple_ref/occ/intf/NSCopying
[NSMutableCopying Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSMutableCopying_Protocol/Reference/Reference.html#//apple_ref/occ/intf/NSMutableCopying
[NSSecureCoding Protocol]: https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSSecureCoding_Protocol_Ref/content/NSSecureCoding.html#//apple_ref/occ/intf/NSSecureCoding
[NSUInteger]: https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Miscellaneous/Foundation_DataTypes/Reference/reference.html#//apple_ref/doc/c_ref/NSUInteger
