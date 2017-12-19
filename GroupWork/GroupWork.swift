/// Used to perform groups of work and keep track of the results.
public typealias Key = String

struct GroupWorkDictionary {
    static var dictionary: [Key: (group: DispatchGroup, result: Bool)] = {
        return [Key: (group: DispatchGroup, result: Bool)]()
    }()
}

/// Used to perform groups of work and keep track of the results.
public extension Key {

    /// The current result of the `Key`'s work items. Each time a `Key`'s work
    /// item completes, it `&&`'s its result with this property. `result` begins
    /// as `true` for new `Key`s. Returns false if called on an invalid `Key`.
    public var result: Bool {
        return GroupWorkDictionary.dictionary[self]?.result ?? false
    }

    /// Returns a new `Key`.
    public static func make() -> Key {
        let key = UUID().uuidString
        GroupWorkDictionary.dictionary[key] = (DispatchGroup(), true)
        return key
    }

    /// Indicates that some work has just started for the `Key`. A call to
    /// `start()` must be proceeded by a call to `finish()` eventually.
    public func start() {
        GroupWorkDictionary.dictionary[self]?.group.enter()
    }

    /// Indicates that some work has just finished for the `Key`. A call to
    /// `finish()` must proceed a call to `start()`.
    ///
    /// - parameter result: The `Bool` result of the work that just finished.
    ///                     This will get `&&`'d to the current `result` for the `Key`.
    public func finish(withResult result: Bool = true) {
        GroupWorkDictionary.dictionary[self]?.result = self.result && result
        GroupWorkDictionary.dictionary[self]?.group.leave()
    }

    /// Used to pass in a function that should be called when ALL work for a
    /// `Key` is done.
    ///
    /// - parameter completion: The function to be executed when ALL work for a
    ///                         `Key` is done. Typically, `remove()` should be
    ///                         called somewhere in the body of this function.
    public func allDone(completion: @escaping () -> Void) {
        GroupWorkDictionary.dictionary[self]?.group.notify(queue: .main) {
            completion()
        }
    }

    /// Removes a `Key`'s data. This should be called to clean up resources when
    /// done with a `Key`. A `Key` should not be used after this function is called.
    public func remove() {
        GroupWorkDictionary.dictionary.removeValue(forKey: self)
    }
}
