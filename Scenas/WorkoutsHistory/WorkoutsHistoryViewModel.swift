

import Foundation

class WorkoutsHistoryViewModel {

    var onNavigateToScannerManual: (() -> Void)?
    var onGoBack: (() -> Void)?


    func handlePlusButtonTap() {
        onNavigateToScannerManual?()
    }

    func handleBackButtonTap() {
        onGoBack?()
    }
}
