

import UIKit
import SnapKit

class WorkoutsView: UIView {

    var didPressCloseButton: (() -> Void)?
    var didSelectWorkout: ((ExerciseStatModel) -> Void)?

    private var workouts: [ExerciseStatModel] = [
        .init(workoutName: "Treadmill", workoutIconName: "treadmill", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Exercise bike", workoutIconName: "bike", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Running outside", workoutIconName: "run", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Ski walking", workoutIconName: "ski", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Swimming", workoutIconName: "swimming", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Walking", workoutIconName: "walk", distance: "658.83", activityCount: "14")
    ]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(WorkoutsCell.self, forCellWithReuseIdentifier: "WorkoutsCell")
        collection.backgroundColor = .clear
        return collection
    }()

    private lazy var viewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear.withAlphaComponent(0.6)
        return view
    }()

    private lazy var collectionViewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .mainViewsBackgroundYellow
        return view
    }()

    private lazy var closeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "close"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressCloseButton), for: .touchUpInside)
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
        addSubview(viewBackground)
        viewBackground.addSubview(collectionViewBackground)
        collectionViewBackground.addSubview(collectionView)
        collectionViewBackground.addSubview(closeButton)
    }

    private func setupConstraints() {
        viewBackground.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionViewBackground.snp.remakeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(422 * Constraint.yCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.trailing.equalTo(collectionViewBackground.snp.trailing).offset(-16 * Constraint.xCoeff)
            make.top.equalTo(collectionViewBackground.snp.top).offset(16 * Constraint.yCoeff)
            make.height.width.equalTo(36 * Constraint.yCoeff)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionViewBackground.snp.top).offset(56 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
            make.bottom.equalTo(collectionViewBackground.snp.bottom).offset(44 * Constraint.yCoeff)
        }
    }

    @objc func pressCloseButton() {
        didPressCloseButton?()
    }
}

extension WorkoutsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutsCell", for: indexPath) as? WorkoutsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: workouts[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 3  // 2 columns = 3 spacings (left + middle + right)
        let width = (collectionView.frame.width - totalSpacing) / 2
        return CGSize(width: width, height: 120 * Constraint.yCoeff)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedWorkout = workouts[indexPath.item]
            didSelectWorkout?(selectedWorkout) // ← trigger callback
        }
}

