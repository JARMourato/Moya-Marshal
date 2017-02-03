# Moya-Marshal
============
[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-Marshal.svg)](https://github.com/JARMourato/Moya-Marshal)
![Swift 3.0.x](https://img.shields.io/badge/Swift-3.0.x-orange.svg)

[![CI Status](http://img.shields.io/travis/JARMourato/Moya-Marshal.svg?style=flat)](https://travis-ci.org/JARMourato/Moya-Marshal)
[![Version](https://img.shields.io/cocoapods/v/Moya-Marshal.svg?style=flat)](http://cocoapods.org/pods/Moya-Marshal)
[![License](https://img.shields.io/cocoapods/l/Moya-Marshal.svg?style=flat)](http://cocoapods.org/pods/Moya-Marshal)
[![Platform](https://img.shields.io/cocoapods/p/Moya-Marshal.svg?style=flat)](http://cocoapods.org/pods/Moya-Marshal)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

```ruby
pod 'Moya-Marshal'
```

The subspec if you want to use the bindings over RxSwift.

```ruby
pod 'Moya-Marshal/RxSwift'
```

And the subspec if you want to use the bindings over ReactiveCocoa.

```ruby
pod 'Moya-Marshal/ReactiveCocoa'
```

# Usage

Create a `Class` or `Struct` which implements the `Unmarshaling` protocol.

```swift
import Foundation
import Marshal

struct User: Unmarshaling {
  var id: Int
  var name: String
  var email: String

  init(object: MarshaledObject) throws {
    id = try object.value(for: "id")
    name = try object.value(for: "name")
    email = try object.value(for: "email")
  }
}
```

### Moya.Response mapping

```swift
provider
    .request(.AllUsers) { result in
        if case let .Success(response) = result {
            do {
                let argoUsers:[ArgoUser] = try response.mapArray(MarshalUser.self)
                print("mapped to users: \(argoUsers)")
            } catch {
                print("Error mapping users: \(error)")
            }
        }
    }
```

### RxSwift

```swift
provider
    .request(.AllUsers)
    .mapArray(MarshalUser.self)
    .observeOn(MainScheduler.instance)
    .subscribeNext { users in
        self.users = users
        self.tableView.reloadData()
    }.addDisposableTo(disposeBag)
```

### ReactiveCocoa

```swift
provider
    .request(.AllUsers)
    .mapArray(MarshalUser.self)
    .observeOn(UIScheduler())
    .start { event in
        switch event {
        case .Next(let users):
            self.users = users
            self.tableView.reloadData()
        case .Failed(let error):
            print("error: \(error)")
        default: break
        }
    }
```
# Contributing
Feedback, issues or pull requests are welcomed!

## Thanks
This project tries to follow the [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper) project standards.  

## Author
JARMourato, joao.armourato@gmail.com

## License
Moya-Marshal is available under the MIT license. See the LICENSE file for more info.