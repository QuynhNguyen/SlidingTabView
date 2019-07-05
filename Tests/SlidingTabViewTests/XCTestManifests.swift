import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SlidingTabViewTests.allTests),
    ]
}
#endif
