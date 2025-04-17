//
//  WorkoutsHistoryViewModel.swift
//  1xbet
//
//  Created by Gio's Mac on 16.04.25.
//

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
