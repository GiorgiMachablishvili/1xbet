

import UIKit
import SnapKit

class AddExercisesTopCell: UICollectionViewCell {
    private lazy var myExercisesLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "My Exercises"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var addExerciseBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(16)
        return view
    }()

    private lazy var addExerciseLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Add an exercise ?"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var addExerciseInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Write what exercise you would like to see in our app and maybe we will add it "
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 11)
        view.textAlignment = .left
        view.numberOfLines = 2
        return view
    }()

    private lazy var errorTextFiled: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Write your exercise "
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
        view.backgroundColor = .mainViewsBackgroundYellow
        view.makeRoundCorners(16)
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
        addSubview(myExercisesLabel)
        addSubview(addExerciseBackgroundView)
        addSubview(addExerciseLabel)
        addSubview(addExerciseInfoLabel)
        addSubview(errorTextFiled)
        addSubview(sendButton)
    }

    private func setupConstraint() {
        myExercisesLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.top).offset(60 * Constraint.yCoeff)
        }

        addExerciseBackgroundView.snp.remakeConstraints { make in
            make.top.equalTo(myExercisesLabel.snp.bottom).offset(34 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
            make.height.equalTo(185 * Constraint.yCoeff)
        }

        addExerciseLabel.snp.remakeConstraints { make in
            make.top.leading.equalTo(addExerciseBackgroundView).inset(16 * Constraint.yCoeff)
        }

        addExerciseInfoLabel.snp.remakeConstraints { make in
            make.top.equalTo(addExerciseLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(addExerciseBackgroundView).inset(16 * Constraint.xCoeff)
        }

        errorTextFiled.snp.remakeConstraints { make in
            make.top.equalTo(addExerciseInfoLabel.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalTo(addExerciseBackgroundView).inset(16 * Constraint.xCoeff)
            make.height.equalTo(32 * Constraint.yCoeff)
        }

        sendButton.snp.remakeConstraints { make in
            make.top.equalTo(errorTextFiled.snp.bottom).offset(15 * Constraint.yCoeff)
            make.centerX.equalTo(addExerciseBackgroundView)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(182 * Constraint.yCoeff)
        }
    }

    @objc func pressSendButton() {

    }
}
