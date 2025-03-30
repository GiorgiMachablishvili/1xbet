

import UIKit
import SnapKit

class SupportCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .blackTextColor
        return view
    }()

    private lazy var buttonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteColor
        label.font = UIFont.funnelDesplayMedium(size: 14)
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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
        addSubview(containerView)
        containerView.addSubview(buttonNameLabel)
        containerView.addSubview(iconImageView)
    }

    private func setupConstraints() {
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        buttonNameLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(16 * Constraint.xCoeff)
        }

        iconImageView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(containerView.snp.trailing).offset(-16 * Constraint.xCoeff)
            make.height.width.equalTo(16 * Constraint.yCoeff)
        }
    }

    func configure(with data: SupportButtonStatModel) {
        buttonNameLabel.text = data.name
        iconImageView.image = UIImage(named: "\(data.image)")
    }
}
