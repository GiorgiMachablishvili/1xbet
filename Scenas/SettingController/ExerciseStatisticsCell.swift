

import UIKit
import SnapKit

class ExerciseStatisticsCell: UICollectionViewCell {
    static let identifier = "ExerciseOptionCell"

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .blackTextColor
        return view
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColorBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.font = UIFont.funnelDesplayMedium(size: 14)
        return label
    }()

    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.font = UIFont.funnelDesplayBold(size: 14)
        return label
    }()

    private lazy var activityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.funnelDesplayMedium(size: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(activityLabel)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(containerView.snp.leading).offset(16 * Constraint.xCoeff)
        }

        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(containerView.snp.leading).offset(16 * Constraint.xCoeff)
            make.width.height.equalTo(48 * Constraint.yCoeff)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24 * Constraint.yCoeff)
        }

        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(8 * Constraint.xCoeff)
        }

        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(2 * Constraint.yCoeff)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(8 * Constraint.xCoeff)
        }
    }

    func configure(with data: ExerciseStatModel, selected: Bool) {
        titleLabel.text = data.workoutName
        distanceLabel.text = "\(data.distance)km"
        activityLabel.text = "\(data.activityCount) Activity"
        iconImageView.image = UIImage(named: data.workoutIconName)

        containerView.backgroundColor = selected ? .blueColor : .blackTextColor
    }
}



//import UIKit
//import SnapKit
//
//class ExerciseStatisticsCell: UICollectionViewCell {
//    private lazy var exerciseLabel: UILabel = {
//        let view = UILabel(frame: .zero)
//        view.text = "Your exercise statistics"
//        view.textColor = .whiteColor
//        view.font = UIFont.funnelDesplayBold(size: 16)
//        view.textAlignment = .left
//        return view
//    }()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setup()
//        setupConstraint()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setup() {
//        addSubview(exerciseLabel)
//
//    }
//
//    private func setupConstraint() {
//        exerciseLabel.snp.remakeConstraints { make in
//            make.top.equalTo(snp.top).offset(5 * Constraint.yCoeff)
//            make.leading.equalTo(snp.leading).offset(10 * Constraint.xCoeff)
//        }
//    }
//}
