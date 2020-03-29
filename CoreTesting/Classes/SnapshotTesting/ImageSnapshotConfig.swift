import Foundation
import SnapshotTesting

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
        let viewImageConfig: ViewImageConfig = .iPhoneSe
        return fixed(
            .width(viewImageConfig.size!.width),
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
