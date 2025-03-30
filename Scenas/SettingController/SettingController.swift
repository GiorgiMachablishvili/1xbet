

import UIKit
import SnapKit

class SettingController: UIViewController {

    private var selectedIndex: Int = 0

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        return view
    }()

    private var exerciseOptions: [ExerciseStatModel] = [
        .init(workoutName: "Treadmill", workoutIconName: "treadmill", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Swimming", workoutIconName: "swimming", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Exercise bike", workoutIconName: "bike", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Running outside", workoutIconName: "run", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Ski walking", workoutIconName: "ski", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Walking", workoutIconName: "walk", distance: "658.83", activityCount: "14")
    ]

    private var supportButtons: [SupportButtonStatModel] = [
        .init(name: "Terms of Use", image: "plus"),
        .init(name: "Privacy Policy", image: "plus"),
        .init(name: "Support", image: "plus"),
        .init(name: "Rate US", image: "plus")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()

        setupHierarchy()
        configureCompositionLayout()
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
        collectionView.register(TopViewCell.self, forCellWithReuseIdentifier: String(describing: TopViewCell.self))
        collectionView.register(ExerciseStatisticsCell.self, forCellWithReuseIdentifier: String(describing: ExerciseStatisticsCell.self))
        collectionView.register(SupportCell.self, forCellWithReuseIdentifier: String(describing: SupportCell.self))
        collectionView.register(ErrorSendingCell.self, forCellWithReuseIdentifier: String(describing: ErrorSendingCell.self))
    }
}

//MARK: ProfileView configure layout
extension SettingController {
    func configureCompositionLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in

            switch sectionIndex {
            case 0:
                return self?.topViewLayout()
            case 1:
                return self?.exerciseStatisticsViewLayout()
            case 2:
                return self?.supportViewLayout()
            case 3:
                return self?.errorViewLayout()
            default:
                return self?.defaultLayout()
            }
        }
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }

    func topViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(254 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(254 * Constraint.yCoeff)
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
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(120 * Constraint.yCoeff)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250 * Constraint.yCoeff)
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

    func supportViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50 * Constraint.yCoeff)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 10 * Constraint.yCoeff,
            leading: 10 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            trailing: 10 * Constraint.xCoeff
        )
        return section
    }

    func errorViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(90 * Constraint.yCoeff))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(90 * Constraint.yCoeff)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: 24 * Constraint.yCoeff,
            leading: 10 * Constraint.xCoeff,
            bottom: 30 * Constraint.yCoeff,
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


extension SettingController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return exerciseOptions.count
        case 2:
            return supportButtons.count
        case 3:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TopViewCell.self),
                for: indexPath) as? TopViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ExerciseStatisticsCell.self),
                for: indexPath) as? ExerciseStatisticsCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: exerciseOptions[indexPath.item], selected: indexPath.item == selectedIndex)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: SupportCell.self),
                for: indexPath) as? SupportCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: supportButtons[indexPath.item])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ErrorSendingCell.self),
                for: indexPath) as? ErrorSendingCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            selectedIndex = indexPath.item
            collectionView.reloadSections(IndexSet(integer: 1))

        case 2:
            let selectedSupportItem = supportButtons[indexPath.item]
            if selectedSupportItem.name == "Terms of Use" {
                print("pressed term button")
            }
            if selectedSupportItem.name == "Privacy Policy" {
                print("pressed policy button")
            }
            if selectedSupportItem.name == "Support" {
                print("pressed Support button")
            }
            if selectedSupportItem.name == "Rate US" {
                print("pressed Rate button")
            }

        default:
            break
        }
    }

}
