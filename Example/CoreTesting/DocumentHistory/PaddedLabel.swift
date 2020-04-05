import UIKit

public final class PaddedLabel: UILabel {
    let horizontal: CGFloat
    let vertical: CGFloat

    public init(horizontal: CGFloat = 0.0, vertical: CGFloat = 0.0) {
        self.horizontal = horizontal
        self.vertical = vertical

        super.init(frame: .zero)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += 2 * horizontal
        size.height += 2 * vertical
        return size
    }
}
