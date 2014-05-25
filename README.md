# DSSparseArray and DSMutableSparseArray

These classes provide sparse array functionality for objective-c. They should be able to be used anyplace an [NSArray][] or [NSMutableArray][] is used but, unless the arrays have empty entries, are less efficient.

[DSSparseArray][] provides immutible array functionality that can contain empty or **nil** entries.

[DSMutableSparseArray][] provides mutable array functionality that can contain empty or **nil** entries.

These classes are implemented using an [NSIndexSet][] internally to keep track of what entries of the array have objects in them and an [NDDictionary][] to keep the objects themselves.

# Installation and Usage
Copy the [DSSparseArray.h][], [DSSparseArray.m][], [DSSparseArrayEnumerator.h][], and [DSSparseArrayEnumerator.m][] files into your project then just use like an [NSArray][] or [NSMutableArray][], substituting [DSSparseArray][] or [DSMutableSparseArray][].
Should be compatible with iOS or Mac OS X.

# License
The MIT License (MIT)

Copyright (c) [2014] [David W. Stockton]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[NSArray]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html#//apple_ref/occ/cl/NSArray
[NSMutableArray]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/Reference/Reference.html
[NSIndexSet]: https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/classes/NSIndexSet_Class/Reference/Reference.html#//apple_ref/occ/cl/NSIndexSet
[NDDictionary]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDictionary_Class/Reference/Reference.html#//apple_ref/occ/cl/NSDictionary
[DSSparseArray]: DSSparseArray.md
[DSMutableSparseArray]: DSMutableSparseArray.md
[DSSparseArray.h]: DSSparseArray.h
[DSSparseArray.m]: DSSparseArray.m
[DSSparseArrayEnumerator.h]: DSSparseArrayEnumerator.h
[DSSparseArrayEnumerator.m]: DSSparseArrayEnumerator.m