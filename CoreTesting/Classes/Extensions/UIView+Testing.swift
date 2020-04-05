import UIKit

extension UIView {
    public func visuallyDebugLayout() {
        var index = 0
        backgroundColor = .white
        visuallyDebugLayout(&index)
    }

    private func visuallyDebugLayout(_ index: inout Int) {
        // better color pallete (avoid light colors with white text) or fix the text as black, make sure that contrast if correct
        let colors: [UIColor] = [.yellow, .brown, .cyan, .green, .magenta, .orange, .purple, .red, .yellow]

        for view in subviews {
            if "\(view)".starts(with: "<_UI") { continue }
            index = (index + 1) % colors.count

            let color = colors[index]
            if let stackView = view as? UIStackView {
                stackView.setBackgroundColor(color)
            } else {
                view.backgroundColor = colors[index]
            }

            if let label = view as? UILabel {
                label.textColor = .black
                // increase the text by x2
                if let text = label.text {                    
                    //let increasedLengthText = (1...2).map { _ in text }.joined(separator: " ")
                    label.text = text + " " + text
                }
            }
            if view.subviews.count > 0 {
                view.visuallyDebugLayout(&index)
            }
        }
    }
}
