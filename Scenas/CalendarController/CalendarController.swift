

import UIKit
import SnapKit

class CalendarController: UIViewController {

    private var months: [CalendarMonth] = []

    private lazy var calendarLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Calendar"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 80)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.identifier)
        view.register(MonthHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: MonthHeaderView.identifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()

        generateCalendarData()
    }
    
    private func setup() {
        view.addSubview(calendarLabel)
        view.addSubview(calendarCollectionView)
    }

    private func setupConstraint() {
        calendarLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
        }

        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(calendarLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func generateCalendarData() {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month], from: today)
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"

        for monthOffset in -1...1 {
            guard let monthDate = calendar.date(byAdding: .month, value: monthOffset, to: today),
                  let range = calendar.range(of: .day, in: .month, for: monthDate),
                  let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: monthDate)) else { continue }

            var days: [CalendarDay] = []

            let weekdayOffset = (calendar.component(.weekday, from: firstOfMonth) + 5) % 7
            for _ in 0..<weekdayOffset {
                days.append(CalendarDay(date: Date(), isToday: false, activityCount: 0)) // Empty placeholders
            }

            for day in range {
                if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                    let isToday = calendar.isDateInToday(date)
                    let activityCount = [0, 1, 2, 3, 0, 0, 5].randomElement()! // mock
                    days.append(CalendarDay(date: date, isToday: isToday, activityCount: activityCount))
                }
            }

            let title = formatter.string(from: monthDate)
            months.append(CalendarMonth(title: title, days: days))
        }
    }
}

extension CalendarController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months[section].days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = months[indexPath.section].days[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as! CalendarDayCell
        cell.configure(with: day)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MonthHeaderView.identifier, for: indexPath) as! MonthHeaderView
        header.configure(with: months[indexPath.section].title)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 12 * 6) / 7 // 7 days + 6 gaps
        return CGSize(width: width, height: width)
    }
}

