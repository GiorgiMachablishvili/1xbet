

import UIKit
import SnapKit

class HomeController: UIViewController {

    private var workoutsHistory: [WorkoutHistory] = [
        .init(workoutTitle: "Treadmill", workoutImage: "treadmill", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Running outside", workoutImage: "run", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm")
    ]

    private lazy var noPracticeView: NoPracticeView = {
        let view = NoPracticeView()
        view.didPressAddTrainingButton = { [weak self] in
            self?.navigateToScannerManual()
        }
        view.isHidden = true
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
        collectionView.register(WorkoutHistoryHeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WorkoutHistoryHeaderView"
        )
        return collectionView
    }()


    private lazy var topView: TopView = {
        let view = TopView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
        view.bringSubviewToFront(noPracticeView)
        hideOrNotNoPracticeView()

    }

    private func setup() {
        view.addSubview(noPracticeView)
        view.addSubview(topView)
        view.addSubview(collectionView)
    }

    private func setupConstraint() {
        topView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(184 * Constraint.yCoeff)
        }

        noPracticeView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(500 * Constraint.yCoeff)
        }

//        noPracticeView.snp.makeConstraints { make in
//            make.edges.equalToSuperview() // full screen
//        }

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    func hideOrNotNoPracticeView() {
        if workoutsHistory.count == 0 {
            noPracticeView.isHidden = false
        } else {
            noPracticeView.isHidden = true
        }
    }

    private func navigateToScannerManual() {
        let scannerManualVC = ScannerManualController()
        navigationController?.pushViewController(scannerManualVC, animated: true)
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutsHistory.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: workoutsHistory[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WorkoutHistoryHeaderView", for: indexPath) as? WorkoutHistoryHeaderView else {
                return UICollectionReusableView()
            }
            header.configure(with: workoutsHistory.count)
            header.didTapPlusButton = { [weak self] in
                self?.navigateToScannerManual()
            }
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }

}
