

import UIKit
import SnapKit

class CurrentWorkoutHistoryHeaderView: UICollectionReusableView {

    var didTapPlusButton: (() -> Void)?

    static let reuseIdentifier = "CurrentWorkoutHistoryHeaderView"

    private let cellView = CurrentWorkoutHistoryCell()

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
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(plusButton)
    }

    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(snp.leading).offset(10 * Constraint.xCoeff)

        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }

        plusButton.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.width.equalTo(32 * Constraint.yCoeff)
        }
    }

    @objc func pressPlusButton() {
        didTapPlusButton?()
    }

    func configure(with model: ExerciseStatModel) {
        cellView.configure(with: model)
    }
}
