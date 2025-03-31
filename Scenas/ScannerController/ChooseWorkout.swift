

import UIKit
import SnapKit

class ChooseWorkout: UIView {

    private lazy var workoutBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayColorBackgroundColor
        view.makeRoundCorners(24)
        return view
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColorBackgroundColor
        view.makeRoundCorners(16)
        return view
    }()

    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "treadmill")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 14)
        view.text = "Treadmill"
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.text = getCurrentMonthDay()
        return view
    }()

    private lazy var rightArrowImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
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
        addSubview(workoutBackgroundView)
        addSubview(iconBackgroundView)
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(rightArrowImage)
    }

    private func setupConstraint() {
        workoutBackgroundView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
        }

        iconBackgroundView.snp.remakeConstraints { make in
            make.centerY.equalTo(workoutBackgroundView)
            make.leading.equalTo(workoutBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        iconImageView.snp.remakeConstraints { make in
            make.center.equalTo(iconBackgroundView)
            make.height.width.equalTo(20 * Constraint.yCoeff)
        }

        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(iconBackgroundView.snp.top).offset(2 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12 * Constraint.xCoeff)
        }

        dateLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-2 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12 * Constraint.xCoeff)
        }

        rightArrowImage.snp.remakeConstraints { make in
            make.top.equalTo(workoutBackgroundView.snp.top).offset(18 * Constraint.yCoeff)
            make.trailing.equalTo(workoutBackgroundView.snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.width.equalTo(16 * Constraint.yCoeff)
        }
    }

    private func getCurrentMonthDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date())
    }
}
