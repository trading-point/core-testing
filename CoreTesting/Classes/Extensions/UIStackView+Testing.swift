import UIKit

extension UIStackView {
    func setBackgroundColor(_ color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color

        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        // put background view as the most background subviews of stack view
        insertSubview(backgroundView, at: 0)

        // pin the background view edge to the stack view edge
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
