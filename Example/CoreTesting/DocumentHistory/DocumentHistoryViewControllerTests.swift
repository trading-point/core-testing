import XCTest
import CoreTesting

class DocumentHistoryViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()

//        SnapshotTestConfig.record = true
    }
    
    func testAllCellDomainCases() throws {
        let cases: [Document.`Type`] = [
            .received,
            .clarify,
            .validated,
            .rejected
        ]
        let data: [Document] = cases.map { Document.init(
            title: "My driving license",
            subtitle: "Nov 20, 2019 at 13:30, JPG",
            type: $0
        )}
        let vc = DocumentHistoryViewController(data: data)
        
        SnapshotTestConfig.VC.all { (config) in
            assertImageSnapshot(matching: vc, config: config)
        }
    }

}
