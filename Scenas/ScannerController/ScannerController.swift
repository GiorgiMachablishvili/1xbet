

import UIKit
import SnapKit

class ScannerController: UIViewController {

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backButton"), for: .normal)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var manualInputButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Manual input", for: .normal)
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
        view.addTarget(self, action: #selector(pressManualButton), for: .touchUpInside)
        return view
    }()

    private lazy var scannerImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "scanner")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()

    private lazy var currentDayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Align the machine's screen within the frame so that the numbers and letters are clearly visible, then tap 'Scan'."
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 13)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var scanButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Scan", for: .normal)
        view.setTitleColor(.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 13)
        if let originalImage = UIImage(named: "scanner") {
            let resizedImage = originalImage.resize(to: CGSize(width: 20, height: 20))
            view.setImage(resizedImage, for: .normal)
        }
        view.semanticContentAttribute = .forceLeftToRight
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(30)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var scannerView: ScannerView = {
        let view = ScannerView()
        view.didPressBackButton = { [weak self] in
            self?.hideScannerView()
        }
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(backButton)
        view.addSubview(manualInputButton)
        view.addSubview(scannerImage)
        view.addSubview(currentDayLabel)
        view.addSubview(scanButton)
        view.addSubview(scannerView)
    }

    private func setupConstraint() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        manualInputButton.snp.remakeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalTo(view.snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(136 * Constraint.xCoeff)
        }

        scannerImage.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scanButton.snp.top).offset(-110 * Constraint.yCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }

        currentDayLabel.snp.remakeConstraints { make in
            make.top.equalTo(scannerImage.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalTo(10 * Constraint.xCoeff)
        }

        scanButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-44 * Constraint.yCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(182 * Constraint.xCoeff)
        }

        scannerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func hideScannerView() {
        scannerView.isHidden = true
    }

    @objc private func pressManualButton() {
        scannerView.isHidden = false
    }

}
