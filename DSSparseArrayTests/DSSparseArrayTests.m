//
//  DSSparseArrayTests.m
//  DSSparseArrayTests
//
//  Created by David W. Stockton on 5/10/14.
//  Copyright (c) 2014 Syntonicity. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DSSparseArray.h"

@interface DSSparseArray (XCTestSuiteExtensions)
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@interface DSSparseArrayTests : XCTestCase

@end

@implementation DSSparseArrayTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void) test_DSSparseArray {
	DSSparseArray *sparseArray;
	DSSparseArray *sparseArray2;
	NSMutableIndexSet *mutableIndexes;
	NSIndexSet *indexes;
	NSArray *objects;
	
	sparseArray = [DSSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"An empty sparse array should have count of 0" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"An empty sparse array should return nil for any index" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"An empty sparse array should return nil for any index" );
	XCTAssertNil( [sparseArray objectAtIndex: 5], @"An empty sparse array should return nil for any index" );
	
	sparseArray = [DSSparseArray sparseArrayWithArray: @[@"hello sparse array", @"goodbye sparse array"]];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 3], @"Requesting the wrong index should return nil" );

	sparseArray = [DSSparseArray sparseArrayWithArray: @[@"hello sparse array", @"goodbye sparse array", @"hello again sparse array"]];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	
	sparseArray2 = [DSSparseArray sparseArrayWithSparseArray: sparseArray];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	sparseArray = nil;
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	
	sparseArray = [DSSparseArray sparseArrayWithObject: @"hello sparse array" atIndex: 3];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one object should have a count of 1" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	
	indexes = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange( 3, 2 )];
	objects = @[ @"hello sparse array", @"goodbye sparse array" ];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 4], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	//sparseArray = [DSSparseArray sparseArrayWithObjects: nil atIndexes: indexes];
	//sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: nil];
	
	objects = @[ @"three", @"five", @"nine", @"eleven", @"ninety-three", @"ten thousand twelve" ];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 3];
	[mutableIndexes addIndex: 5];
	[mutableIndexes addIndex: 9];
	[mutableIndexes addIndex: 11];
	[mutableIndexes addIndex: 93];
	[mutableIndexes addIndex: 10012];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 5], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 9], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 11], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 93], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 10012], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello sparse array", 3, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one object should have a count of 1" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );

	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes:
		         @"hello sparse array", 3,
		       @"goodbye sparse array", 5,
		          @"what sparse array", 9,
				nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three object should have a count of 3" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 5], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 9], @"This is the right index - it should return the string" );
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes:
		       @"hello sparse array", 3,
		       @"goodbye sparse array", 5,
		       @"hello sparse array", 9,
		       @"some other string", 97,
		       nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 5], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 9], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 97], @"This is the right index - it should return the string" );
	indexes = [sparseArray allIndexesForObject: @"hello sparse array"];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 2, @"There should be two indexes for a sparse array with two copies of the string" );
	XCTAssertTrue( [indexes firstIndex] == 3, @"The first index should be 3" );
	XCTAssertTrue( [indexes lastIndex] == 9, @"The last index should be 9 not %lu", [indexes lastIndex] );
}
- (void) test_DSSparseArray_indexOfObject {
	DSSparseArray *sparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;
	NSUInteger idx;
	id obj;
	
	obj = @"two";
	objects = @[ @"one", obj, @"three", @"four", @"five" ];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 34];
	[mutableIndexes addIndex: 57];
	[mutableIndexes addIndex: 274];
	[mutableIndexes addIndex: 764789];
	[mutableIndexes addIndex: 97835745];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	idx = [sparseArray indexOfObject: obj];
	XCTAssertTrue( idx == 57, @"The 'obj' was put at index 57 not %lu", idx );
	idx = [sparseArray indexOfObject: @"two"];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray indexOfObject: @"four"];
	XCTAssertTrue( idx == 764789, @"The 'four' was put at index 764789 not %lu", idx );
	idx = [sparseArray indexOfObject: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );

	sparseArray = [DSSparseArray sparseArrayWithArray: objects];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	idx = [sparseArray indexOfObject: obj];
	XCTAssertTrue( idx == 1, @"The 'obj' was put at index 1 not %lu", idx );
	idx = [sparseArray indexOfObject: @"two"];
	XCTAssertTrue( idx == 1, @"The 'two' was put at index 1 not %lu", idx );
	idx = [sparseArray indexOfObject: @"four"];
	XCTAssertTrue( idx == 3, @"The 'four' was put at index 3 not %lu", idx );
	idx = [sparseArray indexOfObject: nil];
	XCTAssertTrue( idx == 5, @"The firt empty slot is at index 5 not %lu", idx );
	idx = [sparseArray indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	
	//XCTFail( @"Just something to fail" );
}
- (void) test_DSSparseArray_indexOfObjectIdenticalTo {
	DSSparseArray *sparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;
	NSUInteger idx;
	id two, four;
	
	
	two = [NSString stringWithFormat: @"%@", @"two"];
	four = [NSString stringWithFormat: @"%@%@", @"fo", @"ur"];
	objects = @[ @"one", two, @"three", @"four", @"five" ];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 34];
	[mutableIndexes addIndex: 57];
	[mutableIndexes addIndex: 274];
	[mutableIndexes addIndex: 764789];
	[mutableIndexes addIndex: 97835745];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	idx = [sparseArray indexOfObjectIdenticalTo: two];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: @"two"];
	XCTAssertTrue( idx == NSNotFound, @"The literal 'two' was not put at index %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: four];
	XCTAssertTrue( idx == NSNotFound, @"The object 'four' was not put at index %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	
	sparseArray = [DSSparseArray sparseArrayWithArray: objects];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	idx = [sparseArray indexOfObjectIdenticalTo: two];
	XCTAssertTrue( idx == 1, @"The 'obj' was put at index 1 not %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: @"two"];
	XCTAssertTrue( idx == NSNotFound, @"The literal 'two' was not put at index %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: four];
	XCTAssertTrue( idx == NSNotFound, @"The object 'four' was not put at index %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: nil];
	XCTAssertTrue( idx == 5, @"The firt empty slot is at index 5 not %lu", idx );
	idx = [sparseArray indexOfObjectIdenticalTo: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	
	//XCTFail( @"Just something to fail" );
}
- (void) test_DSSparseArray_allIndexes {
	DSSparseArray *sparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSIndexSet *indexes;
	
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 456];
	[mutableIndexes addIndex: 876];
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 456, @"two", 876, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray.count );
	indexes = sparseArray.allIndexes;
	XCTAssertNotNil( indexes, @"allIndexes should not be nil" );
	XCTAssertTrue( [indexes isEqualToIndexSet: mutableIndexes], @"The index sets should match" );
	
	// Test it after clearing, removing, etc., things...
	
	//XCTFail( @"Testing of allIndexes needs to be completed" );
}
- (void) test_DSSparseArray_allIndexesForObject {
	DSSparseArray *sparseArray;
	NSIndexSet *indexes;

	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 456, @"two", 876, @"one", 986, @"two", 1029, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	NSIndexSet *indexesForOne = [sparseArray allIndexesForObject: @"one"];
	XCTAssertTrue( indexesForOne.count == 2, @"There should be two entries for object 'one' not %lu", (unsigned long) indexesForOne.count );
	NSIndexSet *indexesForTwo = [sparseArray allIndexesForObject: @"two"];
	XCTAssertTrue( indexesForTwo.count == 2, @"There should be two entries for object 'two' not %lu", (unsigned long) indexesForTwo.count );
	NSIndexSet *indexesForNoMatch = [sparseArray allIndexesForObject: @"three"];
	XCTAssertTrue( indexesForNoMatch.count == 0, @"There should be no entries for object 'three' not %lu", (unsigned long) indexesForNoMatch.count );
	XCTAssertNotNil( indexesForNoMatch, @"The index set should not be nil, just empty" );
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello sparse array", 3, @"goodbye sparse array", 5, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 5], @"This is the right index - it should return the string" );
	indexes = sparseArray.allIndexes;
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 2, @"There should be two indexes for a sparse array with two entries" );
	XCTAssertTrue( [indexes firstIndex] == 3, @"The first index should be 3" );
	XCTAssertTrue( [indexes lastIndex] == 5, @"The last index should be five" );
	indexes = [sparseArray allIndexesForObject: @"hello sparse array"];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 1, @"There should be one index for a sparse array with one copy of the string" );
	XCTAssertTrue( [indexes firstIndex] == 3, @"The first index should be 3" );
	XCTAssertTrue( [indexes lastIndex] == 3, @"The last index should also be 3" );
	indexes = [sparseArray allIndexesForObject: @"not in array"];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 0, @"There should be nothing in the index set since it did not match" );
	XCTAssertTrue( [indexes firstIndex] == NSNotFound, @"The first index should be NSNotFound" );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound, @"The last index should also be NSNotFound" );
	indexes = [sparseArray allIndexesForObject: @"goodbye sparse array"];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 1, @"There should be one index for a sparse array with one copy of the string" );
	XCTAssertTrue( [indexes firstIndex] == 5, @"The first index should be 5" );
	XCTAssertTrue( [indexes lastIndex] == 5, @"The last index should also be 5" );
	indexes = [sparseArray allIndexesForObject: nil];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == NSNotFound - 2, @"There are two entries in the array so the rest should be nil, this is %lu not %lu", (unsigned long) NSNotFound - 2, (unsigned long) indexes.count );
	XCTAssertTrue( [indexes firstIndex] == 0, @"The first index should be 0 not %lu", (unsigned long) [indexes lastIndex] );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound - 1, @"The last index should also be NSNotFound - 1 (%lu) not %lu", (unsigned long) NSNotFound - 1, (unsigned long) [indexes lastIndex] );

	// Put test if when the sparse array is empty
	sparseArray = [DSSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with zero objects should have a count of 0" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	indexes = sparseArray.allIndexes;
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 0, @"There should be no indexes for a sparse array with no entries" );
	XCTAssertTrue( [indexes firstIndex] == NSNotFound, @"The first index should be NSNotFound" );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound, @"The last index should also be NSNotFound" );
	indexes = [sparseArray allIndexesForObject: @"hello sparse array"];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == 0, @"There should be no indexes for a sparse array with no entries" );
	XCTAssertTrue( [indexes firstIndex] == NSNotFound, @"The first index should be NSNotFound" );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound, @"The last index should also be NSNotFound" );
	indexes = [sparseArray allIndexesForObject: nil];
	XCTAssertNotNil( indexes, @"The indexes should not be nil" );
	XCTAssertTrue( indexes.count == NSNotFound, @"There are no entries in the array so the rest should be nil, this is %lu not %lu", (unsigned long) NSNotFound, (unsigned long) indexes.count );
	XCTAssertTrue( [indexes firstIndex] == 0, @"The first index should be 0 not %lu", (unsigned long) [indexes lastIndex] );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound - 1, @"The last index should also be NSNotFound - 1 (%lu) not %lu", (unsigned long) NSNotFound - 1, (unsigned long) [indexes lastIndex] );
	
	//XCTFail( @"Testing of allIndexesForObject needs to be completed" );
}
- (void) test_DSSparseArray_allValues {
	DSSparseArray *sparseArray;
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 456, @"two", 876, @"one", 986, @"two", 1029, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	NSArray *allValues = [sparseArray allValues];
	XCTAssertNotNil( allValues, @"All values should not be nil" );
	XCTAssertTrue( allValues.count == 4, @"All values should have four entries not %lu", (unsigned long) allValues.count );
	XCTAssertTrue( [allValues[0] isEqualToString: @"one"], @"The first entry should be 'one' not '%@'", allValues[0] );
	XCTAssertTrue( [allValues[1] isEqualToString: @"two"], @"The second entry should be 'two' not '%@'", allValues[1] );
	XCTAssertTrue( [allValues[2] isEqualToString: @"one"], @"The third entry should be 'one' not '%@'", allValues[2] );
	XCTAssertTrue( [allValues[3] isEqualToString: @"two"], @"The fourth entry should be 'tow' not '%@'", allValues[3] );
	
	// Put test if when the sparse array is empty

	//XCTFail( @"Testing of allIndexes needs to be completed" );
}
- (void) test_DSSparseArray_getObjectsAndIndexes {
	// From Stackoverfow http://stackoverflow.com/questions/2894093/example-of-nsdictionary-getobjectsandkeys
	//NSDictionary *myDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"A", @"2", @"B", nil];
	//
	//NSInteger count = [myDictionary count];
	//id __unsafe_unretained objects[count];
	//id __unsafe_unretained keys[count];
	//[myDictionary getObjects: objects andKeys: keys];
	//
	//for (int i = 0; i < count; i++) {
	//	id obj = objects[i];
	//	id key = keys[i];
	//	NSLog(@"%@ -> %@", obj, key);
	//}

	DSSparseArray *sparseArray;
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 456, @"one", 986, @"two", 876, @"two", 1029, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"The sparse array count should be 4 not %lu", (unsigned long) sparseArray.count );
	NSUInteger count = sparseArray.count;
	id __unsafe_unretained objects[count];
	NSUInteger indexes[count];
	[sparseArray getObjects: objects andIndexes: indexes];
	XCTAssertTrue( [objects[0] isEqualToString: @"one"], @"The first object should be 'one' not '%@'", objects[0] );
	XCTAssertTrue( [objects[1] isEqualToString: @"two"], @"The first object should be 'two' not '%@'", objects[1] );
	XCTAssertTrue( [objects[2] isEqualToString: @"one"], @"The first object should be 'one' not '%@'", objects[2] );
	XCTAssertTrue( [objects[3] isEqualToString: @"two"], @"The first object should be 'two' not '%@'", objects[3] );
	XCTAssertTrue( indexes[0] == 456, @"The first index should be 456 not %lu", (unsigned long) indexes[0] );
	XCTAssertTrue( indexes[1] == 876, @"The first index should be 876 not %lu", (unsigned long) indexes[1] );
	XCTAssertTrue( indexes[2] == 986, @"The first index should be 986 not %lu", (unsigned long) indexes[2] );
	XCTAssertTrue( indexes[3] == 1029, @"The first index should be 1029 not %lu", (unsigned long) indexes[3] );

	// Put test if when the sparse array is empty
	sparseArray = [DSSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array count should be 0 not %lu", (unsigned long) sparseArray.count );
	for( int i = 0; i < count; ++i ) {
		objects[i] = nil;
		indexes[i] = NSNotFound;
	}
	[sparseArray getObjects: objects andIndexes: indexes];
	for( int i = 0; i < count; ++i ) {
		XCTAssertNil( objects[i], @"Empty sparse array object %d should be nil not %@", i, objects[i] );
		XCTAssertTrue( indexes[i] == NSNotFound, @"%d should be NSNptFound", i );
	}
	
//	XCTFail( @"Testing of getObjectsAndIndexes needs to be completed" );
}
- (void) test_DSSparseArray_isEqualToSparseArray {
	DSSparseArray *sparseArray1;
	DSSparseArray *sparseArray2;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;
	NSUInteger idx;
	id obj;
	
	obj = @"two";
	objects = @[ @"one", obj, @"three", @"four", @"five" ];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 34];
	[mutableIndexes addIndex: 57];
	[mutableIndexes addIndex: 274];
	[mutableIndexes addIndex: 764789];
	[mutableIndexes addIndex: 97835745];
	sparseArray1 = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray1, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray1.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray1.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray1.count );
	idx = [sparseArray1 indexOfObject: obj];
	XCTAssertTrue( idx == 57, @"The 'obj' was put at index 57 not %lu", idx );
	idx = [sparseArray1 indexOfObject: @"two"];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray1 indexOfObject: @"four"];
	XCTAssertTrue( idx == 764789, @"The 'four' was put at index 764789 not %lu", idx );
	idx = [sparseArray1 indexOfObject: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray1 indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	
	sparseArray2 = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.count );
	idx = [sparseArray2 indexOfObject: obj];
	XCTAssertTrue( idx == 57, @"The 'obj' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"two"];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"four"];
	XCTAssertTrue( idx == 764789, @"The 'four' was put at index 764789 not %lu", idx );
	idx = [sparseArray2 indexOfObject: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	// Need to figure out what to do about isEqual: --- do I need to add it or can I get super to work?
	XCTAssertFalse( [sparseArray1 isEqual: nil], @"The sparse arrays should not be equal" );
	XCTAssertFalse( [sparseArray1 isEqual: @"hello sparse array"], @"The sparse arrays should not be equal" );
	XCTAssertFalse( [sparseArray1 isEqual: [NSNumber numberWithInt: 3]], @"The sparse arrays should not be equal" );
	XCTAssertTrue( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays should be equal" );
	XCTAssertTrue( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays should be equal" );
	XCTAssertTrue( [sparseArray1 hash] == [sparseArray2 hash], @"If the arrays are equal, the hash values need to be too" );
	
	NSMutableArray *objects2 = [objects mutableCopy];
	[objects2 removeLastObject];
	NSMutableIndexSet *indexSet2 = [mutableIndexes mutableCopy];
	[indexSet2 removeIndex: 274];
	sparseArray2 = [DSSparseArray sparseArrayWithObjects: objects2 atIndexes: indexSet2];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray2.count );
	idx = [sparseArray2 indexOfObject: obj];
	XCTAssertTrue( idx == 57, @"The 'obj' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"two"];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"four"];
	XCTAssertTrue( idx == 97835745, @"The 'four' was put at index 97835745 not %lu", idx );
	idx = [sparseArray2 indexOfObject: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	// Need to figure out what to do about isEqual: --- do I need to add it or can I get super to work?
	XCTAssertFalse( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays should not be equal" );
	XCTAssertFalse( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays should be equal" );
	XCTAssertTrue( [sparseArray1 hash] != [sparseArray2 hash], @"If the arrays are equal, the hash values need to be too" );
	//NSLog( @"--------------------------------------------------------------------------------" );
	//NSLog( @"The hash for sparseArray1 is %lu", (unsigned long) [sparseArray1 hash] );
	//NSLog( @"The hash for sparseArray2 is %lu", (unsigned long) [sparseArray2 hash] );
	//NSLog( @"--------------------------------------------------------------------------------" );

	sparseArray2 = [sparseArray1 copy];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.count );
	idx = [sparseArray2 indexOfObject: obj];
	XCTAssertTrue( idx == 57, @"The 'obj' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"two"];
	XCTAssertTrue( idx == 57, @"The 'two' was put at index 57 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"four"];
	XCTAssertTrue( idx == 764789, @"The 'four' was put at index 764789 not %lu", idx );
	idx = [sparseArray2 indexOfObject: nil];
	XCTAssertTrue( idx == 0, @"The firt empty slot is at index 0 not %lu", idx );
	idx = [sparseArray2 indexOfObject: @"hello sparse array"];
	XCTAssertTrue( idx == NSNotFound, @"The 'hello sparse array' is not in the array and not at %lu", idx );
	// Need to figure out what to do about isEqual: --- do I need to add it or can I get super to work?
	XCTAssertTrue( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays should be equal" );
	XCTAssertTrue( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays should be equal" );
	XCTAssertTrue( [sparseArray1 hash] == [sparseArray2 hash], @"If the arrays are equal, the hash values need to be too" );
	//NSLog( @"--------------------------------------------------------------------------------" );
	//NSLog( @"The hash for sparseArray1 is %lu", (unsigned long) [sparseArray1 hash] );
	//NSLog( @"The hash for sparseArray2 is %lu", (unsigned long) [sparseArray2 hash] );
	//NSLog( @"--------------------------------------------------------------------------------" );

	//XCTFail( @"Testing of isEqualToSparseArray needs to be completed" );
}
//- (DSSparseArray *) filteredSparseArrayUsingPredicate: (NSPredicate *) predicate;
- (void) test_DSSparseArray_filteredSparseArrayUsingPredicate {
	DSSparseArray *sparseArray;
	DSSparseArray *derivedSparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;

	objects = [NSArray arrayWithObjects: @"one", @"two", @"three", @"four", @"five", nil];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 3];
	[mutableIndexes addIndex: 6];
	[mutableIndexes addIndex: 9];
	[mutableIndexes addIndex: 15];
	[mutableIndexes addIndex: 19];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( sparseArray.allIndexes.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.allIndexes.count );
	XCTAssertTrue( [@"one" isEqualToString: [sparseArray objectAtIndex: 3]], @"The 3rd entry should be 'one' not '%@'", [sparseArray objectAtIndex: 3] );
	XCTAssertTrue( [@"two" isEqualToString: [sparseArray objectAtIndex: 6]], @"The 6th entry should be 'two' not '%@'", [sparseArray objectAtIndex: 6] );
	XCTAssertTrue( [@"three" isEqualToString: [sparseArray objectAtIndex: 9]], @"The 9th entry should be 'three' not '%@'", [sparseArray objectAtIndex: 9] );
	XCTAssertTrue( [@"four" isEqualToString: [sparseArray objectAtIndex: 15]], @"The 15th entry should be 'four' not '%@'", [sparseArray objectAtIndex: 15] );
	XCTAssertTrue( [@"five" isEqualToString: [sparseArray objectAtIndex: 19]], @"The 19th entry should be 'five' not '%@'", [sparseArray objectAtIndex: 19] );
	derivedSparseArray = [sparseArray filteredSparseArrayUsingPredicate: [NSPredicate predicateWithFormat: @"length = 3"]];
	XCTAssertNotNil( derivedSparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( derivedSparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( derivedSparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", derivedSparseArray.count );
	XCTAssertTrue( derivedSparseArray.allIndexes.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", derivedSparseArray.allIndexes.count );
	XCTAssertTrue( [@"one" isEqualToString: [derivedSparseArray objectAtIndex: 3]], @"The 3rd entry should be 'one' not '%@'", [derivedSparseArray objectAtIndex: 3] );
	XCTAssertTrue( [@"two" isEqualToString: [derivedSparseArray objectAtIndex: 6]], @"The 6th entry should be 'two' not '%@'", [derivedSparseArray objectAtIndex: 6] );
	//XCTAssertTrue( [@"three" isEqualToString: [derivedSparseArray objectAtIndex: 9]], @"The 9th entry should be 'three' not '%@'", [derivedSparseArray objectAtIndex: 9] );
	//XCTAssertTrue( [@"four" isEqualToString: [derivedSparseArray objectAtIndex: 15]], @"The 15th entry should be 'four' not '%@'", [derivedSparseArray objectAtIndex: 15] );
	//XCTAssertTrue( [@"five" isEqualToString: [derivedSparseArray objectAtIndex: 19]], @"The 19th entry should be 'five' not '%@'", [derivedSparseArray objectAtIndex: 19] );
	derivedSparseArray = [sparseArray filteredSparseArrayUsingPredicate: [NSPredicate predicateWithFormat: @"length = 4"]];
	XCTAssertNotNil( derivedSparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( derivedSparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( derivedSparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", derivedSparseArray.count );
	XCTAssertTrue( derivedSparseArray.allIndexes.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", derivedSparseArray.allIndexes.count );
	//XCTAssertTrue( [@"one" isEqualToString: [derivedSparseArray objectAtIndex: 3]], @"The 3rd entry should be 'one' not '%@'", [derivedSparseArray objectAtIndex: 3] );
	//XCTAssertTrue( [@"two" isEqualToString: [derivedSparseArray objectAtIndex: 6]], @"The 6th entry should be 'two' not '%@'", [derivedSparseArray objectAtIndex: 6] );
	//XCTAssertTrue( [@"three" isEqualToString: [derivedSparseArray objectAtIndex: 9]], @"The 9th entry should be 'three' not '%@'", [derivedSparseArray objectAtIndex: 9] );
	XCTAssertTrue( [@"four" isEqualToString: [derivedSparseArray objectAtIndex: 15]], @"The 15th entry should be 'four' not '%@'", [derivedSparseArray objectAtIndex: 15] );
	XCTAssertTrue( [@"five" isEqualToString: [derivedSparseArray objectAtIndex: 19]], @"The 19th entry should be 'five' not '%@'", [derivedSparseArray objectAtIndex: 19] );
	derivedSparseArray = [sparseArray filteredSparseArrayUsingPredicate: nil];
	XCTAssertNotNil( derivedSparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( derivedSparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( derivedSparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", derivedSparseArray.count );
	XCTAssertTrue( derivedSparseArray.allIndexes.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", derivedSparseArray.allIndexes.count );
}
- (void) test_DSSparseArray_objectEnumerator {
	DSSparseArray *sparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;
	id obj;
	
	objects = [NSArray arrayWithObjects: @"one", @"two", @"three", @"four", @"five", nil];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 3];
	[mutableIndexes addIndex: 6];
	[mutableIndexes addIndex: 9];
	[mutableIndexes addIndex: 15];
	[mutableIndexes addIndex: 19];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 3] class]) );
	XCTAssertTrue( [@"one" isEqualToString: [sparseArray objectAtIndex: 3]], @"The 3rd entry should be 'one' not '%@'", [sparseArray objectAtIndex: 3] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 6], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 6] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 6] class]) );
	XCTAssertTrue( [@"two" isEqualToString: [sparseArray objectAtIndex: 6]], @"The 6th entry should be 'two' not '%@'", [sparseArray objectAtIndex: 6] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 9], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 9] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 9] class]) );
	XCTAssertTrue( [@"three" isEqualToString: [sparseArray objectAtIndex: 9]], @"The 9th entry should be 'three' not '%@'", [sparseArray objectAtIndex: 9] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 15], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 15] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 15] class]) );
	XCTAssertTrue( [@"four" isEqualToString: [sparseArray objectAtIndex: 15]], @"The 15th entry should be 'four' not '%@'", [sparseArray objectAtIndex: 15] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 19], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 19] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 19] class]) );
	XCTAssertTrue( [@"five" isEqualToString: [sparseArray objectAtIndex: 19]], @"The 19th entry should be 'five' not '%@'", [sparseArray objectAtIndex: 19] );
	
	NSEnumerator *sae = [sparseArray objectEnumerator];
	XCTAssertNotNil( sae, @"The object enumerator should not be nil" );
	obj = sae.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"one" isEqualToString: obj], @"The entry should be 'one' not '%@'", obj );
	
	obj = sae.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"two" isEqualToString: obj], @"The entry should be 'two' not '%@'", obj );
	
	obj = sae.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"three" isEqualToString: obj], @"The entry should be 'three' not '%@'", obj );
	
	obj = sae.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"four" isEqualToString: obj], @"The entry should be 'four' not '%@'", obj );
	
	obj = sae.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"five" isEqualToString: obj], @"The entry should be 'five' not '%@'", obj );
	
	obj = sae.nextObject;
	XCTAssertNil( obj, @"We've reached the end" );
	obj = sae.nextObject;
	XCTAssertNil( obj, @"Still at the end" );
	
	// Test the code from the documentation...
	{
		DSSparseArray *mySparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello", 2, @"good", 4, @"looking", 6, nil];
		NSEnumerator *enumerator = [mySparseArray objectEnumerator];
		id anObject;
		int count = 0;
	
		while( (anObject = [enumerator nextObject]) ) {
			/* code to act on each element as it is returned */
			XCTAssertTrue( [anObject isKindOfClass: [NSString class]], @"All the entries should be strings no %@", NSStringFromClass([anObject class]) );
			XCTAssertTrue( (count == 0 && [anObject isEqual: @"hello"]) ||
				       (count == 1 && [anObject isEqual: @"good"]) ||
				       (count == 2 && [anObject isEqual: @"looking"]), @"The object should be 'hello', 'good', 'looking' for count %d not '%@'", count, anObject );
			++count;
		}
		XCTAssertTrue( count == 3, @"There should be three entries in the sparse array not %d", count );
	}
	
	// Test second code example from the documentation...
	{
		DSSparseArray *mySparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello", 2, @"good", 4, @"looking", 6, nil];
		DSSparseArrayEnumerator *enumerator = [mySparseArray objectEnumerator];
		NSUInteger idx;
		id anObject;
		int count = 0;

		while( (idx = [enumerator indexOfNextObject]) != NSNotFound ) {
			anObject = [enumerator nextObject];
			//NSLog( @"%lu: %@", (unsigned long) idx, anObject );
			XCTAssertTrue( [anObject isKindOfClass: [NSString class]], @"All the entries should be strings no %@", NSStringFromClass([anObject class]) );
			XCTAssertTrue( (count == 0 && [anObject isEqual: @"hello"]) ||
				       (count == 1 && [anObject isEqual: @"good"]) ||
				       (count == 2 && [anObject isEqual: @"looking"]), @"The object should be 'hello', 'good', 'looking' for count %d not '%@'", count, anObject );
			XCTAssertTrue( (count == 0 && idx == 2) || (count == 1 && idx == 4) || (count == 2 && idx == 6), @"The index should be 2, 4, or 6 not %lu", (unsigned long) idx );
			++count;
		}
		XCTAssertTrue( count == 3, @"There should be three entries in the sparse array not %d", count );
	}
	
}
- (void) test_DSSparseArray_reverseObjectEnumerator {
	DSSparseArray *sparseArray;
	NSMutableIndexSet *mutableIndexes;
	NSArray *objects;
	id obj;
	
	objects = [NSArray arrayWithObjects: @"one", @"two", @"three", @"four", @"five", nil];
	mutableIndexes = [NSMutableIndexSet indexSet];
	[mutableIndexes addIndex: 3];
	[mutableIndexes addIndex: 6];
	[mutableIndexes addIndex: 9];
	[mutableIndexes addIndex: 15];
	[mutableIndexes addIndex: 19];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: mutableIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 3] class]) );
	XCTAssertTrue( [@"one" isEqualToString: [sparseArray objectAtIndex: 3]], @"The 3rd entry should be 'one' not '%@'", [sparseArray objectAtIndex: 3] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 6], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 6] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 6] class]) );
	XCTAssertTrue( [@"two" isEqualToString: [sparseArray objectAtIndex: 6]], @"The 6th entry should be 'two' not '%@'", [sparseArray objectAtIndex: 6] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 9], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 9] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 9] class]) );
	XCTAssertTrue( [@"three" isEqualToString: [sparseArray objectAtIndex: 9]], @"The 9th entry should be 'three' not '%@'", [sparseArray objectAtIndex: 9] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 15], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 15] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 15] class]) );
	XCTAssertTrue( [@"four" isEqualToString: [sparseArray objectAtIndex: 15]], @"The 15th entry should be 'four' not '%@'", [sparseArray objectAtIndex: 15] );
	XCTAssertNotNil( [sparseArray objectAtIndex: 19], @"This is the right index - it should return the string" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 19] isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([[sparseArray objectAtIndex: 19] class]) );
	XCTAssertTrue( [@"five" isEqualToString: [sparseArray objectAtIndex: 19]], @"The 19th entry should be 'five' not '%@'", [sparseArray objectAtIndex: 19] );
	
	NSEnumerator *sare = [sparseArray reverseObjectEnumerator];
	XCTAssertNotNil( sare, @"The object enumerator should not be nil" );
	obj = sare.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"five" isEqualToString: obj], @"The entry should be 'five' not '%@'", obj );
	
	obj = sare.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"four" isEqualToString: obj], @"The entry should be 'four' not '%@'", obj );
	
	obj = sare.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"three" isEqualToString: obj], @"The entry should be 'three' not '%@'", obj );
	
	obj = sare.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"two" isEqualToString: obj], @"The entry should be 'two' not '%@'", obj );
	
	obj = sare.nextObject;
	XCTAssertNotNil( obj, @"The object should not be nil" );
	XCTAssertTrue( [obj isKindOfClass: [NSString class]], @"It should be a string not a '%@'", NSStringFromClass([obj class]) );
	XCTAssertTrue( [@"one" isEqualToString: obj], @"The entry should be 'one' not '%@'", obj );
	
	obj = sare.nextObject;
	XCTAssertNil( obj, @"We've reached the beginning" );
	obj = sare.nextObject;
	XCTAssertNil( obj, @"Still at the beginning" );
	
	// Test the code from the documentation...
	{
		DSSparseArray *mySparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello", 2, @"good", 4, @"looking", 6, nil];
		NSEnumerator *enumerator = [mySparseArray reverseObjectEnumerator];
		id anObject;
		int count = 0;
		
		while( (anObject = [enumerator nextObject]) ) {
			/* code to act on each element as it is returned */
			XCTAssertTrue( [anObject isKindOfClass: [NSString class]], @"All the entries should be strings no %@", NSStringFromClass([anObject class]) );
			XCTAssertTrue( (count == 2 && [anObject isEqual: @"hello"]) ||
				       (count == 1 && [anObject isEqual: @"good"]) ||
				       (count == 0 && [anObject isEqual: @"looking"]), @"The object should be 'hello', 'good', 'looking' for count %d not '%@'", count, anObject );
			++count;
		}
		XCTAssertTrue( count == 3, @"There should be three entries in the sparse array not %d", count );
	}
	
	// Test second code example from the documentation...
	{
		DSSparseArray *mySparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello", 2, @"good", 4, @"looking", 6, nil];
		DSSparseArrayEnumerator *enumerator = [mySparseArray reverseObjectEnumerator];
		NSUInteger idx;
		id anObject;
		int count = 0;
		
		while( (idx = [enumerator indexOfNextObject]) != NSNotFound ) {
			anObject = [enumerator nextObject];
			//NSLog( @"%lu: %@", (unsigned long) idx, anObject );
			XCTAssertTrue( [anObject isKindOfClass: [NSString class]], @"All the entries should be strings no %@", NSStringFromClass([anObject class]) );
			XCTAssertTrue( (count == 2 && [anObject isEqual: @"hello"]) ||
				       (count == 1 && [anObject isEqual: @"good"]) ||
				       (count == 0 && [anObject isEqual: @"looking"]), @"The object should be 'hello', 'good', 'looking' for count %d not '%@'", count, anObject );
			XCTAssertTrue( (count == 2 && idx == 2) || (count == 1 && idx == 4) || (count == 0 && idx == 6), @"The index should be 2, 4, or 6 not %lu", (unsigned long) idx );
			++count;
		}
		XCTAssertTrue( count == 3, @"There should be three entries in the sparse array not %d", count );
	}
}

- (void) test_DSSparseArray_enumerateIndexesAndObjectsUsingBlock {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];

	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	//NSLog( @"The array to build the sparse array is: %@", [objects description] );
	//NSLog( @"The dictionary is: %@", sparseArray.dictionary );
	//NSLog( @"The sparse array is: %@", sparseArray );
	//NSLog( @"Running enumerateIndexesAndObjectsUsingBlock:" );
	[sparseArray enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"o Entry %lu: '%@'", (unsigned long) idx, obj );
		switch( idx ) {
			case 300:
				XCTAssertTrue( [obj isEqualToString: @"one"], @"Should be one" );
				break;
			case 301:
				XCTAssertTrue( [obj isEqualToString: @"two"], @"Should be two" );
				break;
			case 302:
				XCTAssertTrue( [obj isEqualToString: @"three"], @"Should be three" );
				break;
			case 303:
				XCTAssertTrue( [obj isEqualToString: @"four"], @"Should be four" );
				break;
			case 304:
				XCTAssertTrue( [obj isEqualToString: @"five"], @"Should be five" );
				break;
			case 305:
				XCTAssertTrue( [obj isEqualToString: @"six"], @"Should be six" );
				break;
			default:
				XCTFail( @"unexpected index (%lu) for object '%@'", idx, obj );
				break;
		}
	}];
	//NSLog( @"Running enumerateIndexesAndObjectsUsingBlock and stopping midway:" );
	[sparseArray enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"o Entry %lu: '%@'", (unsigned long) idx, obj );
		switch( idx ) {
			case 300:
				XCTAssertTrue( [obj isEqualToString: @"one"], @"Should be one" );
				break;
			case 301:
				XCTAssertTrue( [obj isEqualToString: @"two"], @"Should be two" );
				break;
			case 302:
				XCTAssertTrue( [obj isEqualToString: @"three"], @"Should be three" );
				break;
			case 303:
				XCTAssertTrue( [obj isEqualToString: @"four"], @"Should be four" );
				*stop = YES;
				break;
			case 304:
				XCTAssertTrue( [obj isEqualToString: @"five"], @"Should be five" );
				break;
			case 305:
				XCTAssertTrue( [obj isEqualToString: @"six"], @"Should be six" );
				break;
			default:
				XCTFail( @"unexpected index (%lu) for object '%@'", idx, obj );
				break;
		}
	}];
	//NSLog( @"Running enumerateIndexesAndObjectsUsingBlockWithOptions:" );
	[sparseArray enumerateIndexesAndObjectsWithOptions: NSEnumerationReverse usingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"o Entry %lu: '%@'", (unsigned long) idx, obj );
		switch( idx ) {
			case 300:
				XCTAssertTrue( [obj isEqualToString: @"one"], @"Should be one" );
				break;
			case 301:
				XCTAssertTrue( [obj isEqualToString: @"two"], @"Should be two" );
				break;
			case 302:
				XCTAssertTrue( [obj isEqualToString: @"three"], @"Should be three" );
				break;
			case 303:
				XCTAssertTrue( [obj isEqualToString: @"four"], @"Should be four" );
				break;
			case 304:
				XCTAssertTrue( [obj isEqualToString: @"five"], @"Should be five" );
				break;
			case 305:
				XCTAssertTrue( [obj isEqualToString: @"six"], @"Should be six" );
				break;
			default:
				XCTFail( @"unexpected index (%lu) for object '%@'", idx, obj );
				break;
		}
	}];
	//NSLog( @"Running enumerateIndexesAndObjectsUsingBlockWithOptions with stop midway:" );
	[sparseArray enumerateIndexesAndObjectsWithOptions: NSEnumerationReverse usingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"o Entry %lu: '%@'", (unsigned long) idx, obj );
		switch( idx ) {
			case 300:
				XCTAssertTrue( [obj isEqualToString: @"one"], @"Should be one" );
				break;
			case 301:
				XCTAssertTrue( [obj isEqualToString: @"two"], @"Should be two" );
				break;
			case 302:
				XCTAssertTrue( [obj isEqualToString: @"three"], @"Should be three" );
				break;
			case 303:
				XCTAssertTrue( [obj isEqualToString: @"four"], @"Should be four" );
				*stop = YES;
				break;
			case 304:
				XCTAssertTrue( [obj isEqualToString: @"five"], @"Should be five" );
				break;
			case 305:
				XCTAssertTrue( [obj isEqualToString: @"six"], @"Should be six" );
				break;
			default:
				XCTFail( @"unexpected index (%lu) for object '%@'", idx, obj );
				break;
		}
	}];
	
	NSMutableIndexSet *highIndexes = [NSMutableIndexSet indexSet];
	[highIndexes addIndex: NSNotFound - 1];
	[highIndexes addIndex: NSNotFound - 2];
	[highIndexes addIndex: NSNotFound - 3];
	[highIndexes addIndex: NSNotFound - 4];
	[highIndexes addIndex: NSNotFound - 5];
	[highIndexes addIndex: NSNotFound - 6];
	//NSLog( @"The index set is %@", highIndexes );
	//[highIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
	//	NSLog( @"-- %lu", idx );
	//}];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: highIndexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 2] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 1] isEqualToString: @"six"], @"Should be six" );
	//NSLog( @"The array to build the sparse array is: %@", [objects description] );
	//NSLog( @"The dictionary is: %@", sparseArray.dictionary );
	//NSLog( @"The sparse array is: %@", sparseArray );
	//NSLog( @"Running enumerateIndexesAndObjectsUsingBlock:" );
	[sparseArray enumerateIndexesAndObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL *stop ) {
		//NSLog( @"o Entry %lu: '%@'", (unsigned long) idx, obj );
		switch( idx ) {
			case NSNotFound - 6:
				XCTAssertTrue( [obj isEqualToString: @"one"], @"Should be one" );
				break;
			case NSNotFound - 5:
				XCTAssertTrue( [obj isEqualToString: @"two"], @"Should be two" );
				break;
			case NSNotFound - 4:
				XCTAssertTrue( [obj isEqualToString: @"three"], @"Should be three" );
				break;
			case NSNotFound - 3:
				XCTAssertTrue( [obj isEqualToString: @"four"], @"Should be four" );
				break;
			case NSNotFound - 2:
				XCTAssertTrue( [obj isEqualToString: @"five"], @"Should be five" );
				break;
			case NSNotFound - 1:
				XCTAssertTrue( [obj isEqualToString: @"six"], @"Should be six" );
				break;
			default:
				XCTFail( @"unexpected index (%lu) for object '%@'", idx, obj );
				break;
		}
	}];
}
- (void) test_DSSparseArray_indexesOfEntriesPassingTest {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	//NSLog( @"Running indexesOfEntriesPassingTest:" );
	NSIndexSet *selectedIndexes = [sparseArray indexesOfEntriesPassingTest: ^BOOL( NSUInteger idx, id obj, BOOL *stop ) {
		if( idx & 0x01 )
			return YES;
		return NO;
	}];
	//NSLog( @"The selected odd index set is %@", selectedIndexes );
	XCTAssertTrue( selectedIndexes.count == 3, @"There should be 3 odd entries not %lu", selectedIndexes.count );
	XCTAssertTrue( [selectedIndexes containsIndex: 301], @"It should contain 301" );
	XCTAssertTrue( [selectedIndexes containsIndex: 303], @"It should contain 303" );
	XCTAssertTrue( [selectedIndexes containsIndex: 305], @"It should contain 305" );
	//NSLog( @"Running indexesOfEntriesPassingTest:" );
	selectedIndexes = [sparseArray indexesOfEntriesPassingTest: ^BOOL( NSUInteger idx, id obj, BOOL *stop ) {
		NSString *objAsString = obj;
		if( [objAsString rangeOfString: @"o"].location != NSNotFound )
			return YES;
		return NO;
	}];
	//NSLog( @"The selected index set of entries with an 'o' in the string is %@", selectedIndexes );
	XCTAssertTrue( selectedIndexes.count == 3, @"There should be 3 odd entries not %lu", selectedIndexes.count );
	XCTAssertTrue( [selectedIndexes containsIndex: 300], @"It should contain 300" );
	XCTAssertTrue( [selectedIndexes containsIndex: 301], @"It should contain 301" );
	XCTAssertTrue( [selectedIndexes containsIndex: 303], @"It should contain 303" );
}
- (void) test_DSSparsArray_sparseArrayWithObjectsAndIndexes {
	DSSparseArray *sparseArray;
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 0, @"The first object was nill, empty object is right" );
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 0, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 1, @"The first object was one, count should be 1 not %lu", (unsigned long) sparseArray.count );
	// This is missing the index, so the nil will be zero, then off into the stack...
	//sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", nil];
	//XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	
	//NSLog( @"---------------------------------------------------------------" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 4, @"two", NSNotFound+2, @"three", 9, nil];
	NSLog( @"The sparse array is %@", sparseArray );
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndNSUIntegerIndexes: @"one", 4, @"two", NSNotFound + 5, @"three", 9, nil];
	NSLog( @"The sparse array is %@", sparseArray );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	//NSLog( @"---------------------------------------------------------------" );
}
- (void) test_DSSparsArray_copy {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray1;
	DSSparseArray *sparseArray2;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray1 = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray1, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray1.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray1.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray1.count );
	XCTAssertTrue( [sparseArray1.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray1.allIndexes count] );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	sparseArray2 = [sparseArray1 copy];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray2.count );
	XCTAssertTrue( [sparseArray2.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray2.allIndexes count] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
}
- (void) test_DSSparseArray_mutableCopy {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray1;
	DSMutableSparseArray *sparseArray2;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];

	sparseArray1 = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray1, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray1.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray1.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray1.count );
	XCTAssertTrue( [sparseArray1.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray1.allIndexes count] );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray1 objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	sparseArray2 = [sparseArray1 mutableCopy];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray2.count );
	XCTAssertTrue( [sparseArray2.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray2.allIndexes count] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
}
- (void) test_DSMutableSparseArray_setObjectAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	[sparseArray setObject: @"one" atIndex: 3];
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one object should have a count of 1 not %lu", sparseArray.count );
	[sparseArray setObject: @"two" atIndex: 13];
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray.count );
	[sparseArray setObject: @"three" atIndex: 53];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	[sparseArray setObject: @"four" atIndex: 2];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	[sparseArray setObject: nil atIndex: 29];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	[sparseArray setObject: nil atIndex: 13];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
}

- (void) test_DSMutableSparseArray_setObjectsAtIndexes {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	
	[sparseArray setObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray setObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );

}
- (void) test_DSMutableSparseArray_setSparseArray {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray1;
	DSMutableSparseArray *sparseArray2;
	
	sparseArray1 = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 23, @"two", 54, @"three", 93, nil];
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 95, @"twelve", 983, nil];
	XCTAssertFalse( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray2 isEqual: sparseArray1], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray2 isEqualToSparseArray: sparseArray1], @"The sparse arrays are not equal so this should be false" );
	[sparseArray2 setSparseArray: sparseArray1];
	XCTAssertTrue( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays are equal so this should be true" );
	XCTAssertTrue( [sparseArray2 isEqual: sparseArray1], @"The sparse arrays are equal so this should be true" );
	XCTAssertTrue( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays are equal so this should be true" );
	XCTAssertTrue( [sparseArray2 isEqualToSparseArray: sparseArray1], @"The sparse arrays are equal so this should be true" );
	[sparseArray2 setSparseArray: nil];
	XCTAssertNotNil( sparseArray2, @"Setting its sparse array to nil should not make it nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"Setting its sparse array to nil should not make the indexes nil" );
	XCTAssertTrue( sparseArray2.count == 0 , @"It should have a count of zero not %lu", (unsigned long) sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 0, @"It's indexes count should be zero not %lu", (unsigned long) sparseArray2.allIndexes.count );
	XCTAssertFalse( [sparseArray1 isEqual: sparseArray2], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray2 isEqual: sparseArray1], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray1 isEqualToSparseArray: sparseArray2], @"The sparse arrays are not equal so this should be false" );
	XCTAssertFalse( [sparseArray2 isEqualToSparseArray: sparseArray1], @"The sparse arrays are not equal so this should be false" );
	[sparseArray2 setObject: @"Hey!" atIndex: 481];
	XCTAssertNotNil( sparseArray2, @"Setting one of its entries should not make it nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"Setting its sparse array to nil should not make the indexes nil" );
	XCTAssertTrue( sparseArray2.count == 1 , @"It should have a count of one not %lu", (unsigned long) sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 1, @"It's indexes count should be one not %lu", (unsigned long) sparseArray2.allIndexes.count );
	
}
- (void) test_DSMutableSparseArray_setEntriesFromSparseArray {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray1;
	DSMutableSparseArray *sparseArray2;
	
	sparseArray1 = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"one", 23, @"two", 54, @"three", 93, nil];
	XCTAssertNotNil( sparseArray1, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray1.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray1.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray1.count );
	XCTAssertTrue( sparseArray1.allIndexes.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray1.allIndexes.count );
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 15, @"twelve", 983, nil];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 2, @"A sparse array with two objects should have a count of 3 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 2, @"A sparse array with two objects should have a count of 3 not %lu", sparseArray2.allIndexes.count );

	[sparseArray2 setObjectsFromSparseArray: sparseArray1];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 5, @"A sparse array with five objects should have a count of 3 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 5, @"A sparse array with five objects should have a count of 3 not %lu", sparseArray2.allIndexes.count );
	
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 45, @"twelve", 983, nil];
	[sparseArray2 setObjectsFromSparseArray: sparseArray1];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.allIndexes.count );
	
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 15, @"twelve", 48, nil];
	[sparseArray2 setObjectsFromSparseArray: sparseArray1];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray2.allIndexes.count );
	
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 23, @"twelve", 48, nil];
	[sparseArray2 setObjectsFromSparseArray: sparseArray1];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray2.allIndexes.count );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 23] isEqualToString: @"one"], @"The 'eight' should have been replaced by 'one' not '%@'", [sparseArray2 objectAtIndex: 23] );
	
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 23, @"twelve", 93, nil];
	[sparseArray2 setObjectsFromSparseArray: sparseArray1];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray2.allIndexes.count );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 23] isEqualToString: @"one"], @"The 'eight' should have been replaced by 'one' not '%@'", [sparseArray2 objectAtIndex: 23] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 93] isEqualToString: @"three"], @"The 'twelve' should have been replaced by 'three' not '%@'", [sparseArray2 objectAtIndex: 93] );
	
	sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"eight", 23, @"twelve", 93, nil];
	[sparseArray2 setObjectsFromSparseArray: nil];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray2.count );
	XCTAssertTrue( sparseArray2.allIndexes.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray2.allIndexes.count );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 23] isEqualToString: @"eight"], @"The 'eight' should not have been replaced, shoult not be '%@'", [sparseArray2 objectAtIndex: 23] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 93] isEqualToString: @"twelve"], @"The 'twelve' should have been replaced, should not be '%@'", [sparseArray2 objectAtIndex: 93] );

	//XCTFail( @"Testing of setEntriesFromSparseArray needs to be completed" );
}
- (void) test_DSMutableSparseArray_insertObjectAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet indexSet];
	[indexesToRemove addIndex: 301];
	[indexesToRemove addIndex: 303];
	[indexesToRemove addIndex: 305];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray insertObject: @"onePointFive" atIndex: 301];
	XCTAssertTrue( sparseArray.count == 7, @"A sparse array with seven objects should have a count of 7 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 7, @"The index set should have a count of 7 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"onePointFive"], @"Should be onePointFive" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 306] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray insertObject: nil atIndex: 14];
	XCTAssertTrue( sparseArray.count == 7, @"A sparse array with seven objects should have a count of 7 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 7, @"The index set should have a count of 7 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"onePointFive"], @"Should be onePointFive" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 306] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 307] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray insertObject: nil atIndex: 304];
	XCTAssertTrue( sparseArray.count == 7, @"A sparse array with seven objects should have a count of 7 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 7, @"The index set should have a count of 7 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"onePointFive"], @"Should be onePointFive" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 306] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 307] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 308] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray insertObject: nil atIndex: 30000];
	XCTAssertTrue( sparseArray.count == 7, @"A sparse array with seven objects should have a count of 7 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 7, @"The index set should have a count of 7 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"onePointFive"], @"Should be onePointFive" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 306] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 307] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 308] isEqualToString: @"six"], @"Should be six" );
	
	// Need to test exception throwing / not-throwing if an insert is done that pushes an entry beyond the end of the array
	indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 6, 6 )];
	DSSparseArray *testSparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	sparseArray = [testSparseArray mutableCopy];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 2] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 1] isEqualToString: @"six"], @"Should be six" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"No throw, no warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"No throw, but warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Need to test exception throwing / not-throwing if an insert is done that pushes an entry beyond the end of the array
	indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 8, 6 )];
	testSparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	sparseArray = [testSparseArray mutableCopy];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 8] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 7] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"six"], @"Should be six" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"No throw, no warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"No throw, but warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObject: nil atIndex: 0], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];

	//XCTFail( @"Add additional testing here" );
}

- (void) test_DSMutableSparseArray_insertObjectsAtIndexes {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	
	[sparseArray insertObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	
	[sparseArray insertObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 12, @"A sparse array with twelve objects should have a count of 12 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 12, @"The index set should have a count of 12 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 306] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 307] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 308] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 309] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 310] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 311] isEqualToString: @"six"], @"Should be six" );


	// Test the specific example from NSMutableArray documentation
	NSMutableArray *array = [NSMutableArray arrayWithObjects: @"one", @"two", @"three", @"four", nil];
	NSArray *newAdditions = [NSArray arrayWithObjects: @"a", @"b", nil];
	indexes = [NSMutableIndexSet indexSetWithIndex: 1];
	[indexes addIndex: 3];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithArray: array];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 0] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"four"], @"Should be four" );
	[sparseArray insertObjects: newAdditions atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 0] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"a"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"b"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 4] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 5] isEqualToString: @"four"], @"Should be four" );

	// The example from my documentation -- make sure it works!!
	DSMutableSparseArray *sparseArray2 = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 0, @"two", 1, @"three", 2, @"four", 3, @"ten", 9, nil];
	NSArray *newAdditions2 = [NSArray arrayWithObjects: @"a", @"b", @"j", nil];
	NSMutableIndexSet *indexes2 = [NSMutableIndexSet indexSetWithIndex: 1];
	[indexes2 addIndex: 3];
	[indexes2 addIndex: 11];
	[sparseArray2 insertObjects: newAdditions2 atIndexes: indexes2];
	NSLog(@"sparse array: %@", sparseArray2);
	// Output: array: ( 0: one, 1: a, 2: two, 3: b, 4: three, 5: four, 11: j, 12: ten )
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray2.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray2.count == 8, @"A sparse array with six objects should have a count of 4 not %lu", sparseArray2.count );
	XCTAssertTrue( [sparseArray2.allIndexes count] == 8, @"The index set should have a count of 6 not %lu", [sparseArray2.allIndexes count] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 0] isEqualToString: @"one"], @"Should be one not %@", [sparseArray2 objectAtIndex: 0] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 1] isEqualToString: @"a"], @"Should be a not %@", [sparseArray2 objectAtIndex: 1] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 2] isEqualToString: @"two"], @"Should be two not %@", [sparseArray2 objectAtIndex: 2] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 3] isEqualToString: @"b"], @"Should be b not %@", [sparseArray2 objectAtIndex: 3] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 4] isEqualToString: @"three"], @"Should be three not %@", [sparseArray2 objectAtIndex: 4] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 5] isEqualToString: @"four"], @"Should be four not %@", [sparseArray2 objectAtIndex: 5] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 11] isEqualToString: @"j"], @"Should be j not %@", [sparseArray2 objectAtIndex: 11] );
	XCTAssertTrue( [[sparseArray2 objectAtIndex: 12] isEqualToString: @"ten"], @"Should be ten not %@", [sparseArray2 objectAtIndex: 12] );

	// Check the null or empty argument cases...
	[sparseArray2 insertObjects: @[] atIndexes: [NSIndexSet indexSet]];
	[sparseArray2 insertObjects: nil atIndexes: [NSIndexSet indexSet]];
	[sparseArray2 insertObjects: @[] atIndexes: nil];
	
	// Need to test exception throwing / not-throwing if an insert is done that pushes an entry beyond the end of the array
	newAdditions2 = [NSArray arrayWithObjects: @"a", @"b", nil];
	indexes2 = [NSMutableIndexSet indexSetWithIndex: 12];
	[indexes2 addIndex: 597];
	indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 6, 6 )];
	DSSparseArray *testSparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	sparseArray = [testSparseArray mutableCopy];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 2] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 1] isEqualToString: @"six"], @"Should be six" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, no warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, but warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Need to test exception throwing / not-throwing if an insert is done that pushes an entry beyond the end of the array
	indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 8, 6 )];
	testSparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	sparseArray = [testSparseArray mutableCopy];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 8] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 7] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"six"], @"Should be six" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, no warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, but warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should not be thrown since a non-empty cell is only being pushed to the end" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should not be thrown since a non-empty cell is only being pushed to the end" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Need to test exception throwing / not-throwing if an insert is done that pushes an entry beyond the end of the array
	indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 8, 6 )];
	testSparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	sparseArray = [testSparseArray mutableCopy];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 8] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 7] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 6] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 5] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 4] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: NSNotFound - 3] isEqualToString: @"six"], @"Should be six" );
	newAdditions2 = [NSArray arrayWithObjects: @"a", @"b", @"c", nil];
	indexes2 = [NSMutableIndexSet indexSetWithIndex: 12];
	[indexes2 addIndex: 597];
	[indexes2 addIndex: 1492];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, no warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowButLogWarning];
	XCTAssertNoThrowSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"No throw, but warn - no exception" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	sparseArray = [testSparseArray mutableCopy];
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecificNamed( [sparseArray insertObjects: newAdditions2 atIndexes: indexes2], NSException, NSRangeException, @"Exception should be thrown since a non-empty cell is being pushed off the end" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];

	//XCTFail( @"Add additional testing here" );
}
- (void) test_DSMutableSparseArray_removeObjectAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 3, @"two", 13, @"three", 53, @"four", 2, nil];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	
	[sparseArray removeObjectAtIndex: 0];	// this should shift everyone down one...
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"four"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 12] isEqualToString: @"two"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 52] isEqualToString: @"three"], @"Should be one" );
	
	[sparseArray removeObjectAtIndex: 12];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertNil( [sparseArray objectAtIndex: 3], @"Entry 3 was removed, this should be null" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 1], @"Enty 1 should still be at 1" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 2], @"Enty 2 should still be at 2" );
	XCTAssertNil( [sparseArray objectAtIndex: 12], @"Enty 12 should be removed" );
	XCTAssertNil( [sparseArray objectAtIndex: 13], @"Entry 3 was removed, this should have been shifted from 13 to 12" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 51], @"Enty 52 should be at 51" );
	XCTAssertNil( [sparseArray objectAtIndex: 52], @"Entry 12 was removed, this should have been shifted from 52 to 51" );

	// What should these do... probably nothing?
//	NSMutableIndexSet *testIndexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( NSNotFound - 3,  3)];
//	NSLog( @"---------------------------------------------------------" );
//	NSLog( @"testIndexes: %@", testIndexes );
//	[testIndexes removeIndex: NSNotFound - 2];
//	NSLog( @"testIndexes: %@", testIndexes );
//	NSLog( @"---------------------------------------------------------" );
//	[testIndexes removeIndex: NSNotFound + 5];
//	NSLog( @"testIndexes: %@", testIndexes );
//	NSLog( @"---------------------------------------------------------" );
	[sparseArray removeObjectAtIndex: NSNotFound + 5];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound - 1];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );


	sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndNSUIntegerIndexes: @"one", NSNotFound - 3, @"two", NSNotFound - 2, @"three", NSNotFound - 1, nil];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound + 5];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound + 5];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound + 1];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound - 1];
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 2, @"The index set should have a count of 2 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectAtIndex: NSNotFound - 1];
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 2, @"The index set should have a count of 2 not %lu", [sparseArray.allIndexes count] );

}
- (void) test_DSMutableSparseArray_removeObject {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 3, @"two", 13, @"three", 53, @"four", 2, nil];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObject: @"two"];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"four"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"one"], @"Should be one" );
	XCTAssertNil( [sparseArray objectAtIndex: 13], @"'two' should be gone" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 52] isEqualToString: @"three"], @"Should be one" );
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"two", 3, @"two", 13, @"two", 53, @"two", 2, nil];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObject: @"two"];
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 0, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"four"], @"Should be one" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"one"], @"Should be one" );
	//XCTAssertNil( [sparseArray objectAtIndex: 13], @"'two' should be gone" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 52] isEqualToString: @"three"], @"Should be one" );

	// What about removing 'nil'? I will have the compact out the space!
	sparseArray = [DSMutableSparseArray sparseArrayWithObjectsAndIndexes: @"one", 3, @"two", 13, @"three", 53, @"four", 2, nil];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObject: nil];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 0, @"The first index should be 0 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 3, @"The last index should be 3 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 0] isEqualToString: @"four"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"three"], @"Should be one" );
}
- (void) test_DSMutableSparseArray_removeObjectsAtIndexes {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet indexSet];
	[indexesToRemove addIndex: 301];
	[indexesToRemove addIndex: 303];
	[indexesToRemove addIndex: 305];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsAtIndexes: indexesToRemove];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"three"], @"Should be three" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"five"], @"Should be five" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
}
- (void) test_DSMutableSparseArray_removeObjectsInRange {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInRange: NSMakeRange( 302, 3 )];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"six"], @"Should be six" );
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInRange: NSMakeRange( 100, 3 )];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 297] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 298] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 299] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"six"], @"Should be six" );
	
	//XCTFail( @"Testing of test_DSMutableSparseArray_removeObjectsInRange needs to be completed" );
}
- (void) test_DSMutableSparseArray_removeObjectsInArray {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInArray: @[ @"three", @"four", @"five" ]];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"six"], @"Should be six" );
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInArray: @[ @3, @4, @5 ]];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInArray: nil];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeObjectsInArray: @[ @3, @4, @5 ]];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 0, @"The index set should have a count of 0 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeObjectsInArray: @[ @"one" ]];
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 0, @"The index set should have a count of 0 not %lu", [sparseArray.allIndexes count] );
	
	//XCTFail( @"Testing of test_DSMutableSparseArray_removeObjectsInRange needs to be completed" );
}
- (void) test_DSMutableSparseArray_filterUsingPredicate {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray filterUsingPredicate: [NSPredicate predicateWithFormat: @"length = 3"]];
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with three objects should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 3, @"The index set should have a count of 3 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be two not '%@'", [sparseArray objectAtIndex: 305] );
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray filterUsingPredicate: [NSPredicate predicateWithFormat: @"length = 5"]];
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one objects should have a count of 1 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 1, @"The index set should have a count of 1 not %lu", [sparseArray.allIndexes count] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be two not '%@'", [sparseArray objectAtIndex: 305] )
	
	//XCTFail( @"Testing of test_DSMutableSparseArray_removeObjectsInRange needs to be completed" );
}
- (void) test_DSMutableSparseArray_removeLastObject {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 6 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"six"], @"Should be six" );
	[sparseArray removeLastObject];
	XCTAssertTrue( sparseArray.count == 5, @"A sparse array with five objects should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 5, @"The index set should have a count of 5 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	XCTAssertNil( [sparseArray objectAtIndex: 305], @"Should be six" );
	
	[sparseArray removeLastObject];
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one not '%@'", [sparseArray objectAtIndex: 300] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two not '%@'", [sparseArray objectAtIndex: 301] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertNil( [sparseArray objectAtIndex: 304], @"Should be nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 305], @"Should be nil" );
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"Allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 0, @"The index set should have a count of 0 not %lu", [sparseArray.allIndexes count] );
	[sparseArray removeLastObject];
	XCTAssertNotNil( sparseArray, @"Allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 0, @"The index set should have a count of 0 not %lu", [sparseArray.allIndexes count] );
	
	//XCTFail( @"Testing of test_DSMutableSparseArray_removeObjectsInRange needs to be completed" );
}
- (void) test_DSMutableSparseArray_shiftObjectsStartingAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 5 )];
	NSUInteger idx;
	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 0 (doest nothing)
	[sparseArray shiftObjectsStartingAtIndex: 301 by: 0];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 300, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 304, @"The last index should be 304 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );

	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting)
	[sparseArray shiftObjectsStartingAtIndex: 0 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 301, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 305, @"The last index should be 305 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting) in middle
	[sparseArray shiftObjectsStartingAtIndex: 303 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 300, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 305, @"The last index should be 305 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );

	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 308 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 300, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 304, @"The last index should be 304 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting)
	[sparseArray shiftObjectsStartingAtIndex: 50 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 299, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 303, @"The last index should be 305 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 299] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) in middle
	[sparseArray shiftObjectsStartingAtIndex: 303 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 4, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 300, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 303, @"The last index should be 305 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"four"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"five"], @"Should be five" );
	//XCTAssertTrue( [[sparseArray objectAtIndex: 305] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );

	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 308 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 300, @"The first index should be 301 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 304, @"The last index should be 304 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 300] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 302] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 303] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 304] isEqualToString: @"five"], @"Should be five" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Need to test borderline cases (when the resulting indexes will be out of range)
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	[indexes addIndex: 100];
	[indexes addIndex: 150];
	[indexes addIndex: 199];
	[indexes addIndex: 201];
	[indexes addIndex: 198];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try shifting down by 130 (deleting)
	[sparseArray shiftObjectsStartingAtIndex: 0 by: -130];
	XCTAssertTrue( sparseArray.count == 4, @"The sparse array should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 20, @"The first index should be 20 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 71, @"The last index should be 71 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 20] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 68] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 69] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 71] isEqualToString: @"five"], @"Should be five" );

	// Need to test with empty sparse array
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	// Try shifting it around
	[sparseArray shiftObjectsStartingAtIndex: 23 by: 12];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: 0 by: 12];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: 1000 by: -132];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: 12 by: -23];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: (NSNotFound - 10) by: 30];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	[indexes addIndex: 100];
	[indexes addIndex: 150];
	[indexes addIndex: 199];
	[indexes addIndex: 201];
	[indexes addIndex: 198];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting down by 100 (deleting)
	[sparseArray shiftObjectsStartingAtIndex: 199 by: -100];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 2, @"The shifted sparse array should have a count of 2 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 99, @"The first index should be 99 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 101, @"The last index should be 101 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 99] isEqualToString: @"four"], @"Should be four" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 101] isEqualToString: @"five"], @"Should be five" );
	XCTAssertNil( [sparseArray objectAtIndex: 100], @"The entry at 100 should be gone" );
	XCTAssertNil( [sparseArray objectAtIndex: 150], @"The entry at 150 should be gone" );
	XCTAssertNil( [sparseArray objectAtIndex: 198], @"The entry at 150 should be gone" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	[indexes addIndex: 100];
	[indexes addIndex: 150];
	[indexes addIndex: 198];
	[indexes addIndex: 199];
	[indexes addIndex: 201];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 100 by: 100];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The shifted sparse array should have a count of 5 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == 200, @"The first index should be 99 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == 301, @"The last index should be 101 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 200] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 250] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 298] isEqualToString: @"three"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 299] isEqualToString: @"four"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 301] isEqualToString: @"five"], @"Should be two" );
	//NSLog( @"The shifted up by one index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by one dictionary is %@", [sparseArray dictionary] );
	
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	idx = NSNotFound - 100;
	[indexes addIndex: idx];
	[indexes addIndex: idx + 48];
	[indexes addIndex: idx + 49];
	[indexes addIndex: idx + 50];
	[indexes addIndex: idx + 51];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: idx by: 50];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 3, @"The shifted sparse array should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == idx + 50, @"The first index should be 99 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == idx + 49 + 50, @"The last index should be 101 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 50] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 48 + 50] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 49 + 50] isEqualToString: @"three"], @"Should be two" );
	//NSLog( @"The shifted up by 100 index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by 100 dictionary is %@", [sparseArray dictionary] );
	//NSLog( @"The shifted up by 100 sparse array is %@", sparseArray );

	//--------- Testing exceptions properly thrown ------------------
	// Need to test borderline cases (when the resulting indexes will be out of range)
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	[indexes addIndex: 100];
	[indexes addIndex: 150];
	[indexes addIndex: 199];
	[indexes addIndex: 201];
	[indexes addIndex: 198];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try shifting down by 130 (deleting)
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 10 by: -10], NSException, @"This should have tried to move objects below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 10 by: -10], NSException, @"This should have tried to move objects below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 10 by: -10], NSException, @"This should have tried to move objects below zero" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try shifting down by 130 (deleting)
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -130], NSException, @"This should have tried to move objects below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -130], NSException, @"This should have tried to move objects below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -130], NSException, @"This should have tried to move objects below zero" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Need to test borderline cases (when the resulting indexes will be out of range)
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	[indexes addIndex: 100];
	[indexes addIndex: 150];
	[indexes addIndex: 199];
	[indexes addIndex: 201];
	[indexes addIndex: 198];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try shifting down by 130 (deleting)
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -30], NSException, @"This should have tried to shift the move start point below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -30], NSException, @"This should have tried to shift the move start point below zero" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: 0 by: -30], NSException, @"This should have tried to shift the move start point below zero" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	idx = NSNotFound - 100;
	[indexes addIndex: idx];
	[indexes addIndex: idx + 48];
	[indexes addIndex: idx + 49];
	[indexes addIndex: idx + 50];
	[indexes addIndex: idx + 51];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try a shift that exceeds index range
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 5], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty]; // Throw if non-empty go out of range
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 5], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny]; // Throw if any go out of range
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 5], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try a shift that exceeds index range
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 50], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty]; // Throw if non-empty go out of range
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 50], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny]; // Throw if any go out of range
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: idx by: 50], NSException, @"This should have tried to move objects beyond the end of the possible array size" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];
	
	// Allocation a fresh test array with adjusted indexes
	indexes = [NSMutableIndexSet indexSet];
	idx = 100;
	[indexes addIndex: idx];
	[indexes addIndex: idx + 48];
	[indexes addIndex: idx + 49];
	[indexes addIndex: idx + 50];
	[indexes addIndex: idx + 51];
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	// Try shifting up by 50 (inserting blanks) after everything but going beyond NSNotFount - 1
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: (NSNotFound - 30) by: 50], NSException, @"This should have tried to move the start point beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfNonEmpty];
	XCTAssertNoThrowSpecific( [sparseArray shiftObjectsStartingAtIndex: (NSNotFound - 30) by: 50], NSException, @"This should have tried to move the start point beyond the end of the possible array size" );
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertNotNil( sparseArray.allIndexes, @"An allocated sparse array shoult not have empty but not nil indexes" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeThrowIfAny];
	XCTAssertThrowsSpecific( [sparseArray shiftObjectsStartingAtIndex: (NSNotFound - 30) by: 50], NSException, @"This should have tried to move the start point beyond the end of the possible array size" );
	[DSSparseArray setThrowExceptionOnIndexOutOfRange: IndexOutOfRangeNoThrowNoWarn];

	//XCTFail( @"Just something to fail" );
}
@end
