# DSSparseArray

**Inherits from:** [NSObject][NSObject]  
**Conforms to:** [NSObject] [NSObject Protocol], [NSCopying] [NSCopying Protocol], [NSMutableCopying] [NSMutableCopying Protocol], [NSSecureCoding] [NSSecureCoding Protocol]  

## Overview
[DSSparseArray][] and its subclass [DSMutableSparseArray][] manage ordered collections of objects called sparse arrays, which are similar to regular arrays but can have **nil** entries. The efficiency comes from the fact that a **nil** entry takes no space, it simply does not exist. [DSSparseArray][] creates static sparse arrays and [DSMutableSparseArray][] creates dynamic sparse arrays. You can use sparse arrays when you need an ordered collection of objects that may have non-contiguous indexes.  

## Tasks
### Creating a Sparse Array
[+ sparseArray](#sparsearray)  
[+ sparseArrayWithArray:](#sparsearraywitharray)  
[+ sparseArrayWithSparseArray:](#sparsearraywithsparsearray)  
[+ sparseArrayWithContentsOfFile:](#sparsearraywithcontentsoffile)  
[+ sparseArrayWithContentsOfURL:](#sparsearraywithcontentsofurl)  
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjects:atIndexes:](#sparsearraywithobjectsatindexes)  
[+ sparseArrayWithObjects:atIndexes:count:](#sparsearraywithobjectsatindexescount)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
[+ sparseArrayWithObjectsAndNSUIntegerIndexes:](#sparsearraywithobjectsandnsuintegerindexes)  

### Initializing a Sparse Array
[- init](#init)  
[- initWithArray:](#initwitharray)  
[- initWithDictionary:](#initwithdictionary)  
[- initWithSparseArray:](#initwithsparsearray)  
[- initWithSparseArray:copyItems:](#initwithsparsearraycopyitems)  
[- initWithContentsOfURL:](#initwithcontentsofurl)  
[- initWithContentsOfFile:](#initwithcontentsoffile)  
[- initWithObjects:atIndexes:](#initwithobjectsatindexes)  
[- initWithObjects:atIndexes:count:](#initwithobjectsatindexescount)  
[- initWithObjectsAndIndexes:](#initwithobjectsandindexes)  
[- initWithObjectsAndNSUIntegerIndexes:](#initwithobjectsandnsuintegerindexes)  

### Querying a Sparse Array
[- containsObject:](#containsobject)  
[- count](#countMethod)  
[- firstObject](#firstobject)  
[- lastObject](#lastobject)  
[- objectAtIndex:](#objectatindex)  
[- valueAtIndex:](#valueatindex)  
[- objectsAtIndexes:](#objectsatindexes)  
[- objectsAtIndexes:notFoundMarker:](#objectsatindexesnotfoundmarker)  
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- objectEnumerator](#objectenumerator)  
[- enumerateIndexesAndObjectsUsingBlock:](#enumerateindexesandobjectsusingblock)  
[- enumerateIndexesAndObjectsWithOptions:usingBlock:](#enumerateindexesandobjectswithoptionsusingblock)  

### Finding Objects in a Sparse Array
[- indexOfObject:](#indexofobject)  
[- allIndexesForObject:](#allindexesforobject)  
[- indexOfObjectIdenticalTo:](#indexofobjectidenticalto)  
[- indexesOfEntriesPassingTest:](#indexesofentriespassingtest)  
[- indexesOfEntriesWithOptions:passingTest:](#indexesofentrieswithoptionspassingtest)  

### Comparing Sparse Arrays
[- isEqualToSparseArray:](#isequaltosparsearray)  

### Deriving New Sparse Arrays
[- filteredSparseArrayUsingPredicate:](#filteredsparsearrayusingpredicate)  

### Creating a Description
[- description:](#description)  
[- writeToFile:atomically:](#writetofileatomically)  
[- writeToURL:atomically:](#writetourlatomically)  


## Class Methods

### sparseArray  
Creates and returns an empty sparse array.  
\+ (instancetype) sparseArray  
#### Return value
An empty sparse array.  
#### Discussion
This method is more usefull for by mutable subclasses of DSSparseArray.  
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithArray:
Creates and returns a sparse array containing the objects in the given array.  
\+ (instancetype) sparseArrayWithArray: (NSArray \*) *anArray*  
#### Parameters
##### *anArray*
The array to get the elements from.  
#### Return value
A sparse array containing the objects from anArray in indexes 0 to count - 1.  
#### Discussion
This method is used to create a sparse array containing the contents of anArray.  
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithSparseArray:
Creates and returns a sparse array containing the objects in the given sparse array.  
\+ (instancetype) sparseArrayWithSparseArray: (DSSparseArray \*) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
The sparse array to get the elements from.  
#### Return value
A sparse array containing the objects from otherSparseArray at the indexes from otherSparseArray.  
#### Discussion
This method is used to create a sparse array containing the contents of otherSparseArray.  
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithSparseArray:
Creates and returns a sparse array containing the objects in the given sparse array.  
\+ (instancetype) sparseArrayWithSparseArray: (DSSparseArray \*) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
The sparse array to get the elements from.  
#### Return value
A sparse array containing the objects from otherSparseArray at the indexes from otherSparseArray.  
#### Discussion
This method is used to create a sparse array containing the contents of otherSparseArray.  
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithContentsOfFile:
Creates and returns a sparse array containing the contents of the file specified by a given path.  
\+ (id) sparseArrayWithContentsOfFile: (NSString \*) *aPath*  
#### Parameters
##### *aPath*  
The path to a file containing a string representation of a sparse array produced by the [writeToFile:atomically:](#writetofileatomically) method.  
#### Return value
A sparse array containing the contents of the file specified by *aPath*. Returns **nil** if the file can’t be opened or if the contents of the file can’t be parsed into a sparse array.  
#### Discussion
The sparse array representation in the file identified by *aPath* must contain only property list objects (NSString, NSData, NSDate, NSNumber, NSArray, or NSDictionary objects). For more details, see *[Property List Programming Guide][]*. The objects contained by this sparse array are immutable, even if the sparse array is mutable.  
#### Availability
#### See Also
[- writeToFile:atomically:](#writetofileatomically)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithContentsOfURL:
Creates and returns an array containing the contents specified by a given URL.  
\+ (id) sparseArrayWithContentsOfURL: (NSURL \*) *aURL*  
#### Parameters
##### *aURL*  
The location of a file containing a string representation of a sparse array produced by the [writeToURL:atomically:](#writetourlatomically) method.  
#### Return value
A sparse array containing the contents specified by *aURL*. Returns **nil** if the location can’t be opened or if the contents of the location can’t be parsed into a sparse array.  
#### Discussion
The sparse array representation at the location identified by *aURL* must contain only property list objects (NSString, NSData, NSArray, or NSDictionary objects). For more details, see *[Property List Programming Guide][]*. The objects contained by this sparse array are immutable, even if the sparse array is mutable.  
#### Availability
#### See Also
[- writeToURL:atomically:](#writetourlatomically)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithObjects:atIndexes:
Creates and returns a sparse array containing the objects at the indexes.  
\+ (instancetype) sparseArrayWithObjects: (NSArray \*) *objects* atIndexes: (NSIndexSet \*) *indexSet*  
#### Parameters
##### *objects*
The objects the sparse array will contain.  
##### *indexSet*
The indexes within the sparse array the objects will be placed at.  
#### Return value
A sparse array containing the objects at the indexes.  
#### Discussion
This method is used to create a sparse array containing the objects from an array at specified locations. The count of the array of objects must equal the count of the index set.  
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithObjects:atIndexes:count:
Creates and returns a sparse array that includes a given number of objects at the indexes from the given C arrays.  
\+ (instancetype) sparseArrayWithObjects: (const id[]) *objects* atIndexes: (const [NSUInteger][][]) *indexes* count: ([NSUInteger][]) *count*  
#### Parameters
##### *objects*
The objects the sparse array will contain.  
##### *indexes*
The indexes within the sparse array the objects will be placed at.  
##### *count*
The number of values from the objects C arrays to include in the new sparse array. This number will be the count of the new array—it must not be negative or greater than the number of elements in objects.  
#### Return value
A new sparse array including the first count objects from objects at the locations from indexes.  
#### Discussion
Elements are added to the new sparse array in the same order they appear in *objects*, up to but not including index *count*. For example:

    NSString *strings[3];
    strings[0] = @"First";
    strings[1] = @"Second";
    strings[2] = @"Third";
    NSUInteger indexes[3];
    indexes[0] = 10;
    indexes[1] = 20;
    indexes[2] = 30;
 
    DSSparseArray *decadesArray = [DSSparseArray arrayWithObjects: strings atIndexes: indexes count: 2];
    // decades array contains { 10: @"First", 20: @"Second" }
#### Availability
#### See Also
[+ sparseArrayWithObjects:atIndexes:](#sparsearraywithbjectsatindexes)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithObjectsAndIndexes:
Creates and returns a sparse array containing the objects at the indexes in the argument list.  
\+ (instancetype) sparseArrayWithObjectsAndIndexes: (id) *firstObj*, (int) *firstIndex*, ... *nil*  
#### Parameters
##### *firstObj, firstIndex, ...*  
A comma-separated list of object and index pairts ending with **nil**.  
#### Return value
A sparse array containing the objects at the indexes from the argument list.  
#### Discussion
This method is used to create a sparse array containing the objects at the indexes liseted. This is similar to [sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes) except for how the index-object pairs are specified. This code example creates a sparse array containing three different types of element:

    DSSparseArray *myArray;
    NSDate *aDate = [NSDate distantFuture];
    NSValue *aValue = [NSNumber numberWithInt: 5];
    NSString *aString = @"a string";

    mySparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: aDate, 10, aValue, 20, aString, 30, nil];

#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndNSUIntegerIndexes:](#sparsearraywithobjectsandnsuintegerindexes)  
#### Declared In
DSSparseArray.h  


### sparseArrayWithObjectsAndNSUIntegerIndexes:
Creates and returns a sparse array containing the objects at the indexes in the argument list.  
\+ (instancetype) sparseArrayWithObjectsAndNSUIntegerIndexes: (id) *firstObject*, ([NSUInteger][]) *firstIndex*, ... *nil*  
#### Parameters
##### *firstObj, firstIndex, ...*
A comma-separated list of object and [NSUInteger][] index pairs ending with **nil**.  
#### Discussion
This method is the same as [sparseArrayWithObjectsAndIndexes:](#sparsearrayWithobjectsandindexes) except the indexes are type [NSUInteger][]. This is added because of default argument promotion for variadic functions in C. What this means is numeric arguments that are smaller than an **int** are increased in size to an *int* when there is no prototype declaring and defining the size. As a result [sparseArrayWithObjectsAndIndexes:](#sparsearrayWithobjectsandindexes) will pass its indexes as *int* values unless they will not fit within an **int** but within the method there is no way to tell if the index value is an **int** or a **long**. This method requires that all the index values be of the [NSUInteger][] size (which could be 32 bits or 64 bits depending on the machine architecture, OS version, etc.). This code example creates a sparse array portably with very large index values:

    DSSparseArray *myArray;
    NSDate *aDate = [NSDate distantFuture];
    NSValue *aValue = [NSNumber numberWithInt: 5];
    NSString *aString = @"a string";
    
    mySparseArray = [DSSparseArray sparseArrayWithObjectsAndNSUIntegerIndexes: aDate, (NSUInteger) NSNotFound-30, aValue, (NSUInteger) NSNotFound-20, aString, (NSUInteger) NSNotFound-10, nil];

#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  


### setThrowExceptionOnIndexOutOfRange:
Sets object functionality for objects whose indexes go out of range  
\+ (void) setThrowExceptionOnIndexOutOfRange: (unsigned int) *throwMode*  
#### Parameters
##### *throwMode*
**IndexOutOfRangeNoThrowNoWarn** for no exception throwing, **IndexOutOfRangeNoThrowButLogWarning** for no exception throwing but printing a warning by NSLog, **IndexOutOfRangeThrowIfNonEmpty** for throwing an exception if an operation causes a array entry to be pushed out of the array either at the top or bottom, **IndexOutOfRangeThrowIfAny** for throwing an exception if an operation causes even an empty array entry to be pushed out of the array at the bottom or if the requested start location is shifted off the top.  
#### Return value
None.  
#### Discussion
Sparse array indexes are limited to a minium of zero and a maximum value of NSNotFound - 1. Therefore if shift or insertion operations move objects to where their index would be less than zero or greater than NSNotFound - 1 something must be done. If the *throwMode* has been set to **IndexOutOfRangeNoThrowNoWarn** (the default), then the entries are deleted. If the *throwMode* has been set to **IndexOutOfRangeNoThrowButLogWarning** the entries are also deleted but a warning is placed printed by NSLog(). If the *throwMode* has been set to **IndexOutOfRangeThrowIfNonEmpty** then an **[NSRangeException][]** is thrown if a non-empty array entry would have its index set less than zero or greater than NSNotFound - 1. Lastly, if the throwMode has been to **IndexOutOfRangeThrowIfAny** then an **[NSRangeException][]** would be thrown if any array entry, even an empty one, would have its index set to less than zero (e.g. shift entry at index 5 by negative 10) or if the selected start location of a shift would be shifted to have an index greater than NSNotFound - 1.  
#### Availability
#### See Also
#### Declared In
DSSparseArray.h  


## Instance Methods

### containsObject:
Returns a Boolean value that indicates whether a given object is present in the sparse array.  
\- (BOOL) containsObject: (id) anObject  
#### Parameters
##### *anObject*
An object.  
#### Return value
YES if *anObject* is present in the sparse array, otherwise NO.  
#### Discussion
This method determines whether *anObject* is present in the sparse array by sending an [isEqual:][] message to each of the array’s objects (and passing *anObject* as the parameter to each [isEqual:][] message).  
#### Availability
#### See Also
[- indexOfObject:](#indexofobject)  
#### Declared In
DSSparseArray.h  



### <a name="countMethod"/>count
Returns the number of objects currently in the sparse array  
\- ([NSUInteger][]) count  
#### Return value
The number of objects currently in the sparse array.  
#### Discussion
Unlike a regular array the objects in sparse array do not necessarily be at contiguous indexes starting at zero. The method returns the number of non-empty array entries.  
#### Availability
#### See Also
[- allIndexes](#allindexes)  
#### Declared In
DSSparseArray.h  



### description
Returns a string that represents the contents of the array.
\- (NSString *) description  
#### Parameters
#### Return value
A string that represents the contents of the array.  
#### Discussion  
#### Availability  
#### See Also  
#### Declared In  
DSSparseArray.h  


### allIndexes
Returns an NSIndexSet containing the indexes of all the non-empty entries in the sparse array.  
\- (NSIndexSet *) allIndexes  
#### Return value
An NSIndexSet containing the indexes of all the non-empty entries in the sparse array.  
#### Discussion
This can be used for finding the first, last, or other entries in the sparse array.  
#### Availability
#### See Also
[- count](#countMethod)  
[- allObjects](#allobjects)  
#### Declared In
DSSparseArray.h  


### indexOfObject:
Returns the lowest index whose corresponding sparse array value is equal to a given object.  
\- ([NSUInteger][]) indexOfObject: (id) *anObject*  
#### Parameters
##### *anObject*
The object to get the index of.  
#### Return value
The lowest index whose corresponding sparse array value is equal to *anObject*. If none of the objects in the sparse array is equal to *anObject*, returns NSNotFound.  
#### Discussion
If *anObject* is not **nil**, starting at index 0, each element of the sparse array is sent an [isEqual:][] message until a match is found or the end of the sparse array is reached. This method passes the *anObject* parameter to each [isEqual:][] message. Objects are considered equal if [isEqual:][] (declared in the [NSObject protocol][NSObject Protocol] returns YES.  
If *anObject* is **nil** the index of the first empty sparse array location is returned or NSNotFound if completely full.
#### Availability
#### See Also
[- allIndexesForObject:](#allindexesforobject)  
[- indexOfObjectIdenticalTo:](#indexofobjectidenticalto)  
#### Declared In
DSSparseArray.h  


### indexOfObjectIdenticalTo:
Returns the lowest index whose corresponding object is identical to a given object.  
\- ([NSUInteger][]) indexOfObjectIdenticalTo: (id) *anObject*  
#### Parameters
##### *anObject*
The object to get the index of.  
#### Return value
The lowest index whose corresponding sparse array object is identical to *anObject*. If none of the objects in the sparse array is identical to *anObject*, returns NSNotFound.  
#### Discussion
If *anObject* is not **nil**, objects are considered identical if their object addresses are the same.  
If *anObject* is **nil** the index of the first empty sparse array location is returned or NSNotFound if the sparse array is completely full.  
#### Availability
#### See Also
[- allIndexesForObject:](#allindexesforobject)  
[- indexOfObject:](#indexofobject)  
#### Declared In
DSSparseArray.h  


### firstObject
Returns the first object in the sparse array.  
\- (id) firstObject  
#### Return value
The first object in the sparse array. If the array is empty, returns **nil**.  
#### Discussion  
Provides a convenient method to retrieve the object in the sparse array with the lowest index. To find out the lowest index itself use the [firstIndex][NSIndexSet_firstIndex] method on the [NSIndexSet][] returned by [allIndexes](#allindexes).
#### Availability  
#### See Also  
[- lastObject](#lastobject)  
[- allIndexes](#allindexes)  
#### Declared In  
DSSparseArray.h  


### lastObject
Returns the last object in the sparse array.  
\- (id) lastObject  
#### Return value  
The last object in the sparse array. If the array is empty, returns **nil**.  
#### Discussion  
Provides a convenient method to retrieve the object in the sparse array with the highest index. To find out the highest index itself use the [lastIndex][NSIndexSet_lastIndex] method on the [NSIndexSet][] returned by [allIndexes](#allindexes).
#### Availability  
#### See Also  
[- firstObject](#firstobject)  
[- allIndexes](#allindexes)  
#### Declared In  
DSSparseArray.h  


### objectEnumerator
Returns an enumerator object that lets you access each object in the sparse array.  
\- ([DSSparseArrayEnumerator][] *) objectEnumerator  
#### Return value
An enumerator object that lets you access each object in the array, in order, from the element at the lowest index upwards to the element at the highest index skipping empty entries. Returns **nil** when there are not more entries.  
#### Discussion
Returns an enumerator object that lets you access each object in the array, in order, starting with the element at the lowest index, as in:

    NSEnumerator *enumerator = [mySparseArray objectEnumerator];
    id anObject;

    while( (anObject = [enumerator nextObject]) ) {
        /* code to act on each element as it is returned */
    }

The [DSSparseArrayEnumerator][] is a subclass of [NSEnumerator][] that adds the [- (NSUInteger) indexOfNextObject](#indexofnextobject) that will return the index in the sparse array of the object that will be returned with the next call to [-(id) nextObject](#nextobject).

    DSSparseArrayEnumerator *enumerator = [mySparseArray objectEnumerator];
    NSUInteger idx;
    id anObject;

    while( (idx = [enumerator indexOfNextObject]) != NSNotFound ) {
        anObject = [enumerator nextObject];
	NSLog( @"%lu: %@", (unsigned long) idx, anObject );
    }

#### Special Considerations
When you use this method with mutable subclasses of [DSSparseArray][], you must not modify the array during enumeration.  
#### Availability
Available in OS X v10.0 and later.  
#### See Also
[- reverseObjectEnumerator](#reverseobjectenumerator)  
[- enumerateIndexesAndObjectsUsingBlock:](#enumerateindexesandobjectsusingblock)  
[- enumerateIndexesAndObjectsWithOptions:usingBlock:](#enumerateindexesandobjectswithoptionsusingblock)  
#### Declared In
DSSparseArray.h  


### reverseObjectEnumerator
Returns an enumerator object that lets you access each object in the sparse array, in reverse order.  
\- ([DSSparseArrayEnumerator][] *) reverseObjectEnumerator  
#### Return value
An enumerator object that lets you access each object in the array, in order, from the element at the highest index down to the element at the lowest index skipping empty entries. Returns **nil** when there are no more entries  
#### Discussion
The [DSSparseArrayEnumerator][] is a subclass of [NSEnumerator][] that adds the [- (NSUInteger) indexOfNextObject](DSSparseArrayEnumerator.md#indexofnextobject) method that will return the index in the sparse array of the object that will be returned with the next call to [-(id) nextObject](DSSparseArrayEnumerator.md#nextobject).
#### Special Considerations
When you use this method with mutable subclasses of [DSSparseArray][], you must not modify the array during enumeration.  
#### Availability
Available in OS X v10.0 and later.  
#### See Also
[- objectEnumerator](#objectenumerator)  
[- enumerateIndexesAndObjectsUsingBlock:](#enumerateindexesandobjectsusingblock)  
[- enumerateIndexesAndObjectsWithOptions:usingBlock:](#enumerateindexesandobjectswithoptionsusingblock)  
#### Declared In
DSSparseArray.h  


### allIndexesForObject:
Returns the indexes of objects in the sparse array that are equal to a given object.  
\- (NSIndexSet *) allIndexesForObject: (id) *anObject*  
#### Parameters
##### *anObject*
The object to get the indexes for.  
#### Return value
The indexes whose corresponding values in the sparse array are equal to *anObject*. If no objects in the sparse array are equal, returns an empty index set. If *anObject* is **nil** the indexes of the empty entries in the sparse array are returned.  
#### Discussion
Starting at the lowest index, each element of the sparse array is sent an [isEqual:][] message and if equal its index is added to the index set that will be returned. This method passes the *anObject* parameter to each [isEqual:][] message. Objects are considered equal if [isEqual:][] (declared in the [NSObject protocol][NSObject Protcol]) returns YES.  
#### Availability
Available in OS X v10.0 and later.  
#### See Also
[- indexOfObject:](#indexOfobject)  
#### Declared In
DSSparseArray.h  


### valueAtIndex:
Returns the object located at the specified index.  
\- (id) valueAtIndex: ([NSUInteger][]) *index*  
#### Parameters
##### *index*
The index to get the value for.
#### Return value
The object located at *index* which, since this is a sparse array, could be nil.
#### Discussion
This is a synonym for [objectAtIndex:](#objectatindex). Any value of index is permissible from 0 to NSNotFound - 1 but will return **nil** for any entry that has not been set.
#### Availability
#### See Also
[- objectAtIndex](#objectatindex)  
#### Declared In
DSSparseArray.h  


### allObjects
Returns a new array containing the sparse array's values.  
\- (NSArray *) allObjects  
#### Return value
A new array containing the sparse array's values, or an empty array if the sparse array has no entries.
#### Discussion
The order of the values in the array is the same as their order in the receiver.
#### Availability
#### See Also
[- allIndexes](#allindexes)  
[- getObjects:andIndexes:](#getobjectsandindexes)  
[- objectEnumerator](#objectenumerator)  
#### Declared In
DSSparseArray.h  


### getObjects:andIndexes:
Returns by reference C arrays of the indexes and values in the sparse array.  
\- (void) getObjects: (__unsafe_unretained id []) *objects* andIndexes: ([NSUInteger][] []) *indexes*  
#### Parameters
##### *objects*
Upon return, contains a C array of the values or objects in the sparse array.
##### *indexes*
Upon return, contains a C array of the indexes in the sparse array.
#### Return value
None.
#### Discussion
The elements in the returned arrays are ordered from smallest index to largest index such that the first element in *objects* is the value for the first index in *indexes* and so on.

    id __unsafe_unretained *objectArray;
    NSUInteger *indexArray;
    NSUInteger count;
    
    count = [spouseArray count];
    objectArray = (__unsafe_unretained id *) malloc( count * sizeof(id) );
    indexArray = (NSUInteger *) malloc( count * sizeof(NSUInteger) );
    [sparseArray getObjects: objectArray andIndexes: indexArray];
    
    /* Use objects and indexes from arrays... */

    free( objectArray );
    free( indexArray );

#### Availability
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
#### Declared In
DSSparseArray.h  


### enumerateIndexesAndObjectsUsingBlock:
Executes a given block using each object in the sparse array, starting with the first object and continuing through the array to the last object.  
\- (void) enumerateIndexesAndObjectsUsingBlock: (void (^)( id obj, [NSUInteger][] idx, BOOL *stop )) *block*  
#### Parameters
##### *block*
A block object to operate on entries in the sparse array.  
The block takes three arguments:  
*obj*  
The element in the sparse array.  
*idx*  
The index of the element in the array.  
*\*stop*  
A reference to a Boolean value. The block can set the value to YES to stop further processing of the sparse array. The stop argument is an out-only argument. You should only ever set this boolean to YES within the *block*.  
#### Return value
None.
#### Discussion
If the block sets *stop to YES, the enumeration stops.
This method executes synchronously.
#### Availability
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- enumerateIndexesAndObjectsWithOptions:usingBlock:](#enumerateindexesandobjectswithoptionsusingblock)  
#### Declared In
DSSparseArray.h  


### enumerateIndexesAndObjectsWithOptions:usingBlock:
Executes a given block using each object in the sparse array.  
\- (void) enumerateIndexesAndObjectsWithOptions: ([NSEnumerationOptions][]) *opts* usingBlock: (void (^)( id obj, [NSUInteger][] idx, BOOL *stop )) *block*  
#### Parameters
##### *opts*
A bit mask that specifies the options for the enumeration (whether it should be performed concurrently and/or whether it should be performed in reverse order).
##### *block*
A block object to operate on entries in the sparse array.  
The block takes three arguments:  
*obj*  
The element in the sparse array.  
*idx*  
The index of the element in the array.  
*\*stop*  
A reference to a Boolean value. The block can set the value to YES to stop further processing of the sparse array. The stop argument is an out-only argument. You should only ever set this boolean to YES within the *block*.
#### Return value
None.
#### Discussion
By default, the enumeration starts with the first object and continues serially through the sparse array to the last object. You can specify NSEnumerationConcurrent and/or [NSEnumerationReverse][] as enumeration options to modify this behavior.

This method executes synchronously.
#### Availability
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- enumerateIndexesAndObjectsUsingBlock:](#enumerateindexesandobjectsusingblock)  
#### Declared In
DSSparseArray.h  


### filteredSparseArrayUsingPredicate:
Evaluates a given predicate against each object in the receiving sparse array and returns a new sparse array containing the objects for which the predicate returns true.  
\- (DSSparseArray *) filteredSparseArrayUsingPredicate: (NSPredicate \*) *predicate*  
#### Parameters
##### *predicate*
The predicate against which to evaluate the receiving array’s elements.
#### Return value
A new sparse array containing the objects in the receiving array for which *predicate* returns true.
#### Discussion
For more details, see Predicate Programming Guide.
#### Availability
Available in OS X v10.4 and later.
#### See Also
[- objectAtIndex](#objectatindex)  
#### Declared In
DSSparseArray.h  



### indexesOfEntriesPassingTest:
Returns the indexes of objects in the sparse array that pass a test in a given Block.  
\- (NSIndexSet *) indexesOfEntriesPassingTest: (BOOL (^)( [NSUInteger][] idx, id obj, BOOL *stop) ) *predicate*  
#### Parameters
##### *predicate*
The block to apply to elements in the sparse array.

The block takes three arguments:  
*obj*  
The element in the sparse array.  
*idx*  
The index of the element in the array.  
*\*stop*  
A reference to a Boolean value. The block can set the value to YES to stop further processing of the sparse array. The stop argument is an out-only argument. You should only ever set this boolean to YES within the *block*.

The Block returns a Boolean value that indicates whether obj passed the test.
#### Return value
The indexes whose corresponding entries in the sparse array pass the test specified by *predicate*. If no objects in the sparse array pass the test, returns an empty index set.

The method uses _Entries_ instead of _Objects_ in its name since the test can utilize the index or the object at each tested entry.  
#### Availability
Available in OS X v10.6 and later.
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- enumerateIndexesAndObjectsUsingBlock:](#enumerateindexesandobjectsusingblock)  
[- indexesOfEntriesWithOptions:passingTest:](#indexesofentrieswithoptionspassingtest)  
#### Declared In
DSSparseArray.h  



### indexesOfEntriesWithOptions:passingTest:
Returns the indexes of objects in the array that pass a test in a given Block for a given enumeration options bitmask.  
\- (NSIndexSet *) indexesOfEntriesWithOptions: ([NSEnumerationOptions][]) *opts* passingTest: (BOOL (^)( [NSUInteger][] idx, id obj, BOOL *stop )) *predicate*  
#### Parameters
##### *opts*
A bit mask that specifies the options for the enumeration (whether it should be performed concurrently and/or whether it should be performed in reverse order).
##### *predicate*
The block to apply to elements in the sparse array.

The block takes three arguments:  
*obj*  
The element in the sparse array.  
*idx*  
The index of the element in the array.  
*\*stop*  
A reference to a Boolean value. The block can set the value to YES to stop further processing of the sparse array. The stop argument is an out-only argument. You should only ever set this boolean to YES within the *block*.  

The Block returns a Boolean value that indicates whether obj passed the test.
#### Return value
The indexes whose corresponding entries in the sparse array pass the test specified by *predicate*. If no objects in the sparse array pass the test, returns an empty index set.
#### Discussion
By default, the enumeration starts with the first object and continues serially through the sparse array to the last object. You can specify [NSEnumerationConcurrent][] and/or [NSEnumerationReverse][] as enumeration options to modify this behavior.

The method uses _Entries_ instead of _Objects_ in its name since the test can utilize the index or the object at each tested entry.  
#### Availability
Available in OS X v10.6 and later.
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- indexesOfEntriesPassingTest:](#indexesofentriespassingtest)  
#### Declared In
DSSparseArray.h  

### init
Initializes a newly allocated sparse array.  
\- (instancetype) init  
#### Return value
A sparse array.
#### Discussion
After an immutable sparse array has been initialized in this way, it cannot be modified.

This method is a designated initializer.
#### Availability
#### See Also
[- initWithObjectsAndIndexes:](#initwithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithArray:
Initializes a newly allocated sparse array by placing in it the objects contained in a given array.  
\- (instancetype) initWithArray: (NSArray \*) *array*  
#### Parameters
##### *array*
An array
#### Return value
A sparse array initialized to contain the objects in *array*. The returned object might be different than the original receiver.
#### Discussion
After an immutable sparse array has been initialized in this way, it cannot be modified.
#### Availability
#### See Also
[- initWithObjects:atIndexes:](#initwithobjectsatindexes)  
[- initWithObjectsAndIndexes:](#initwithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithDictionary:
Initializes a newly allocated sparse array by placing in it the objects contained in a given dictionary.  
\- (instancetype) initWithArray: (NSDictionary \*) *dictionary*  
#### Parameters
##### *dictionary*
A dictionary
#### Return value
A sparse array initialized to contain the objects in *dictionary*. The returned object might be different than the original receiver.
#### Discussion
The **keys** for the entries in the *dictionary* must respond to the **integerValue** method with the index the object is to be placed at. After an immutable sparse array has been initialized in this way, it cannot be modified.
#### Availability
#### See Also
[- initWithObjects:atIndexes:](#initwithobjectsatindexes)  
#### Declared In
DSSparseArray.h  



### initWithSparseArray:
Initializes a newly allocated sparse array by placing in it the objects contained in a given sparse array.  
\- (instancetype) initWithSparseArray: (DSSparseArray \*) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
A sparse array containing the objects with which to initialize the new array.
#### Return value
A sparse array initialized to contain the objects in *otherSparseArray*. The returned object might be different than the original receiver.
#### Discussion
After an immutable sparse array has been initialized in this way, it cannot be modified.
#### Availability
#### See Also
[- initWithObjectsAndIndexes:](#initwithobjectsandindexes)  
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithContentsOfFile:
Initializes a newly allocated sparse array with the contents of the file specified by a given path.  
\- (id) initWithContentsOfFile: (NSString \*) *aPath*  
#### Parameters
##### *aPath*
The path to a file containing a representation of a sparse array produced by the [writeToFile:atomically:](#writetofileatomically) method.  
#### Return value
A sparse array initialized to contain the contents of the file specified by *aPath* or **nil** if the file can’t be opened or the contents of the file can’t be parsed into a sparse array. The returned object might be different than the original receiver.  
#### Discussion
The sparse array representation in the file identified by *aPath* must contain only property list objects (NSString, NSData, NSArray, or NSDictionary objects). For more details, see *[Property List Programming Guide][]*. The objects contained by this sparse array are immutable, even if the sparse array is mutable.  
#### Availability
#### See Also
[+ sparseArrayWithContentsOfFile:](#sparsearraywithcontentsoffile)  
[- writeToFile:atomically:](#writetofileatomically)  
#### Declared In
DSSparseArray.h  



### initWithContentsOfURL:
Initializes a newly allocated sparse array by placing in it the objects contained in a given sparse array.  
\- (id) initWithContentsOfURL: (NSURL \*) *aURL*  
#### Parameters
##### *aURL*
The location of a file containing a string representation of an array produced by the [writeToURL:atomically:](#writetourlatomically) method.
#### Return value
A sparse array initialized to contain the contents specified by *aURL*. Returns **nil** if the location can’t be opened or if the contents of the location can’t be parsed into a sparse array. The returned object might be different than the original receiver.
#### Discussion
The sparse array representation at the location identified by *aURL* must contain only property list objects (NSString, NSData, NSArray, or NSDictionary objects). For more details, see *[Property List Programming Guide][]*. The objects contained by this sparse array are immutable, even if the sparse array is mutable.  
#### Availability
#### See Also
[+ sparseArrayWithContentsOfURL:](#sparsearraywithcontentsofurl)  
[- writeToURL:atomically:](#writetourlatomically)  
#### Declared In
DSSparseArray.h  



### initWithObjects:atIndexes:
Initializes a newly allocated sparse array by placing in it the objects contained in a given array at the indexes in the index set.  
\- (instancetype) initWithObjects: (NSArray \*) *objects* atIndexes: (NSIndexSet \*) *indexSet*  
#### Parameters
##### *objects*
The objects the sparse array will contain.
##### *indexSet*
The indexes within the sparse array the objects will be placed at.
#### Return value
A sparse array containing the objects at the indexes.
#### Discussion
This method initializes a sparse array with the objects from an array at specified locations. The count of the array of objects must equal the count of the index set.
#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithObjects:atIndexes:count:
Initializes a newly allocated sparse array to include a given number of objects at the specified indexes from the given C arrays.  
\- (instancetype) initWithObjects: (const id []) *objects* atIndexes: (const [NSUInteger][][]) *indexes* count: ([NSUInteger][]) *count*  
#### Parameters
##### *objects*
A C array of objects.
##### *indexes*
The indexes within the sparse array the objects will be placed at.
##### *count*
The number of values from the objects C arrays to include in the new sparse array. This number will be the count of the new array—it must not be negative or greater than the number of elements in objects.
#### Return value
A newly allocated sparse array including the first count objects from *objects* at the locations in *indexes*. The returned object might be different than the original receiver.
#### Discussion
Elements are added to the sparse array in the same order they appear in *objects*, up to but not including index *count*. For example:

    NSString *strings[3];
    strings[0] = @"First";
    strings[1] = @"Second";
    strings[2] = @"Third";
    NSUInteger indexes[3];
    indexes[0] = 10;
    indexes[1] = 20;
    indexes[2] = 30;
 
    DSSparseArray *decadesArray = [[DSSparseArray alloc] initWithObjects: strings atIndexes: indexes count: 2];
    // decades array contains { 10: @"First", 20: @"Second" }
#### Availability
#### See Also
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
[+ sparseArrayWithObjects:atIndexes:count:](#sparsearraywithobjectsatindexescount)  
#### Declared In
DSSparseArray.h  



### initWithObjectsAndIndexes:
Initializes and returns a newly allocated sparse array containing the objects at the indexes in the argument list.  
\- (instancetype) initWithObjectsAndIndexes: (id) *firstObject*, (int) *firstIndex*, ... *nil*  
#### Parameters
##### *firstObj, firstIndex, ...*
A comma-separated list of object and index pairs ending with **nil**.
#### Return value
A sparse array containing the objects at the indexes from the argument list.
#### Discussion
This method is used to initialize a sparse array containing the objects at the indexes liseted. This is similar to [initWithObjects:atIndexes:](#initwithobjectsatindexes) except for how the index-object pairs are specified. This code example creates a sparse array containing three different types of element:

    DSSparseArray *myArray;
    NSDate *aDate = [NSDate distantFuture];
    NSValue *aValue = [NSNumber numberWithInt: 5];
    NSString *aString = @"a string";

    mySparseArray = [[DSSparseArray alloc] initWithObjectsAndIndexes: aDate, 10, aValue, 20, aString, 30, nil];

#### Availability
#### See Also
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithObjectsAndNSUIntegerIndexes:
Initializes and returns a newly allocated sparse array containing the objects at the indexes in the argument list.  
\- (instancetype) initWithObjectsAndNSUIntegerIndexes: (id) *firstObject*, ([NSUInteger][]) *firstIndex*, ..., *nil*  
#### Parameters
##### *firstObj, firstIndex, ...*
A comma-separated list of object and [NSUInteger][] index pairs ending with **nil**.
#### Discussion
This method is the same as [initWithObjectsAndIndexes:](#initwithobjectsandindexes) except the indexes are type [NSUInteger][]. This is added because of default argument promotion for variadic functions in C. What this means is numeric arguments that are smaller than an *int* are increased in size to an *int* when there is no prototype declaring and defining the size. As a result [sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes) will pass its indexes as *int* values unless they will not fit within an *int* but within the method there is no way to tell if the index value is an **int** or a **long**. This method requires that all the index values be of the [NSUInteger][] size (which could be 32 bits or 64 bits depending on the machine architecture, OS version, etc.). This code example creates a sparse array portably with very large index values:

    DSSparseArray *myArray;
    NSDate *aDate = [NSDate distantFuture];
    NSValue *aValue = [NSNumber numberWithInt: 5];
    NSString *aString = @"a string";

    mySparseArray = [[DSSparseArray alloc] initObjectsAndNSUIntegerIndexes: aDate, (NSUInteger) NSNotFound-30, aValue, (NSUInteger) NSNotFound-20, aString, (NSUInteger) NSNotFound-10, nil];

#### Availability
#### See Also
[- initWithObjectsAndIndexes:](#initwithobjectsandindexes)  
[+ sparseArrayWithObject:atIndex:](#sparsearraywithobjectatindex)  
[+ sparseArrayWithObjectsAndIndexes:](#sparsearraywithobjectsandindexes)  
#### Declared In
DSSparseArray.h  



### initWithSparseArray:copyItems:
Initializes a newly allocated sparse array by placing in it the objects contained in a given sparse array.  
\- (instancetype) initWithSparseArray: (DSSparseArray \*) *otherSparseArray* copyItems: (BOOL) *flag*  
#### Parameters
##### *otherSparseArray*
A sparse array containing the objects with which to initialize the new array.
##### *flag*
If YES, each object in *otherSparseArray* receives a [copyWithZone:][] message to create a copy of the object—objects must conform to the NSCopying protocol. In a managed memory environment, this is instead of the retain message the object would otherwise receive. The object copy is then added to the returned sparse array at its same index value.
If NO, then in a managed memory environment each object in *otherSparseArray* simply receives a retain message when it is added to the returned sparse array.
#### Return value
A sparse array initialized to contain the objects—or if flag is YES, copies of the objects—in *otherSparseArray*. The returned object might be different than the original receiver.
#### Discussion
After an immutable sparse array has been initialized in this way, it cannot be modified.

The [copyWithZone:][] method performs a shallow copy. If you have a collection of arbitrary depth, passing YES for the flag parameter will perform an immutable copy of the first level below the surface. If you pass NO the mutability of the first level is unaffected. In either case, the mutability of all deeper levels is unaffected.
#### Availability
#### See Also
[- init](#init)  
[- initWithObjects:atIndexes:](#initwithobjectsatindexes)  
[- initWithSparseArray:](#initWithSparseArray)  
#### Declared In
DSSparseArray.h  



### isEqualToSparseArray:
Compares the receiving sparse array to another sparse array.  
\- (BOOL) isEqualToSparseArray: (DSSparseArray \*) *otherSparseArray*  
#### Parameters
##### *otherSparseArray*
A sparse array.
#### Return value
YES if the contents of *otherSparseArray* are equal to the contents of the receiving sparse array, otherwise NO.
#### Discussion
Two arrays have equal contents if they each hold the same number of objects and objects at a given index in each array satisfy the [isEqual:][] test.
#### Availability
Available in OS X v10.0 and later.
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
#### Declared In
DSSparseArray.h  



### objectsAtIndexes:
Returns a sparse array containing the objects in the sparse array at the indexes specified by a given index set.  
\- (DSSparseArray *) objectsAtIndexes: (NSIndexSet \*) *indexes*  
#### Parameters
##### *indexes*
An index set.
#### Return value
A sparse array containing the objects in the sparse array at the indexes specified by *indexes*.  
#### Discussion
The returned objects are at the indexes specified by *indexes*. This method is equivalent to [objectsAtIndexes:notFoundMarker:](#objectsatindexesnotfoundmarker) with **nil** passed as the **notFoundMarker** object.  
#### Availability
Available in OS X v10.0 and later.
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects)  
[- objectsAtIndexes:notFoundMarker:](#objectsatindexesnotfoundmarker)  
#### Declared In
DSSparseArray.h  



### objectsAtIndexes:notFoundMarker:
Returns a sparse array containing the objects in the sparse array at the indexes specified by a given index set.  
\- (DSSparseArray *) objectsAtIndexes: (NSIndexSet \*) *indexes* notFoundMarker: (id) *anObject*  
#### Parameters
##### *indexes*
An index set.
##### *anObject*
An object to use for empty entries in the receiving sparse array. This can be **nil**.  
#### Return value
A sparse array containing the objects in the sparse array at the indexes specified by *indexes*.  
#### Discussion
The returned objects are at the indexes in *indexes*. Any empty location is filled in by *anObject*.    
#### Availability
Available in OS X v10.0 and later.
#### See Also
[- allIndexes](#allindexes)  
[- allObjects](#allobjects) 
[- objectsAtIndexes:](#objectsatindexes) 
#### Declared In
DSSparseArray.h  



### writeToFile:atomically:
Writes the contents of the sparse array to a file at a given path.  
\- (BOOL) writeToFile: (NSString \*) *path* atomically: (BOOL) *flag*  
#### Parameters
##### *path*
The path at which to write the contents of the sparse array.  
If path contains a tilde (~) character, you must expand it with [stringByExpandingTildeInPath][] before invoking this method.
##### *flag*
If **YES**, the sparse array is written to an auxiliary file, and then the auxiliary file is renamed to path. If **NO**, the array is written directly to path. The **YES** option guarantees that path, if it exists at all, won’t be corrupted even if the system should crash during writing.
#### Return value
YES if the file is written successfully, otherwise NO.  
#### Discussion
If the sparse array’s contents are all property list objects (NSString, NSData, NSArray, or NSDictionary objects), the file written by this method can be used to initialize a new sparse array with the class method [sparseArrayWithContentsOfFile:](#sparsearraywithcontentsoffile) or the instance method [initWithContentsOfFile:](#initwithcontentsoffile). This method recursively validates that all the contained objects are property list objects before writing out the file, and returns **NO** if all the objects are not property list objects, since the resultant file would not be a valid property list.  

For more information about property lists, see *[Property List Programming Guide][]*.  
#### Availability
Available in OS X v10.0 and later.
#### See Also
[+ sparseArrayWithContentsOfFile:](#sparsearraywithcontentsoffile)  
[- initWithContentsOfFile:](#initwithcontentsoffile)  
#### Declared In
DSSparseArray.h  



### writeToURL:atomically:  
Writes the contents of the sparse array to the location specified by a given URL.  
\- (BOOL) writeToURL: (NSURL \*) *aURL* atomically: (BOOL) *flag*  
#### Parameters
##### *aURL*
The location at which to write the sparse array.  
##### *flag*
If **YES**, the sparse array is written to an auxiliary location, and then the auxiliary location is renamed to *aURL*. If **NO**, the array is written directly to *aURL*. The **YES** option guarantees that *aURL*, if it exists at all, won’t be corrupted even if the system should crash during writing.  
#### Return Value
**YES** if the location is written successfully, otherwise **NO**.  
#### Discussion
If the sparse array’s contents are all property list objects (NSString, NSData, NSArray, or NSDictionary objects), the location written by this method can be used to initialize a new sparse array with the class method [sparseArrayWithContentsOfURL:](#sparsearraywithcontentsofurl) or the instance method [initWithContentsOfURL:](#initwithcontentsofurl).

For more information about property lists, see *[Property List Programming Guide][]*.  
#### Availability
Available in OS X v10.0 and later.  
#### See Also
[+ sparseArrayWithContentsOfURL:](#sparsearraywithcontentsofurl)  
[- initWithContentsOfURL:](#initwithcontentsofurl)  
#### Declared In
DSSparseArray.h  


[NSIndexSet]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSIndexSet_Class/Reference/Reference.html#//apple_ref/doc/c_ref/NSIndexSet
[NSIndexSet_firstIndex]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSIndexSet_Class/Reference/Reference.html#//apple_ref/occ/instm/NSIndexSet/firstIndex
[NSIndexSet_lastIndex]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSIndexSet_Class/Reference/Reference.html#//apple_ref/occ/instm/NSIndexSet/lastIndex
[NSUInteger]: https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Miscellaneous/Foundation_DataTypes/Reference/reference.html#//apple_ref/doc/c_ref/NSUInteger
[NSObject]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/Reference/Reference.html#//apple_ref/occ/cl/NSObject
[NSObject Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSObject_Protocol/Reference/NSObject.html#//apple_ref/occ/intf/NSObject
[NSCopying Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSCopying_Protocol/Reference/Reference.html#//apple_ref/occ/intf/NSCopying
[NSMutableCopying Protocol]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSMutableCopying_Protocol/Reference/Reference.html#//apple_ref/occ/intf/NSMutableCopying
[NSSecureCoding Protocol]: https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSSecureCoding_Protocol_Ref/content/NSSecureCoding.html#//apple_ref/occ/intf/NSSecureCoding
[NSEnumerator]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSEnumerator_Class/Reference/Reference.html#//apple_ref/doc/c_ref/NSEnumerator
[NSEnumerationOptions]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Constants/Reference/reference.html#//apple_ref/doc/c_ref/NSEnumerationOptions
[NSEnumerationReverse]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Constants/Reference/reference.html#//apple_ref/doc/c_ref/NSEnumerationReverse
[NSRangeException]: https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Miscellaneous/Foundation_Constants/Reference/reference.html#//apple_ref/c/data/NSRangeException
[copyWithZone:]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/Reference/Reference.html#//apple_ref/occ/clm/NSObject/copyWithZone:
[isEqual:]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Protocols/NSObject_Protocol/Reference/NSObject.html#//apple_ref/occ/intfm/NSObject/isEqual:
[Property List Programming Guide]: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/PropertyLists/Introduction/Introduction.html#//apple_ref/doc/uid/10000048i
[stringByExpandingTildeInPath]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/occ/instm/NSString/stringByExpandingTildeInPath
[DSSparseArrayEnumerator]: DSSparseArrayEnumerator.md
[DSSparseArray]: DSSparseArray.md
[DSMutableSparseArray]: DSMutableSparseArray.md

