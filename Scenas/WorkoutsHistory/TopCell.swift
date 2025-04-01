

import UIKit
import SnapKit

class TopCell: UICollectionViewCell {

    var didTapPlusButton: (() -> Void)?
    var didPressBackButton: (() -> Void)?

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backButton"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    lazy var workoutTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Running"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "History"
        view.font = UIFont.funnelDesplayBold(size: 16)
        view.textColor = .whiteColor
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "6 ACTIVITY"
        view.font = UIFont.funnelDesplayMedium(size: 12)
        view.textColor = .gray
        return view
    }()

    private lazy var plusButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "plus"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .blueColor
        view.makeRoundCorners(12)
        view.addTarget(self, action: #selector(pressPlusButton), for: .touchUpInside)
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
        addSubview(backButton)
        addSubview(workoutTitle)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(plusButton)
    }

    private func setupConstraint() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(40 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(10 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        workoutTitle.snp.remakeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()       
        }

        titleLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
        }

        subtitleLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(16 * Constraint.xCoeff)
        }

        plusButton.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(2 * Constraint.yCoeff)
            make.trailing.equalTo(snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.width.equalTo(32)
        }
    }

    @objc func pressBackButton() {
        didPressBackButton?()
    }

    @objc func pressPlusButton() {
        didTapPlusButton?()
    }
}
