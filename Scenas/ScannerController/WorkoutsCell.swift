

import UIKit
import SnapKit

class WorkoutsCell: UICollectionViewCell {
    private lazy var workoutBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayColorBackgroundColor
        view.makeRoundCorners(24)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 14)
        view.text = "Treadmill"
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
        view.tintColor = .whiteColor
        return view
    }()

    private lazy var distanceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.text = "658.83km"
        return view
    }()

    private lazy var activityLabel: UILabel = {
        let view = UILabel()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 11)
        view.text = "14 Activity"
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
        addSubview(titleLabel)
        addSubview(iconBackgroundView)
        addSubview(iconImageView)
        addSubview(distanceLabel)
        addSubview(activityLabel)
        addSubview(rightArrowImage)
    }

    private func setupConstraint() {
        workoutBackgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview().inset(16 * Constraint.yCoeff)
        }

        iconBackgroundView.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        iconImageView.snp.remakeConstraints { make in
            make.center.equalTo(iconBackgroundView)
            make.height.width.equalTo(20 * Constraint.yCoeff)
        }

        distanceLabel.snp.remakeConstraints { make in
            make.top.equalTo(iconBackgroundView.snp.top).offset(6 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(8 * Constraint.xCoeff)
        }

        activityLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-6 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(8 * Constraint.xCoeff)
        }

        rightArrowImage.snp.remakeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.width.equalTo(16 * Constraint.yCoeff)
        }
    }

    func configure(with data: ExerciseStatModel) {
        titleLabel.text = data.workoutName
        iconImageView.image = UIImage(named: "\(data.workoutIconName)")
        distanceLabel.text = "\(data.distance)km"
        activityLabel.text = "\(data.activityCount) Activity"

        iconImageView.image = UIImage(named: data.workoutIconName)?.withRenderingMode(.alwaysTemplate)
    }
}
