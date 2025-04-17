

import UIKit
import SnapKit

class WorkoutsHistoryController: UIViewController {

    var selectedWorkout: ExerciseStatModel?
    private let viewModel = WorkoutsHistoryViewModel()

    var selectedWorkoutTitle: String?
    var selectedWorkoutIconName: String?

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()
        setupHierarchy()
        configureCompositionLayout()
        bindViewModel()
    }

    func setup() {
        view.addSubview(collectionView)
    }

    func setupConstraint() {
        collectionView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupHierarchy() {
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: String(describing: TopCell.self))
        collectionView.register(CurrentWorkoutHistoryCell.self, forCellWithReuseIdentifier: String(describing: CurrentWorkoutHistoryCell.self))
    }

    private func bindViewModel() {
        viewModel.onNavigateToScannerManual = { [weak self] in
            let scannerManualVC = ScannerManualController()
            self?.navigationController?.pushViewController(scannerManualVC, animated: true)
        }

        viewModel.onGoBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

//    private func navigateToScannerManual() {
//        let scannerManualVC = ScannerManualController()
//        navigationController?.pushViewController(scannerManualVC, animated: true)
//    }
//
//    private func goBackPage() {
//        navigationController?.popViewController(animated: true)
//    }
}

//MARK: ProfileView configure layout
extension WorkoutsHistoryController {
    func configureCompositionLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in

            switch sectionIndex {
            case 0:
                return self?.topViewLayout()
            case 1:
                return self?.exerciseStatisticsViewLayout()
            default:
                return self?.defaultLayout()
            }
        }
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }

    func topViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(155 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(155 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 0 * Constraint.yCoeff,
            leading: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            trailing: 0 * Constraint.xCoeff
        )
        return section
    }

    func exerciseStatisticsViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(76 * Constraint.yCoeff)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(76 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = .init(
            top: 16 * Constraint.yCoeff,
            leading: 10 * Constraint.xCoeff,
            bottom: 16 * Constraint.yCoeff,
            trailing: 10 * Constraint.xCoeff
        )
        return section
    }

    func defaultLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .absolute(200 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }
}


extension WorkoutsHistoryController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TopCell.self),
                for: indexPath) as? TopCell else {
                return UICollectionViewCell()
            }

            cell.workoutTitle.text = selectedWorkout?.workoutName ?? "Workout"

            cell.didPressBackButton = { [weak self] in
                self?.viewModel.handleBackButtonTap()
            }

            cell.didTapPlusButton = { [weak self] in
                self?.viewModel.handlePlusButtonTap()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CurrentWorkoutHistoryCell.self),
                for: indexPath) as? CurrentWorkoutHistoryCell else {
                return UICollectionViewCell()
            }
            if let selectedWorkout = selectedWorkout {
                cell.configure(with: selectedWorkout)
            }
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}
