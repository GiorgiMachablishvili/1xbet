

import UIKit
import SnapKit

class HomeController: UIViewController {

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

    private lazy var noPracticeView: NoPracticeView = {
        let view = NoPracticeView()
        view.isHidden = true
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
        view.addSubview(collectionView)
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

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24 * Constraint.yCoeff)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "WorkoutHistoryHeaderView",
                for: indexPath
            ) as! WorkoutHistoryHeaderView
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }

}
