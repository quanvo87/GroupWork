# GroupWork

Swift module that helps with running multiple, concurrent, asynchronous tasks in a clean way.

## Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
3. [Documentation](#documentation)
4. [Example Usage](#example-usage)
5. [Working Example](#working-example)
6. [License](#license)
7. [Authors](#authors)

## Requirements

Swift 4

## Installation

#### CocoaPods

For [CocoaPods](http://cocoapods.org/), add to `Podfile`:

```ruby
pod 'GroupWork', '~> 0.0.3'
```

#### Carthage
For [Carthage](https://github.com/Carthage/Carthage), add to `Cartfile`:

```
github "quanvo87/GroupWork"
```

#### Swift Package Manager

For [SPM](https://swift.org/package-manager/), add to your package dependencies:

```
.package(url: "https://github.com/quanvo87/GroupWork.git", .upToNextMinor(from: "0.0.0")),
```

#### Manually

- for projects, drag `GroupWork.swift` to the project tree
- for workspaces, include the whole `GroupWork.xcodeproj`

## Documentation

[Here]()

## Example Usage

#### End Goal

```swift
import GroupWork

...

func complexFunc(completion: @escaping (Bool) -> Void) {
  let work = GroupWork()

  work.simpleFuncA()
  work.simpleFuncB()
  work.simpleFuncC()

  work.allDone() {
    completion(work.result)
  }
}

...
```

`complexFunc` is a function that returns the result of three simple, asynchronous functions `simpleFuncA()`, `simpleFuncB()`, and `simpleFuncC()`, which run concurrently. The completion handler is called only when all the simple functions have completed. Usage of this library has enabled the above clean interface. This can be scaled to much higher than three simple functions.

Caveats:
  - the simple functions MUST be able to run simultaneously without affecting each other
  - `work.result` is only a simple `Bool`
  - this is not an answer to [callback hell](http://callbackhell.com/)

#### Set Up

There is some set up required in order to create `complexFunc()` from above:

```swift
import GroupWork

extension GroupWork {
  func simplefuncA() {
    start()
    networkCallA() { (result)
      self.finish(withResult: result)
    }
  }

  func simplefuncB() {
    start()
    networkCallB() { (result)
      self.finish(withResult: result)
    }
  }

  func simplefuncC() {
    start()
    networkCallC() { (result)
      self.finish(withResult: result)
    }
  }
}
```

Now you can create a `GroupWork`, and call `work.simpleFuncA()` on it like in the example.

Caveats:
  - notice that in each function, `start()` is called before each asynchronous task
  - `finish(withResult:)` is called in the completion handler of each asynchronous task
  - `start()` and `finish()` calls MUST be balanced

## Working Example

The [tests]() have a working example.

## License
[MIT](http://opensource.org/licenses/MIT) [LICENSE](LICENSE)

## Authors

[Quan Vo](https://github.com/quanvo87), [Wilson Ding](https://github.com/dingwilson)

*Please provide attribution, it is greatly appreciated.*
