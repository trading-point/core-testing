import UIKit

public final class SnapshotContainer<View: UIView>: UIView {
    let view: View

    public init(_ view: View, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.view = view

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // remove any old size constraints
        let sizeConstraints = view.constraints.filter { $0.firstAttribute == .width || $0.firstAttribute == .height }
        view.removeConstraints(sizeConstraints)

        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
