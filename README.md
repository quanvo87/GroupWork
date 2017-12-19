# GroupWork

Swift module that helps with running multiple, simultaneous, asynchronous tasks in a clean way.

## Requirements

Swift 4 / Xcode 9

## Installation

## Example Usage

It's recommended to read over the short and simple [docs]().

### End Goal

```swift
import GroupWork

...

func complexFunc(completion: @escaping (Bool) -> Void) {
  let key = GroupWork.Key.make()

  key.simpleFuncA()
  key.simpleFuncB()
  key.simpleFuncC()

  key.allDone() {
    completion(key.result)
    key.remove()
  }
}

...
```

`complexFunc` is a function that returns the result of three simple, asynchronous functions `simpleFuncA()`, `simpleFuncB()`, and `simpleFuncC()`, called simultaneously. The completion handler is called only when all the simple functions have completed. Usage of this library has enabled the above clean interface. This can be scaled much higher than three simple functions.

Caveats:
  - the simple functions MUST be able to run simultaneously without affecting each other
  - `key.result` is only a simple `Bool`
  - this is not an answer to [callback hell](http://callbackhell.com/)

### Set Up

There is some set up required in order to create `complexFunc()` from above:

```swift
import GroupWork

extension GroupWork.Key {
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

Now you can create a `Key`, and call `key.simpleFuncA()` on it like in the example.

Caveats:
  - notice that in each function, `start()` is called before each asynchronous task
  - `finish(withResult:)` is called in the completion handler of each asynchronous task
  - `start()` and `finish()` calls MUST be balanced
