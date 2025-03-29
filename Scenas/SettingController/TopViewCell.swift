

import UIKit
import SnapKit

class TopViewCell: UICollectionViewCell {
    private lazy var settingLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Setting"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var authorizeBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(16)
        return view
    }()

    private lazy var authorizeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Authorize"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var authorizeInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Save your workout data with authorization"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 11)
        view.textAlignment = .left
        return view
    }()

    private lazy var autorizationButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Go to authorization", for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 14)
        view.backgroundColor = .blackColor
        view.makeRoundCorners(12)
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
        addSubview(settingLabel)
        addSubview(authorizeBackgroundView)
        addSubview(authorizeLabel)
        addSubview(authorizeInfoLabel)
        addSubview(autorizationButton)
    }

    private func setupConstraint() {
        settingLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.top).offset(60 * Constraint.yCoeff)
        }

        authorizeBackgroundView.snp.remakeConstraints { make in
            make.top.equalTo(settingLabel.snp.bottom).offset(42 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
            make.height.equalTo(122 * Constraint.yCoeff)
        }

        authorizeLabel.snp.remakeConstraints { make in
            make.top.equalTo(authorizeBackgroundView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(authorizeBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
        }

        authorizeInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(authorizeLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.equalTo(authorizeBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
        }

        autorizationButton.snp.remakeConstraints { make in
            make.top.equalTo(authorizeInfoLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(42 * Constraint.yCoeff)
        }
    }
}

