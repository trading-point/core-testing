import SnapshotTesting
import UIKit

private func fittingSize(forView view: UIView, traits: UITraitCollection, width: CGFloat?, height: CGFloat?) -> CGSize {
    let viewController = UIViewController()
    viewController.view.addSubview(view)
    
    let rootViewController = UIViewController()
    rootViewController.addChild(viewController)
    viewController.view.frame = rootViewController.view.frame
    rootViewController.view.addSubview(viewController.view)

    let window: UIWindow = .init()
    window.isHidden = false
    
    rootViewController.setOverrideTraitCollection(traits, forChild: viewController)
    viewController.didMove(toParent: rootViewController)
    window.rootViewController = rootViewController

    rootViewController.beginAppearanceTransition(true, animated: false)
    rootViewController.endAppearanceTransition()

    rootViewController.view.setNeedsLayout()
    rootViewController.view.layoutIfNeeded()
    
    var size: CGSize = {
        switch (width, height) {
        case let (.some(w), .some(h)):
            return CGSize(width: w, height: h)
        case let (.some(w), .none):
            let targetSize = CGSize(width: w, height: UIView.layoutFittingCompressedSize.height)
            let calculatedSize = view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            assert(calculatedSize.width == w, "The width calculated by the layout system is not equal to the one that was passed to it. Please check that your height constraints are set properly")
            return calculatedSize
        case let (.none, .some(h)):
            let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: h)
            let calculatedSize = view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
            assert(calculatedSize.height == h, "The height calculated by the layout system is not equal to the one that was passed to it. Please check that your width constraints are set properly")
            return calculatedSize
        case (.none, .none):
            let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: UIView.layoutFittingCompressedSize.height)
            return view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)
        }
    }()
    size.width = ceil(size.width)
    size.height = ceil(size.height)
    
    return size
}

/**
 Runs the snapshot test for the provided view and configuration

 Will fail with a "zero size" assertion if size cannot be determined.
*/
public func assertImageSnapshot(
    matching view: @autoclosure () -> UIView,
    config: ImageSnapshotConfig,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let viewImageConfig = config.viewImageConfig
    let width: CGFloat? = config.fixedSize?.width
    let height: CGFloat? = config.fixedSize?.height
    
    let v: UIView = {
        switch (width, height) {
        case (.none, .none):
            return SnapshotContainer(view())
        default:
            return view()
        }
    }()
    let size = fittingSize(forView: v, traits: viewImageConfig.traits, width: width, height: height)
    
    diffTool = SnapshotTestConfig.diffTool

    assertSnapshot(
        matching: v,
        as: .image(size: size, traits: viewImageConfig.traits),
        named: name,
        record: recording || SnapshotTestConfig.record,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )
}

public func assertImageSnapshot(
    matching vc: UIViewController,
    config: ViewImageConfig,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    diffTool = SnapshotTestConfig.diffTool

    assertSnapshot(
        matching: vc,
        as: .image(on: config),
        named: name,
        record: recording || SnapshotTestConfig.record,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )
}
