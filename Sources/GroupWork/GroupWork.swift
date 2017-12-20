import Dispatch

/// Used to perform groups of work and keep track of the results.
public class GroupWork {
    private let group = DispatchGroup()

    /// The current result of the work items.
    public var result = true

    /// Initializes a `GroupWork`.
    public init() {}

    /// Should be called before some asynchronous work begins.
    public func start() {
        group.enter()
    }

    /// Should be called after some asynchronous work is done.
    ///
    /// - parameter result: The `Bool` result of the work that just finished.
    ///                     This will get `&&`'d with the current `result`.
    public func finish(withResult result: Bool) {
        let oldResult = self.result
        self.result = oldResult && result
        group.leave()
    }

    /// Handles what to do once all work is done.
    ///
    /// - parameter completion: The function to be executed when ALL work is done.
    public func allDone(completion: @escaping () -> Void) {
        group.notify(queue: .main) {
            completion()
        }
    }
}
