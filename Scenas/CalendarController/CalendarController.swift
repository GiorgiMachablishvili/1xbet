

import UIKit
import SnapKit

class CalendarController: UIViewController {

    private lazy var calendarLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Calendar"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()

    }
    
    private func setup() {
        view.addSubview(calendarLabel)
    }

    private func setupConstraint() {
        calendarLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
        }
    }


}
