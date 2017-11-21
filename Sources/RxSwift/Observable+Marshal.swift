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
import RxSwift
import Moya
import Marshal

/// Extension for processing Responses into Mappable objects through Marshal

public extension Single where Element == Response {
    /// Maps data received from the signal into an object
    /// which implements the Unmarshaling protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func map<T: Unmarshaling>(to type: T.Type) -> Single<T> {
        return asObservable()
            .flatMap { response -> Observable<T> in
                return Observable.just(try response.map(to: T.self))
            }
            .asSingle()
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Unmarshaling protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapArray<T: Unmarshaling>(of type: T.Type) -> Single<[T]> {
        return asObservable()
            .flatMap { response -> Observable<[T]> in
                return Observable.just(try response.mapArray(of: T.self))
            }
            .asSingle()
    }
}
