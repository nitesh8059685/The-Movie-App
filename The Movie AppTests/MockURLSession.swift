import Foundation

// Mock class to simulate URLSession behavior for testing
class MockURLSession: URLSession {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    private (set) var lastURL: URL?
    
    // Override the dataTask method to provide a mock implementation
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        lastURL = url
        return MockURLSessionDataTask {
            completionHandler(self.nextData, self.nextResponse, self.nextError)
        }
    }
}


// Mock class to simulate URLSessionDataTask behavior for testing
class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
