import XCTest
import GroupWork

#if os(Linux)
    import Dispatch
#endif

class GroupWorkTests: XCTestCase {
    func test() {
        let expectation = self.expectation(description: #function)

        let work = GroupWork()

        work.shortAsync()
        work.longAsync()

        work.allDone {
            XCTAssert(work.result)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}

extension GroupWork {
    func shortAsync() {
        start()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.finish(withResult: true)
        }
    }

    func longAsync() {
        start()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.finish(withResult: true)
        }
    }
}

#if os(Linux)
    extension GroupWorkTests {
        static var allTests: [(String, (GroupWorkTests) -> () throws -> Void)] {
            return [
                ("test", test)
            ]
        }
    }
#endif

