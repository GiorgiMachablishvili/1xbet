

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

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraint()
    }

    required init?(coder: NSCoder) { fatalError()
    }

    private func setup() {
        addSubview(titleLabel)
    }

    private func setupConstraint() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
