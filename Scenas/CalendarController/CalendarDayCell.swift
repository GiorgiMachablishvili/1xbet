

import UIKit
import SnapKit

class CalendarDayCell: UICollectionViewCell {
    static let identifier = "CalendarDayCell"

    private let dayLabel = UILabel()
    private let iconView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .black

        dayLabel.font = UIFont.systemFont(ofSize: 14)
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center

        iconView.contentMode = .scaleAspectFit

        contentView.addSubview(iconView)
        contentView.addSubview(dayLabel)

        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }

        dayLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-6)
            make.centerX.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with day: CalendarDay) {
        let dayNum = Calendar.current.component(.day, from: day.date)
        dayLabel.text = "\(dayNum)"

        if day.isToday {
            contentView.layer.borderColor = UIColor.blueColor.cgColor
            contentView.layer.borderWidth = 2
        } else {
            contentView.layer.borderWidth = 0
        }

        if day.activityCount > 0 {
            iconView.image = UIImage(named: "activity_icon")
            if day.activityCount > 1 {
                dayLabel.text = "+\(day.activityCount)"
            }
        } else {
            iconView.image = nil
        }
    }
}

