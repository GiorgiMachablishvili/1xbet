

import UIKit

class TimeDigitTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.funnelDesplayMedium(size: 24)
        textColor = .whiteColor
        backgroundColor = .grayColorBackgroundColor
        textAlignment = .center
        keyboardType = .numberPad
        layer.cornerRadius = 16
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

