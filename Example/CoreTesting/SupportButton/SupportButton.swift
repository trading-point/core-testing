import SnapKit
import UIKit

final class SupportButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: Dimension.buttonSize, height: Dimension.buttonSize)
    }

    // MARK: - Private Methods

    private func setupView() {        
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        adjustsImageSizeForAccessibilityContentSizeCategory = true
        layer.cornerRadius = CGFloat(Dimension.buttonSize / 2)
        setImage(#imageLiteral(resourceName: "tradingLogo"), for: .normal)
    }
}

extension SupportButton {
    enum Dimension {
        static let buttonSize = 60
    }
}
