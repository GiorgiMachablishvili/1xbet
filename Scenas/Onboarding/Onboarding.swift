

import UIKit
import SnapKit

class Onboarding: UIViewController {

    private var currentIndex = 0

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: "OnBoardingCell")
        return view
    }()

    private lazy var skipButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Skip", for: .normal)
        view.backgroundColor = UIColor(hexString: "#0D0F14")
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 16)
        view.tintColor = UIColor.whiteColor
        view.makeRoundCorners(30)
        view.addTarget(self, action: #selector(clickSkipButton), for: .touchUpInside)
        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = UIColor.blueColor
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 16)
        view.tintColor = UIColor.whiteColor
        view.makeRoundCorners(30)
        view.addTarget(self, action: #selector(clickNextButton), for: .touchUpInside)
        return view
    }()


    let onboardingView: [OnboardingView] = [
        OnboardingView(
            image: "onboardScanedImage",
            title: "Scanning",
            viewInfo: "Scan the interface of your exercise machine or fitness watch to quickly add data to the app"
        ),
        OnboardingView(
            image: "onboardHistoryImage",
            title: "Your training",
            viewInfo: "Save your workouts, track your progress, view stats"
        ),
        OnboardingView(
            image: "onboardCalendarImage",
            title: "Calendar",
            viewInfo: "View all your workouts and activities in one app"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(collectionView)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }

    private func setupConstraint() {
        collectionView.snp.remakeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(700 * Constraint.yCoeff)
        }

        skipButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(24 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(167 * Constraint.xCoeff)
        }

        nextButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80 * Constraint.yCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(-24 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(167 * Constraint.xCoeff)
        }
    }

    @objc private func clickSkipButton() {
        print("pressed skip button")
    }

    @objc private func clickNextButton() {
        if currentIndex < onboardingView.count - 1 {
            currentIndex += 1
            let indexPath = IndexPath(item: currentIndex, section: 0)

            // Temporarily disable paging to allow smooth scrolling
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.collectionView.isPagingEnabled = true
            }
        } else {
            // Navigate to your main app's TabController
            let tabBarController = TabController() // Make sure TabController is correctly initialized
            navigationController?.pushViewController(tabBarController, animated: true)
        }
        updateNextButtonTitle()
    }

    private func updateNextButtonTitle() {
        let isLastPage = currentIndex == onboardingView.count - 1
        nextButton.setTitle(isLastPage ? "Start" : "Next", for: .normal)
        skipButton.isHidden = isLastPage

        nextButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80 * Constraint.yCoeff)
            if isLastPage {
                make.leading.trailing.equalToSuperview().inset(104 * Constraint.xCoeff)
                make.height.equalTo(60 * Constraint.yCoeff)
                make.width.equalTo(182 * Constraint.xCoeff)
            } else {
                make.trailing.equalTo(view.snp.trailing).offset(-24 * Constraint.xCoeff)
                make.height.equalTo(60 * Constraint.yCoeff)
                make.width.equalTo(167 * Constraint.xCoeff)
            }
        }

        view.layoutIfNeeded()
    }
}

extension Onboarding: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingView.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as? OnBoardingCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: onboardingView[indexPath.item])
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = pageIndex
        updateNextButtonTitle()
    }
}
