import SnapshotTesting
import UIKit

public enum SnapshotTestConfig {
    public static var record = false
    public static var diffTool: String? = "ksdiff"
}

// MARK: Views

public extension SnapshotTestConfig {
    enum View {
        /**
         Used to test how the view looks like in a **single (fixed width, dynamic height) phone**
         for a specific domain case. Not interested in how the view behaves under extreme device
         configurations.
         
         Usually used when the view has already been tested how it looks like
         in another test using **all** devices configurations
         
         ~~~
         SnapshotTestConfig.View.small { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configuration to be tested.
        */
        public static func single(testing: (ImageSnapshotConfig) -> Void) {
            let config = ImageSnapshotConfig.iPhoneSe(
                userInterfaceStyle: .light,
                preferredContentSizeCategory: .large
            )
            combos(configs: config, testing: testing)
        }

        /**
         Used to test how the view looks like in **(fixed small and large width, dynamic height) phones**.
         Every view should include at least one such test.
         
         ~~~
         SnapshotTestConfig.View.all { config in
             assertImageSnapshot(matching: aView, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configurations to be tested.
        */
        public static func all(testing: (ImageSnapshotConfig) -> Void) {
            let small = ImageSnapshotConfig.iPhoneSe(
                userInterfaceStyle: .light,
                preferredContentSizeCategory: .extraExtraExtraLarge
            )
            let large = ImageSnapshotConfig.iPhoneX(
                userInterfaceStyle: .dark,
                preferredContentSizeCategory: .extraSmall
            )
            combos(configs: small, large, testing: testing)
        }
        
        
        /**
         Used to test how the view looks like in **custom fixed size** configuration,
         either **(fixed width, dynamic height)** or **(fixed width, fixed height)**.
         
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
            let small = ImageSnapshotConfig.fixed(
                fixedSize,
                userInterfaceStyle: .light,
                preferredContentSizeCategory: .extraExtraExtraLarge
            )
            let large = ImageSnapshotConfig.fixed(
                fixedSize,
                userInterfaceStyle: .dark,
                preferredContentSizeCategory: .extraSmall
            )
            combos(configs: small, large, testing: testing)
        }
        
        
        /**
         Used to test how the view looks like for dynamic width and height.

        - Parameter testing: The closure that returns the configurations to be tested.
         */
        public static func free(testing: (ImageSnapshotConfig) -> Void) {
            let small = ImageSnapshotConfig.fixed(
                nil,
                userInterfaceStyle: .light,
                preferredContentSizeCategory: .extraExtraExtraLarge
            )
            let large = ImageSnapshotConfig.fixed(
                nil,
                userInterfaceStyle: .dark,
                preferredContentSizeCategory: .extraSmall
            )
            combos(configs: small, large, testing: testing)
        }
        

        /**
         Used to test how the view looks like in the provided configurations.

        - Parameter testing: The closure that returns the configurations to be tested.
         */
        public static func combos(configs: ImageSnapshotConfig..., testing: (ImageSnapshotConfig) -> Void) {
            combos(configs: configs, testing: testing)
        }
        
        
        /**
         Used to test how the view looks like in the provided configurations.

        - Parameter testing: The closure that returns the configurations to be tested.
         */
        public static func combos(configs: [ImageSnapshotConfig], testing: (ImageSnapshotConfig) -> Void) {
            configs.forEach { config in
                testing(config)
            }
        }
    }
}

// MARK: View controllers

public extension SnapshotTestConfig {
    // config generation for view controllers
    enum VC {
        /**
         Used to test how a VC looks like in a **single width phone (iPhoneSE)** configuration
         for a specific domain case. Not interested in how the VC behaves under extreme device
         configurations.
         
         Usually used when the VC has already been tested how it looks like
         in another test using **all** devices configurations.
         
         ~~~
         SnapshotTestConfig.VC.small { config in
             assertImageSnapshot(matching: vc, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configuration to be tested.
        */
        public static func single(testing: (ViewImageConfig) -> Void) {
            var config: ViewImageConfig = .iPhoneSe
            config.traits = UITraitCollection(traitsFrom: [
                config.traits,
                .init(preferredContentSizeCategory:.large)
            ])
            combos(configs: config, testing: testing)
        }
        
        
        /**
         Used to test how a VC looks like in **small (iPhoneSe) and large width (iPhoneX) phone**
         configurations. Every VC should include at least one such test.
         
         ~~~
         SnapshotTestConfig.VC.all { config in
             assertImageSnapshot(matching: vc, config: config)
         }
         ~~~

        - Parameter testing: The closure that returns the configurations to be tested.
        */
        public static func all(testing: (ViewImageConfig) -> Void) {
            combos(configs: .small, .large, testing: testing)
        }
        
        
        /**
         Used to test how a VC looks like in the provided configurations.

        - Parameter testing: The closure that returns the configurations to be tested.
         */
        public static func combos(configs: ViewImageConfig..., testing: (ViewImageConfig) -> Void) {
            configs.forEach { config in
                testing(config)
            }
        }
    }
}

public extension ViewImageConfig {
    static let small: ViewImageConfig = {
        var config: ViewImageConfig = .iPhoneSe
        config.traits = UITraitCollection(traitsFrom: [
            config.traits,
            .init(preferredContentSizeCategory:.extraExtraExtraLarge)
        ])
        return config
    }()
    
    static let large: ViewImageConfig = {
        var config: ViewImageConfig = .iPhoneX
        config.traits = UITraitCollection(traitsFrom: [
            config.traits,
            .init(preferredContentSizeCategory: .large)
        ])
        return config
    }()
}
