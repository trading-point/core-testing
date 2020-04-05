import SnapshotTesting
import UIKit

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
    
    let v = view()
    let size: CGSize
    switch (width, height) {
    case let (.some(w), .some(h)):
        size = CGSize(width: w, height: h)
    case let (.some(w), .none):
        let targetSize = CGSize(width: w, height: UIView.layoutFittingCompressedSize.height)
        size = v.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    case let (.none, .some(h)):
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: h)
        size = v.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    case (.none, .none):
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: UIView.layoutFittingCompressedSize.height)
        size = v.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)
    }

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

public enum SnapshotTestConfig {
    public static var record = false
    public static var diffTool: String? = "ksdiff"

    
    public enum View {
        /**
         Used to test how the view looks like in **small width phones**.
         
         Generates one single iPhoneSe size configuration (iPhoneX
         for WorkCo) with **fixed width and flexible height**.
         
         ~~~
         SnapshotTestConfig.View.small { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configuration to be tested.
        */
        public static func small(testing: (ImageSnapshotConfig) -> Void) {
            testing(
                .iPhoneX(
                    userInterfaceStyle: .light,
                    preferredContentSizeCategory: .large
                )
            )
        }

        /**
         Used to test how the view looks like in **small and large width phones**.
         
         Generates two size configurations (one for iPhoneSe and one for iPhone8Plus
         (iPhoneX and iPhoneSe for WorkCo) with **fixed width and flexible height**.
         
         ~~~
         SnapshotTestConfig.View.all { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configurations to be tested.
         Called twice, once per configuration returned.
        */
        public static func all(testing: (ImageSnapshotConfig) -> Void) {
            let configs: [ImageSnapshotConfig] = [
                .iPhoneX(
                    userInterfaceStyle: .light,
                    preferredContentSizeCategory: .large
                ),
                .iPhoneSe(
                    userInterfaceStyle: .dark,
                    preferredContentSizeCategory: .large
                ),
            ]
            combos(configs: configs, testing: testing)
        }

        static func combos(configs: [ImageSnapshotConfig], testing: (ImageSnapshotConfig) -> Void) {
            configs.forEach { config in
                testing(config)
            }
        }

        /**
         Used to test how the view looks like in **custom fixed size**.
         
         Generates one single size configuration with either **fixed width
         and flexible height** or **fixed width and height**.
         
         ~~~
         SnapshotTestConfig.View.fixed(.width(200)) { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~
         
         or
         
         ~~~
         SnapshotTestConfig.View.fixed(.widthAndHeight(200, 100)) { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configurations to be tested.
        */
        public static func fixed(_ fixedSize: ImageSnapshotConfig.FixedSize, testing: (ImageSnapshotConfig) -> Void) {
            testing(
                .fixed(fixedSize,
                       userInterfaceStyle: .light,
                       preferredContentSizeCategory: .large)
            )
        }
    }

    // config generation for view controllers
//    enum VC {
//        static internal func basic(testing: (Device, Theme) -> Void) {
//            testing(.phone4inch, .light)
//        }
//
//        static internal func all(testing: (Device, Theme) -> Void) {
//            let combosLightTheme = combos([Device.phone4inch, Device.phone4_7inch], [Theme.light])
//            let combosDarkTheme = combos([Device.phone5_8inch, Device.pad], [Theme.dark])
//            let combosForViewControllerSnapshots = combosDarkTheme + combosLightTheme
//            combosForViewControllerSnapshots.forEach { (device, theme) in
//                testing(device, theme)
//            }
//        }
//
//        static internal func allPhoneWidths(testing: (Device, Theme) -> Void) {
//            let combosForSizes = combos([Device.phone4inch, Device.phone4_7inch, Device.phone5_5inch], [Theme.light])
//            combosForSizes.forEach { (device, theme) in
//                testing(device, theme)
//            }
//        }
//    }
}
