

import UIKit
import SnapKit

class DayCell: UICollectionViewCell {
    static let identifier = "DayCell"

    private let containerView: UIView = {
        let view = UIView()
        view.makeRoundCorners(30)
        view.clipsToBounds = true
        return view
    }()

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.funnelDesplayMedium(size: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(dayLabel)
    }

    private func setupConstraint() {
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        dayLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with model: DayModel) {
        dayLabel.text = "\(model.dayNumber)\n\(model.weekdayShort)"
        if model.isToday {
            containerView.backgroundColor = .blueColor
            containerView.layer.shadowColor = UIColor.blue.cgColor
            containerView.layer.shadowRadius = 10
            containerView.layer.shadowOpacity = 0.6
            containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            dayLabel.textColor = .white
        } else {
            containerView.backgroundColor = .black
            containerView.layer.shadowOpacity = 0
            dayLabel.textColor = .lightGray
        }
    }
}

