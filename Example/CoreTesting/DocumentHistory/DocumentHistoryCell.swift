import SnapKit
import UIKit

final class DocumentHistoryCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.0)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13.0)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()

    private let textContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Dimensions.TextContainerStackView.spacing
        return stackView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Dimensions.ContainerStackView.spacing
        return stackView
    }()

    private let statusLabel: PaddedLabel = {
        let label = PaddedLabel(horizontal: Dimensions.StatusLabel.horizontalMargin, vertical: Dimensions.StatusLabel.verticalMargin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13.0)
        label.adjustsFontForContentSizeCategory = true
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10.0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

//        let overlappingView1 = UIView()
//        let overlappingView2 = UIView()
//
//        let outOfBoundsView = UIView()
//
//        let button = UIButton()

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white

        setUpViews()
        
//        let label = UILabel()
//        label.text = "Hello"
//        contentView.addSubview(label)
//        label.snp.makeConstraints {
//            $0.leading.top.equalToSuperview()
//        }

        /*
         IMPORTANT: For UITableViewCell and UICollectionViewCell only
         subviews of the content view are checked for layout tests
         */

        /* Failing test example for views overlap */
//        contentView.addSubview(overlappingView1)
//        overlappingView1.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(5)
//        }
//
//        contentView.addSubview(overlappingView2)
//        overlappingView2.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(10)
//        }

        /* Failing test example for views not contained within superview */
//        contentView.addSubview(outOfBoundsView)
//        outOfBoundsView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(-10)
//        }

        /* Failing test example for views not contained within superview */
//        button.accessibilityIdentifier = "asdas"
//        contentView.addSubview(button)
//        button.snp.makeConstraints {
//            $0.top.leading.equalToSuperview()
//            $0.width.height.equalTo(40)
//        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func update(with viewState: ViewState) {
        titleLabel.text = viewState.title
        subtitleLabel.text = viewState.subtitle

        let status = viewState.status
        statusLabel.text = status.text
        statusLabel.textColor = status.textColor
        statusLabel.backgroundColor = status.backgroundColor
    }

    // MARK: - Private Methods

    private func setUpViews() {
        textContainerStackView.addArrangedSubview(titleLabel)
        textContainerStackView.addArrangedSubview(subtitleLabel)
        
        subtitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        containerStackView.addArrangedSubview(textContainerStackView)
        containerStackView.addArrangedSubview(statusLabel)
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.ContainerStackView.horizontalMargin)
            make.top.bottom.equalToSuperview().inset(Dimensions.ContainerStackView.verticalMargin)
        }
    }
}

extension DocumentHistoryCell {
    struct ViewState {
        let title: String
        let subtitle: String
        let status: Status

        init(title: String, subtitle: String, type: Type) {
            self.title = title
            self.subtitle = subtitle
            self.status = Status.make(from: type)
        }
    }
}

extension DocumentHistoryCell.ViewState {
    enum `Type` {
        case received
        case clarify
        case validated
        case rejected
    }
}

extension DocumentHistoryCell.ViewState {
    struct Status {
        let text: String
        let textColor: UIColor
        let backgroundColor: UIColor

        private init(text: String, textColor: UIColor, backgroundColor: UIColor) {
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }

        static func make(from type: Type) -> Status {
            switch type {
            case .received:
                return Status(
                    text: "Received",
                    textColor: .black,
                    backgroundColor: .green
                )
            case .clarify:
                return Status(
                    text: "Clarify",
                    textColor: .white,
                    backgroundColor: .orange
                )
            case .validated:
                return Status(
                    text: "Validated",
                    textColor: .white,
                    backgroundColor: .green
                )
            case .rejected:
                return Status(
                    text: "Rejected",
                    textColor: .white,
                    backgroundColor: .red
                )
            }
        }
    }
}

extension DocumentHistoryCell {
    enum Dimensions {
        enum ContainerStackView {
            static let verticalMargin: CGFloat = 10.0
            static let horizontalMargin: CGFloat = 20.0
            static let spacing: CGFloat = 10.0
        }

        enum TextContainerStackView {
            static let spacing: CGFloat = 2.0
        }

        enum StatusLabel {
            static let horizontalMargin: CGFloat = 10.0
            static let verticalMargin: CGFloat = 3.0
        }
    }
}
