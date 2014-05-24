# DSSparseArray and DSMutableSparseArray

These classes provide sparse array functionality for objective-c. They should be able to be used anyplace an NSArray or NSMutableArray is used but, unless the arrays have empty entries, are less efficient.

[DSSparseArray](DSSparseArray.md) provides immutible array functionality that can contain empty or *nil* entries.

[DSMutableSparseArray](DSMutableSparseArray.md) provides mutable array functionality that can contain empty or *nil* entries.

These classes are implemented using an NSIndexSet internal to keep track of what entries of the array have objects in them and an NDDictionary to keep the objects themselves.

# Installation and Usage
Copy the DSSparseArray.h, DSSparseArray.m, DSSparseArrayEnumerator.h, and DSSparseArrayEnumerator.m into your project then use like an NSArray or NSMutableArray just substitute DSSparseArray or DSMutableSparseArray.
Should be compatible with iOS or Mac OS X.

# License
The MIT License (MIT)

Copyright (c) [2014] [David W. Stockton]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.