

import UIKit
import SnapKit

class KmHourView: UIView {

    private lazy var mainBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.makeRoundCorners(16)
        view.backgroundColor = .blackTextColor
        return view
    }()

    private lazy var averageSpeedLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Your average speed "
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 16)
        view.textAlignment = .left
        return view
    }()

    lazy var distanceLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "0.5"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 24)
        view.textAlignment = .left
        return view
    }()

    lazy var kmOrMilesHourLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "km/h"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 24)
        view.textAlignment = .left
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
        addSubview(mainBackgroundView)
        addSubview(averageSpeedLabel)
        addSubview(distanceLabel)
        addSubview(kmOrMilesHourLabel)
    }

    private func setupConstraint() {
        mainBackgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        averageSpeedLabel.snp.remakeConstraints { make in
            make.top.equalTo(mainBackgroundView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(mainBackgroundView.snp.leading).offset(16 * Constraint.yCoeff)
        }

        distanceLabel.snp.remakeConstraints { make in
            make.top.equalTo(averageSpeedLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(mainBackgroundView.snp.leading).offset(16 * Constraint.yCoeff)
        }

        kmOrMilesHourLabel.snp.remakeConstraints { make in
            make.top.equalTo(averageSpeedLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(distanceLabel.snp.trailing)
        }
    }
}
