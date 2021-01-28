import UIKit

public final class SnapshotContainer<View: UIView>: UIView {

    public init(_ view: View, width: CGFloat? = nil, height: CGFloat? = nil) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        view.removeFromSuperview()
        addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        if let width = width {
            let sizeConstraints = view.constraints.filter { $0.firstAttribute == .width }
            view.removeConstraints(sizeConstraints)
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            let sizeConstraints = view.constraints.filter { $0.firstAttribute == .height }
            view.removeConstraints(sizeConstraints)
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
