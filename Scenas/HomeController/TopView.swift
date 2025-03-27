

import UIKit
import SnapKit

class TopView: UIView {

    private var days: [DayModel] = []

    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 60, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var currentDayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = getCurrentMonthDay()
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .left
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()

        generateDates()
        scrollToToday()
    }

    private func setup() {
        addSubview(currentDayLabel)
        addSubview(calendarCollectionView)
    }

    private func setupConstraint() {
        currentDayLabel.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(snp.leading).offset(10 * Constraint.xCoeff)
        }

        calendarCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(currentDayLabel.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80 * Constraint.yCoeff)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getCurrentMonthDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date())
    }


    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "E"

        for offset in -5...5 {
            if let date = calendar.date(byAdding: .day, value: offset, to: today) {
                let isToday = calendar.isDateInToday(date)
                let model = DayModel(
                    dayNumber: dateFormatter.string(from: date),
                    weekdayShort: dayFormatter.string(from: date),
                    isToday: isToday
                )
                days.append(model)
            }
        }
    }

    private func scrollToToday() {
        if let index = days.firstIndex(where: { $0.isToday }) {
            DispatchQueue.main.async {
                self.calendarCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
}

extension TopView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as? DayCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: days[indexPath.item])
        return cell
    }
}
