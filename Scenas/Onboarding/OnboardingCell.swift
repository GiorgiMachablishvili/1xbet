

import UIKit
import SnapKit

class OnBoardingCell: UICollectionViewCell {
    private lazy var mainImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "onboardScanedImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var blackView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow.withAlphaComponent(0.95)
        return view
    }()

    private lazy var onboardTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Fast and secure \n authorization"
        view.textColor = UIColor.whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var onboardInfo: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Authorize via Apple ID to save your progress, achievements and predictions. Fast, secure, no extra data."
        view.textColor = UIColor.whiteColor.withAlphaComponent(0.3)
        view.font = UIFont.funnelDesplayRegular(size: 14)
        view.textAlignment = .center
        view.numberOfLines = 3
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(mainImage)
        addSubview(blackView)
        addSubview(onboardTitle)
        addSubview(onboardInfo)
    }

    private func setupConstraint() {
        mainImage.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(64 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(5 * Constraint.xCoeff)
            make.bottom.equalTo(snp.bottom).offset(-74 * Constraint.yCoeff)
        }

        blackView.snp.remakeConstraints { make in
            make.top.equalTo(mainImage.snp.top).offset(413 * Constraint.yCoeff)
            make.leading.trailing.bottom.equalToSuperview()
        }

        onboardTitle.snp.remakeConstraints { make in
            make.top.equalTo(mainImage.snp.top).offset(540 * Constraint.yCoeff)
//            make.leading.trailing.equalToSuperview().inset(36 * Constraint.xCoeff)
            make.centerX.equalTo(mainImage.snp.centerX)
        }

        onboardInfo.snp.remakeConstraints { make in
            make.top.equalTo(onboardTitle.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(72 * Constraint.xCoeff)
        }
    }

    func configure(with data: OnboardingView) {
        mainImage.image = UIImage(named: data.image)
        onboardTitle.text = data.title
        onboardInfo.text = data.viewInfo
    }
}
