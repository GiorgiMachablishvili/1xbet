

import UIKit
import SnapKit

class ErrorSendingCell: UICollectionViewCell {
    private lazy var errorBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .grayColorBackgroundColor
        view.makeRoundCorners(16)
        return view
    }()

    private lazy var questionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Did you find an error? Please let us know "
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var errorTextFiled: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Tell us about the error"
        view.backgroundColor = .mainViewsBackgroundYellow
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 11)
        view.textAlignment = .left
        return view
    }()

    private lazy var sendButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Send", for: .normal)
        view.contentMode = .scaleAspectFit
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 16)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(30)
        view.addTarget(self, action: #selector(pressSendButton), for: .touchUpInside)
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
        addSubview(errorBackgroundView)
        addSubview(questionLabel)
        addSubview(errorTextFiled)
        addSubview(sendButton)
    }

    private func setupConstraint() {
        errorBackgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        questionLabel.snp.remakeConstraints { make in
            make.top.equalTo(errorBackgroundView.snp.top).offset(16 * Constraint.yCoeff)
            make.leading.equalTo(errorBackgroundView.snp.leading).offset(16 * Constraint.xCoeff)
        }

        errorTextFiled.snp.remakeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(errorBackgroundView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(32 * Constraint.yCoeff)
        }

        sendButton.snp.remakeConstraints { make in
            make.top.equalTo(errorTextFiled.snp.bottom).offset(30 * Constraint.yCoeff)
            make.centerX.equalTo(errorBackgroundView)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(182 * Constraint.yCoeff)
        }
    }

    @objc func pressSendButton() {

    }
}
