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
	XCTAssertTrue( sparseArray.count == 0, @"An empty sparse array should have count of 0" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"An empty sparse array should return nil for any index" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"An empty sparse array should return nil for any index" );
	XCTAssertNil( [sparseArray objectAtIndex: 5], @"An empty sparse array should return nil for any index" );
	
	sparseArray = [DSSparseArray sparseArrayWithArray: @[@"hello sparse array", @"goodbye sparse array"]];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 3], @"Requesting the wrong index should return nil" );

	sparseArray = [DSSparseArray sparseArrayWithArray: @[@"hello sparse array", @"goodbye sparse array", @"hello again sparse array"]];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	
	sparseArray2 = [DSSparseArray sparseArrayWithSparseArray: sparseArray];
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray2.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	sparseArray = nil;
	XCTAssertNotNil( sparseArray2, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray2.count == 3, @"A sparse array with two objects should have a count of 2" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 0], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 1], @"This is the right index - it should return the string" );
	XCTAssertNotNil( [sparseArray2 objectAtIndex: 2], @"This is the right index - it should return the string" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray2 objectAtIndex: 3], @"Requesting the wrong index should return nil" );
	
	sparseArray = [DSSparseArray sparseArrayWithObject: @"hello sparse array" atIndex: 3];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one object should have a count of 1" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	
	indexes = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange( 3, 2 )];
	objects = @[ @"hello sparse array", @"goodbye sparse array" ];
	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 1, @"A sparse array with one object should have a count of 1" );
	XCTAssertNil( [sparseArray objectAtIndex: 0], @"Requesting the wrong index should return nil" );
	XCTAssertNil( [sparseArray objectAtIndex: 300], @"Requesting the wrong index should return nil" );
	XCTAssertNotNil( [sparseArray objectAtIndex: 3], @"This is the right index - it should return the string" );
	
	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes: @"hello sparse array", 3, @"goodbye sparse array", 5, nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 2, @"A sparse array with one object should have a count of 1" );
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
	XCTAssertTrue( indexes.count == 0, @"There should be nothing in the index set since it did not match" );
	XCTAssertTrue( [indexes firstIndex] == NSNotFound, @"The first index should be NSNotFound" );
	XCTAssertTrue( [indexes lastIndex] == NSNotFound, @"The last index should also be NSNotFound" );

	sparseArray = [DSSparseArray sparseArrayWithObjectsAndIndexes:
		         @"hello sparse array", 3,
		       @"goodbye sparse array", 5,
		          @"what sparse array", 9,
				nil];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
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
}

- (void) test_DSSparseArray_enumerateIndexesAndObjectsUsingBlock {
	NSLog( @"==== Entering %s", __func__ );
	DSSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];

	sparseArray = [DSSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
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
- (void) test_DSMutableSparseArray_setObjectAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
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
}

- (void) test_DSMutableSparseArray_insertObjectsAtIndexes {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five", @"six" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 6 )];
	
	sparseArray = [DSMutableSparseArray sparseArray];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 0, @"A sparse array with no objects should have a count of 0 not %lu", sparseArray.count );
	
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
	XCTAssertTrue( sparseArray.count == 4, @"A sparse array with four objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 4, @"The index set should have a count of 4 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 0] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"four"], @"Should be four" );
	[sparseArray insertObjects: newAdditions atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"An allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 6, @"A sparse array with six objects should have a count of 4 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes count] == 6, @"The index set should have a count of 6 not %lu", [sparseArray.allIndexes count] );
	XCTAssertTrue( [[sparseArray objectAtIndex: 0] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 1] isEqualToString: @"a"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 2] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 3] isEqualToString: @"b"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 4] isEqualToString: @"three"], @"Should be three" );
	XCTAssertTrue( [[sparseArray objectAtIndex: 5] isEqualToString: @"four"], @"Should be four" );
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
- (void) test_DSMutableSparseArray_shiftObjectsStartingAtIndex {
	NSLog( @"==== Entering %s", __func__ );
	DSMutableSparseArray *sparseArray;
	NSArray *objects = @[ @"one", @"two", @"three", @"four", @"five" ];
	NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange: NSMakeRange( 300, 5 )];
	NSUInteger idx;
	
	// Allocation a fresh test array
	sparseArray = [DSMutableSparseArray sparseArrayWithObjects: objects atIndexes: indexes];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 0 (doest nothing)
	[sparseArray shiftObjectsStartingAtIndex: 301 by: 0];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting)
	[sparseArray shiftObjectsStartingAtIndex: 0 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting) in middle
	[sparseArray shiftObjectsStartingAtIndex: 303 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (inserting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 308 by: 1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting)
	[sparseArray shiftObjectsStartingAtIndex: 50 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) in middle
	[sparseArray shiftObjectsStartingAtIndex: 303 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 308 by: -1];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	// Try shifting it around
	[sparseArray shiftObjectsStartingAtIndex: 23 by: 12];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: 0 by: 12];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 0, @"The sparse array should have a count of 0 not %lu", sparseArray.count );
	[sparseArray shiftObjectsStartingAtIndex: 1000 by: -132];
	XCTAssertNotNil( sparseArray, @"The allocated sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting down by 100 (deleting)
	[sparseArray shiftObjectsStartingAtIndex: 199 by: -100];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: 100 by: 100];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
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
	XCTAssertTrue( sparseArray.count == 5, @"The sparse array should have a count of 5 not %lu", sparseArray.count );
	
	// Try shifting up by 1 (deleting) after (does nothing)
	[sparseArray shiftObjectsStartingAtIndex: idx by: 50];
	XCTAssertNotNil( sparseArray, @"The shifted sparse array should not be nil" );
	XCTAssertTrue( sparseArray.count == 3, @"The shifted sparse array should have a count of 3 not %lu", sparseArray.count );
	XCTAssertTrue( [sparseArray.allIndexes firstIndex] == idx + 50, @"The first index should be 99 not %lu", [sparseArray.allIndexes firstIndex] );
	XCTAssertTrue( [sparseArray.allIndexes lastIndex] == idx + 49 + 50, @"The last index should be 101 not %lu", [sparseArray.allIndexes lastIndex] );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 50] isEqualToString: @"one"], @"Should be one" );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 48 + 50] isEqualToString: @"two"], @"Should be two" );
	XCTAssertTrue( [[sparseArray objectAtIndex: idx + 49 + 50] isEqualToString: @"three"], @"Should be two" );
	//NSLog( @"The shifted up by 100 index set is %@", sparseArray.allIndexes );
	//NSLog( @"The shifted up by 100 dictionary is %@", [sparseArray dictionary] );
	//NSLog( @"The shifted up by 100 sparse array is %@", sparseArray );
	
	//XCTFail( @"Just something to fail" );
}
@end
