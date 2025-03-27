


import UIKit
import SnapKit

class NoPracticeView: UIView {

    private lazy var noPracticeViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayColorBackgroundColor
        view.makeRoundCorners(32)
        return view
    }()

    private lazy var noPracticeTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "There was no practice that day"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var noPracticeInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Write down your workout data"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 12)
        view.textAlignment = .center
        return view
    }()

    private lazy var addTrainingButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Add training data", for: .normal)
        view.setTitleColor(UIColor.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 11)
        view.makeRoundCorners(12)
        view.backgroundColor = .blueColor
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
        addSubview(noPracticeViewBackground)
        addSubview(noPracticeTitle)
        addSubview(noPracticeInfo)
        addSubview(addTrainingButton)
    }

    private func setupConstraint() {
        noPracticeViewBackground.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(106 * Constraint.yCoeff)
            make.width.equalTo(270 * Constraint.xCoeff)
        }

        noPracticeTitle.snp.remakeConstraints { make in
            make.centerX.equalTo(noPracticeViewBackground)
            make.top.equalTo(noPracticeViewBackground.snp.top).offset(13.5 * Constraint.yCoeff)
        }

        noPracticeInfo.snp.remakeConstraints { make in
            make.centerX.equalTo(noPracticeViewBackground)
            make.top.equalTo(noPracticeTitle.snp.bottom).offset(4 * Constraint.yCoeff)
        }

        addTrainingButton.snp.remakeConstraints { make in
            make.centerX.equalTo(noPracticeViewBackground)
            make.bottom.equalTo(noPracticeViewBackground.snp.bottom).offset(-13.5 * Constraint.yCoeff)
            make.height.equalTo(32 * Constraint.yCoeff)
            make.width.equalTo(129 * Constraint.xCoeff)
        }
    }
}
