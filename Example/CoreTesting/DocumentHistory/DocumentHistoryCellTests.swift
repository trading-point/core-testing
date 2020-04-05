import CoreTesting
import LayoutTest
@testable import CoreTesting_Example
import XCTest


class DocumentHistoryCellSnapshotTests: XCTestCase {
    override func setUp() {
        super.setUp()

//        SnapshotTestConfig.record = true
    }

    func testRejected() {
        let view = DocumentHistoryCell()
        let viewState = DocumentHistoryCell.ViewState(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: .rejected)
        view.update(with: viewState)

        SnapshotTestConfig.View.all { config in
            assertImageSnapshot(matching: view, config: config)
        }
    }        

    func testClarify() {
        let view = DocumentHistoryCell()
        let viewState = DocumentHistoryCell.ViewState(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: .clarify)
        view.update(with: viewState)

        SnapshotTestConfig.View.small { config in
            assertImageSnapshot(matching: view, config: config)
        }
    }

    func testReceived() {
        let view = DocumentHistoryCell()
        let viewState = DocumentHistoryCell.ViewState(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: .received)
        view.update(with: viewState)

        SnapshotTestConfig.View.small { config in
            assertImageSnapshot(matching: view, config: config)
        }
    }

    func testValidated() {
        let view = DocumentHistoryCell()
        let viewState = DocumentHistoryCell.ViewState(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: .validated)
        view.update(with: viewState)

        SnapshotTestConfig.View.small { config in
            assertImageSnapshot(matching: view, config: config)
        }
    }
}

/*
 For implementing automatic layout tests for a view,
 it has to conform to LayoutTest.ViewProvider protocol
 and also write a test like `testLayout()` below.

 https://linkedin.github.io/LayoutTest-iOS/pages/020_writingTest.html
 */
    
extension DocumentHistoryCell: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        ["title": StringValues(required: true), "subtitle": StringValues(required: true)]
    }

    public static func view(forData data: [AnyHashable: Any], reuse reuseView: UIView?, size _: ViewSize?, context _: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let view = reuseView as? DocumentHistoryCell ?? DocumentHistoryCell()
        let viewState = DocumentHistoryCell.ViewState(title: data["title"] as! String, subtitle: data["subtitle"] as! String, type: .validated)
        view.update(with: viewState)
        return view
    }
}

class DocumentHistoryCellLayoutTests: LayoutTestCase {
    func testLayout() {
        runLayoutTests { (_: DocumentHistoryCell, _, _) in
//            ambiguousAutolayoutTestsEnabled = false
            
            // Allow overlap in general
//            viewOverlapTestsEnabled = false

            // Allow overlap for specific views
//            viewsAllowingOverlap.add(view.overlappingView1)

            // Allow for views not contained within their superview
//            viewWithinSuperviewTestsEnabled = false

            // Allow for accessibility errors on specific views
//            viewsAllowingAccessibilityErrors.add(view.button)
        }
    }
}
