

import UIKit
import SnapKit


class MonthHeaderView: UICollectionReusableView {
    static let identifier = "MonthHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.funnelDesplayBold(size: 18)
        label.textColor = .whiteColor
        return label
    }()

    private let weekdaysStack: UIStackView = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        guard let weekSymbols = formatter.shortWeekdaySymbols else { return UIStackView() }

        let calendar = Calendar.current
        let weekStartIndex = calendar.firstWeekday

        let ordered = Array(weekSymbols[weekStartIndex...] + weekSymbols[..<weekStartIndex])

        let labels = ordered.map { day -> UILabel in
            let label = UILabel()
            label.text = day
            label.font = UIFont.funnelDesplayMedium(size: 10)
            label.textColor = .whiteColor
            label.textAlignment = .center
            return label
        }

        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        addSubview(titleLabel)
        addSubview(weekdaysStack)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4 * Constraint.yCoeff)
            $0.leading.trailing.equalToSuperview().inset(8 * Constraint.xCoeff)
        }

        weekdaysStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            $0.leading.trailing.equalToSuperview().inset(8 * Constraint.xCoeff)
            $0.bottom.equalToSuperview().offset(-4 * Constraint.yCoeff)
            $0.height.equalTo(16 * Constraint.yCoeff)
        }
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
