

import UIKit
import SnapKit

class HomeController: UIViewController {

    private lazy var topView: TopView = {
        let view = TopView()
        return view
    }()

    private lazy var noPracticeView: NoPracticeView = {
        let view = NoPracticeView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(topView)
        view.addSubview(noPracticeView)
    }

    private func setupConstraint() {
        topView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(184 * Constraint.yCoeff)
        }

        noPracticeView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110 * Constraint.yCoeff)
        }
    }


}
