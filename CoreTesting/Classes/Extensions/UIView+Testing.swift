import UIKit

extension UIView {
    public func visuallyDebugLayout() {
        var index = 0
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
                // increase the text by x4
                if let text = label.text {                    
                    label.text = (1...4).reduce("") { (result, _) -> String in
                        return result + " " + text
                    }
                }
            }
            if view.subviews.count > 0 {
                view.visuallyDebugLayout(&index)
            }
        }
    }
}
