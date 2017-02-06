/*
 The MIT License (MIT)
 
 Copyright (c) 2017 JARMourato <joao.armourato@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation
import Moya
import Marshal

public extension Response {
    
    /// Maps data received from the signal into an object which implements the Unmarshaling protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: Unmarshaling>(to type: T.Type) throws -> T {
        guard let jsonObject = try mapJSON() as? MarshaledObject else {
            throw MoyaError.jsonMapping(self)
        }
        return try T.init(object: jsonObject)
    }
    
    /// Maps data received from the signal into an array of objects which implement the Unmarshaling
    /// protocol.
    public func mapArray<T: Unmarshaling>(of type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [MarshaledObject] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return try array.map { try T.init(object: $0) }
    }
}
