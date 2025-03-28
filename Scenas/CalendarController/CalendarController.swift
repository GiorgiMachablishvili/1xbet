

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
        calendarCollectionView.reloadData()

        calendarCollectionView.performBatchUpdates(nil) { _ in
            self.scrollToToday()
        }
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
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"

        for monthOffset in -6...6 {
            guard let monthDate = calendar.date(byAdding: .month, value: monthOffset, to: today),
                  let range = calendar.range(of: .day, in: .month, for: monthDate),
                  let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: monthDate)) else { continue }

            var days: [CalendarDay] = []

            // 1️⃣ Prepend previous month's days
            let weekday = calendar.component(.weekday, from: firstOfMonth)
            let firstWeekday = calendar.firstWeekday + 1
            let weekdayOffset = (weekday - firstWeekday + 7) % 7

            if let previousMonth = calendar.date(byAdding: .month, value: -1, to: monthDate),
               let prevRange = calendar.range(of: .day, in: .month, for: previousMonth),
               let lastDayOfPrevMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: previousMonth))?.addingTimeInterval(60 * 60 * 24 * Double(prevRange.count - 1)) {

                for offset in stride(from: weekdayOffset, to: 0, by: -1) {
                    if let date = calendar.date(byAdding: .day, value: -offset, to: firstOfMonth) {
                        days.append(CalendarDay(date: date, isToday: calendar.isDateInToday(date), activityCount: 0, isCurrentMonth: false))
                    }
                }
            }

            // 2️⃣ Add current month’s days
            for day in range {
                if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                    let isToday = calendar.isDateInToday(date)
                    let activityCount = [0, 1, 2, 3, 0, 0, 5].randomElement()!
                    days.append(CalendarDay(date: date, isToday: isToday, activityCount: activityCount, isCurrentMonth: true))
                }
            }

            // 3️⃣ Append next month’s days to fill full weeks
            while days.count % 7 != 0 {
                if let lastDate = days.last?.date,
                   let nextDate = calendar.date(byAdding: .day, value: 1, to: lastDate) {
                    days.append(CalendarDay(date: nextDate, isToday: calendar.isDateInToday(nextDate), activityCount: 0, isCurrentMonth: false))
                }
            }

            let title = formatter.string(from: monthDate)
            months.append(CalendarMonth(title: title, days: days))
        }
    }

    private func scrollToToday() {
        let calendar = Calendar.current

        for (sectionIndex, month) in months.enumerated() {
            for (itemIndex, day) in month.days.enumerated() {
                if calendar.isDateInToday(day.date) {
                    let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                    calendarCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
                    return
                }
            }
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
        let width = collectionView.bounds.width / 7
        return CGSize(width: width, height: width)
    }
}

