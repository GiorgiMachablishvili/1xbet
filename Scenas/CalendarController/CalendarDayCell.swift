

import UIKit
import SnapKit

class CalendarDayCell: UICollectionViewCell {
    static let identifier = "CalendarDayCell"

    //    private let dayLabel = UILabel()
    //    private let iconView = UIImageView()

    private lazy var iconView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let dayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.funnelDesplayMedium(size: 10)
        view.textColor = .whiteColor
        view.textAlignment = .left
        return view
    }()

    private let countLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.funnelDesplayMedium(size: 10)
        view.textColor = .blueColor
        view.textAlignment = .left
        view.isHidden = true
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.makeRoundCorners(12)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .grayColorBackgroundColor

        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError()
    }

    private func setup() {
        contentView.addSubview(iconView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(countLabel)
    }

    private func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(18 * Constraint.yCoeff)
            make.width.equalTo(18 * Constraint.xCoeff)
        }

        dayLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-6 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
        }

        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconView.snp.centerY)
            make.leading.equalTo(iconView.snp.trailing).offset(4 * Constraint.xCoeff)
        }
    }

    func configure(with day: CalendarDay) {
        let dayNum = Calendar.current.component(.day, from: day.date)
        dayLabel.text = "\(dayNum)"

        dayLabel.textColor = day.isCurrentMonth ? .whiteColor : .grayColorBackgroundColor.withAlphaComponent(0.5)
        iconView.image = day.activityCount > 0 ? UIImage(named: "workoutImage") : nil

        // Show count if activity > 1
        if day.activityCount > 1 {
            countLabel.isHidden = false
            countLabel.text = "+ \(day.activityCount)"
        } else {
            countLabel.isHidden = true
            countLabel.text = nil
        }

        if day.isToday {
            contentView.layer.borderColor = UIColor.blueColor.cgColor
            contentView.layer.borderWidth = 2
        } else {
            contentView.layer.borderWidth = 0
        }
    }

}

