

import UIKit
import SnapKit

class CurrentWorkoutHistoryCell: UICollectionViewCell {
    private lazy var cellBackgroundView: UIView = {
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

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 14)
        return view
    }()

    private lazy var distanceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.text = "23.2 km"
        return view
    }()

    private lazy var workoutDurationLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.text = "31m 23s"
        return view
    }()

    private lazy var workoutDateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.text = "12:08 PM"
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
        addSubview(cellBackgroundView)
        addSubview(iconBackgroundView)
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(distanceLabel)
        addSubview(workoutDurationLabel)
        addSubview(workoutDateLabel)
        addSubview(rightArrowImage)
    }

    private func setupConstraint() {
        cellBackgroundView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
        }

        iconBackgroundView.snp.remakeConstraints { make in
            make.centerY.equalTo(cellBackgroundView)
            make.leading.equalTo(cellBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
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

        distanceLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-2 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12 * Constraint.xCoeff)
        }

        workoutDurationLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-2 * Constraint.yCoeff)
            make.leading.equalTo(distanceLabel.snp.trailing).offset(16 * Constraint.xCoeff)
        }

        workoutDateLabel.snp.remakeConstraints { make in
            make.top.equalTo(cellBackgroundView.snp.top).offset(18 * Constraint.yCoeff)
            make.trailing.equalTo(cellBackgroundView.snp.trailing).offset(-36 * Constraint.xCoeff)
        }

        rightArrowImage.snp.remakeConstraints { make in
            make.centerY.equalTo(workoutDateLabel)
            make.leading.equalTo(workoutDateLabel.snp.trailing).offset(4 * Constraint.xCoeff)
            make.height.width.equalTo(16 * Constraint.yCoeff)
        }
    }

    func configure(with model: ExerciseStatModel) {
        titleLabel.text = model.workoutName
        iconImageView.image = UIImage(named: model.workoutIconName)
    }
}
