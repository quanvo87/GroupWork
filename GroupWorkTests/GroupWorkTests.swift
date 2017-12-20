import XCTest
import GroupWork

class GroupWorkTests: XCTestCase {
    func test() {
        let expectation = self.expectation(description: #function)

        let work = GroupWork()

        work.google()
        work.yahoo()

        work.allDone {
            print(work.result)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}

extension GroupWork {
    func google() {
        start()
        URLSession.shared.dataTask(with: URL(string: "https://google.com")!) { (_, response, _) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                self.finish(withResult: true)
            } else {
                self.finish(withResult: false)
            }
            }.resume()
    }

    func yahoo() {
        start()
        URLSession.shared.dataTask(with: URL(string: "https://yahoo.com")!) { (_, response, _) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                self.finish(withResult: true)
            } else {
                self.finish(withResult: false)
            }
            }.resume()
    }
}
