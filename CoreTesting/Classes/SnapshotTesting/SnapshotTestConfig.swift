import SnapshotTesting
import UIKit

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
    let width = config.fixedSize?.width ?? viewImageConfig.size?.width
    let height = config.fixedSize?.height
    let container = SnapshotContainer(view(), width: width, height: height)

    diffTool = SnapshotTestConfig.diffTool

    assertSnapshot(
        matching: container,
        as: .image(traits: viewImageConfig.traits),
        named: name,
        record: recording || SnapshotTestConfig.record,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )
}

public struct ImageSnapshotConfig {
    public let viewImageConfig: ViewImageConfig
    public var fixedSize: FixedSize?

    private init(
        viewImageConfig: ViewImageConfig,
        userInterfaceStyle: UIUserInterfaceStyle,
        preferredContentSizeCategory: UIContentSizeCategory
    ) {
        var newViewImageConfig = viewImageConfig
        newViewImageConfig.traits = UITraitCollection(traitsFrom: [
            viewImageConfig.traits,
            UITraitCollection(displayScale: 2.0),
            UITraitCollection(userInterfaceStyle: userInterfaceStyle),
            UITraitCollection(preferredContentSizeCategory: preferredContentSizeCategory),
        ])

        self.viewImageConfig = newViewImageConfig
    }

    static func fixed(
        _ fixedSize: FixedSize,
        userInterfaceStyle: UIUserInterfaceStyle,
        preferredContentSizeCategory: UIContentSizeCategory
    ) -> ImageSnapshotConfig {
        let viewImageConfig = ViewImageConfig(safeArea: .zero, size: nil, traits: UITraitCollection())
        var config = ImageSnapshotConfig(
            viewImageConfig: viewImageConfig,
            userInterfaceStyle: userInterfaceStyle,
            preferredContentSizeCategory: preferredContentSizeCategory
        )
        config.fixedSize = fixedSize
        return config
    }

    static func iPhoneSe(userInterfaceStyle: UIUserInterfaceStyle, preferredContentSizeCategory: UIContentSizeCategory) -> ImageSnapshotConfig {
        ImageSnapshotConfig(
            viewImageConfig: .iPhoneSe,
            userInterfaceStyle: userInterfaceStyle,
            preferredContentSizeCategory: preferredContentSizeCategory
        )
    }

    static func iPhone8(userInterfaceStyle: UIUserInterfaceStyle, preferredContentSizeCategory: UIContentSizeCategory) -> ImageSnapshotConfig {
        ImageSnapshotConfig(
            viewImageConfig: .iPhone8,
            userInterfaceStyle: userInterfaceStyle,
            preferredContentSizeCategory: preferredContentSizeCategory
        )
    }

    static func iPhone8Plus(userInterfaceStyle: UIUserInterfaceStyle, preferredContentSizeCategory: UIContentSizeCategory) -> ImageSnapshotConfig {
        ImageSnapshotConfig(
            viewImageConfig: .iPhone8Plus,
            userInterfaceStyle: userInterfaceStyle,
            preferredContentSizeCategory: preferredContentSizeCategory
        )
    }
    
    static func iPhoneX(userInterfaceStyle: UIUserInterfaceStyle, preferredContentSizeCategory: UIContentSizeCategory) -> ImageSnapshotConfig {
        ImageSnapshotConfig(
            viewImageConfig: .iPhoneX,
            userInterfaceStyle: userInterfaceStyle,
            preferredContentSizeCategory: preferredContentSizeCategory
        )
    }
}

extension ImageSnapshotConfig {
    public enum FixedSize {
        case width(CGFloat)
        case widthAndHeight(CGFloat, CGFloat)

        var width: CGFloat {
            switch self {
            case let .width(value):
                return value
            case let .widthAndHeight(value, _):
                return value
            }
        }

        var height: CGFloat? {
            switch self {
            case let .widthAndHeight(_, value):
                return value
            case .width:
                return nil
            }
        }
    }
}

public enum SnapshotTestConfig {
    public static var record = false
    public static var diffTool: String? = "ksdiff"

    // config generation for views
    public enum View {
        public static func small(testing: (ImageSnapshotConfig) -> Void) {
            testing(
                .iPhoneX(
                    userInterfaceStyle: .light,
                    preferredContentSizeCategory: .large
                )
            )
        }

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

        public static func combos(configs: [ImageSnapshotConfig], testing: (ImageSnapshotConfig) -> Void) {
            configs.forEach { config in
                testing(config)
            }
        }

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
