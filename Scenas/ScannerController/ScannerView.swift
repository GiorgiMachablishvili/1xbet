

import UIKit
import SnapKit

class ScannerView: UIView {

    var didPressBackButton: (() -> Void)?

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backButton"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    private lazy var scanButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Scan", for: .normal)
        view.setTitleColor(.blackTextColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 13)
        if let originalImage = UIImage(named: "rightArrow") {
            let resizedImage = originalImage.resize(to: CGSize(width: 5, height: 12))
            view.setImage(resizedImage, for: .normal)
        }
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(22)
        view.contentMode = .scaleAspectFit

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
        addSubview(backButton)
        addSubview(scanButton)
    }

    private func setupConstraint() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(10 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        scanButton.snp.remakeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalTo(snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(84 * Constraint.xCoeff)
        }
    }

    @objc private func pressBackButton() {
        didPressBackButton?()
    }
}
