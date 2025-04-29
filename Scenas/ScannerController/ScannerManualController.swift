

import UIKit
import SnapKit

class ScannerManualController: UIViewController {

    private let viewModel = ScannerManualViewModel()
    var hour: Double = 0.0

    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "backButton"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return view
    }()

    private lazy var scanButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Scan", for: .normal)
        view.setTitleColor(.blackTextColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 13)
        if let originalImage = UIImage(named: "rightArrow") {
            let resizedImage = originalImage.resize(to: CGSize(width: 5, height: 12))
            view.setImage(resizedImage, for: .normal)
        }
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(22)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressScanButton), for: .touchUpInside)
        return view
    }()

    private lazy var chooseWorkoutView: ChooseWorkout = {
        let view = ChooseWorkout()
        return view
    }()

    private lazy var trainingDurationLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Training duration"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var hourFields = [TimeDigitTextField(), TimeDigitTextField()]
    private lazy var minuteFields = [TimeDigitTextField(), TimeDigitTextField()]
    private lazy var secondFields = [TimeDigitTextField(), TimeDigitTextField()]

    private lazy var timeStackView: UIStackView = {
        let hourStack = UIStackView(arrangedSubviews: hourFields)
        hourStack.axis = .horizontal
        hourStack.spacing = 8

        let minuteStack = UIStackView(arrangedSubviews: minuteFields)
        minuteStack.axis = .horizontal
        minuteStack.spacing = 8

        let secondStack = UIStackView(arrangedSubviews: secondFields)
        secondStack.axis = .horizontal
        secondStack.spacing = 8

        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.alignment = .center

        mainStack.addArrangedSubview(hourStack)
        mainStack.addArrangedSubview(makeUnitLabel("hour"))
        mainStack.addArrangedSubview(minuteStack)
        mainStack.addArrangedSubview(makeUnitLabel("min"))
        mainStack.addArrangedSubview(secondStack)
        mainStack.addArrangedSubview(makeUnitLabel("Sec"))

        return mainStack
    }()

    private lazy var distanceSuspendedLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Distance suspended"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 14)
        view.textAlignment = .left
        return view
    }()

    private lazy var kmButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Km", for: .normal)
        view.contentMode = .scaleAspectFit
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 11)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(8)
        view.addTarget(self, action: #selector(pressKmButton), for: .touchUpInside)
        return view
    }()

    private lazy var milesButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Miles", for: .normal)
        view.contentMode = .scaleAspectFit
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 11)
        view.makeRoundCorners(8)
        view.addTarget(self, action: #selector(pressMilesButton), for: .touchUpInside)
        return view
    }()

    //TODO: when I uncomment addTarget I cant enter scanner view.  fix it
    private lazy var workoutDistanceTextField: TimeDigitTextField = {
        let view = TimeDigitTextField()
        view.placeholder = "0"
        view.keyboardType = .numberPad
        view.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return view
    }()

    private lazy var kmOrMileLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Km"
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 16)
        view.textAlignment = .center
        return view
    }()

    private lazy var saveButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Save", for: .normal)
        view.contentMode = .scaleAspectFit
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 16)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(30)
        view.addTarget(self, action: #selector(pressSaveButton), for: .touchUpInside)
        return view
    }()

    private lazy var kmHourView: KmHourView = {
        let view = KmHourView()
        return view
    }()

    private lazy var workoutsView: WorkoutsView = {
        let view = WorkoutsView()
        view.didPressCloseButton = { [weak self] in
            self?.hideWorkoutView()
        }
        view.didSelectWorkout = { [weak self] selectedWorkout in
            self?.chooseWorkoutView.setWorkout(data: selectedWorkout)
            self?.hideWorkoutView()
        }
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainViewsBackgroundYellow

        setup()
        setupConstraint()

        updatePlaceHolder()
        tabGestureChooseWorkout()
        setupKeyboardDismissGesture()
    }

    private func setup() {
        view.addSubview(backButton)
        view.addSubview(scanButton)
        view.addSubview(chooseWorkoutView)
        view.addSubview(trainingDurationLabel)
        view.addSubview(timeStackView)
        view.addSubview(distanceSuspendedLabel)
        view.addSubview(kmButton)
        view.addSubview(milesButton)
        view.addSubview(workoutDistanceTextField)
        view.addSubview(kmOrMileLabel)
        view.addSubview(kmHourView)
        view.addSubview(saveButton)
        view.addSubview(workoutsView)
    }

    private func setupConstraint() {
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
            make.height.width.equalTo(44 * Constraint.yCoeff)
        }

        scanButton.snp.remakeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalTo(view.snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(84 * Constraint.xCoeff)
        }

        chooseWorkoutView.snp.remakeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(24 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(76 * Constraint.yCoeff)
        }

        trainingDurationLabel.snp.remakeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(144 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
        }

        timeStackView.snp.remakeConstraints { make in
            make.top.equalTo(trainingDurationLabel.snp.bottom).offset(10 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }

        (hourFields + minuteFields + secondFields).forEach { field in
            field.snp.makeConstraints { make in
                make.height.equalTo(48 * Constraint.yCoeff)
                make.width.equalTo(35 * Constraint.xCoeff)
            }
        }

        distanceSuspendedLabel.snp.remakeConstraints { make in
            make.top.equalTo(timeStackView.snp.bottom).offset(47 * Constraint.yCoeff)
            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
        }

        workoutsView.snp.remakeConstraints { make in
//            make.leading.bottom.trailing.equalToSuperview()
//            make.height.equalTo(422 * Constraint.yCoeff)
            make.edges.equalToSuperview()
        }

        kmButton.snp.remakeConstraints { make in
            make.centerY.equalTo(distanceSuspendedLabel)
            make.trailing.equalTo(milesButton.snp.leading).offset(-1 * Constraint.xCoeff)
            make.height.equalTo(24 * Constraint.yCoeff)
            make.width.equalTo(48 * Constraint.xCoeff)
        }

        milesButton.snp.remakeConstraints { make in
            make.centerY.equalTo(distanceSuspendedLabel)
            make.trailing.equalTo(view.snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.equalTo(24 * Constraint.yCoeff)
            make.width.equalTo(48 * Constraint.xCoeff)
        }

        workoutDistanceTextField.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(distanceSuspendedLabel.snp.bottom).offset(48 * Constraint.yCoeff)
            make.height.equalTo(48 * Constraint.yCoeff)
            make.width.equalTo(99 * Constraint.xCoeff)
        }

        kmOrMileLabel.snp.remakeConstraints { make in
            make.leading.equalTo(workoutDistanceTextField.snp.trailing).offset(8 * Constraint.yCoeff)
            make.bottom.equalTo(workoutDistanceTextField.snp.bottom)
        }

        kmHourView.snp.remakeConstraints { make in
            make.bottom.equalTo(saveButton.snp.top).offset(-44 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(10 * Constraint.xCoeff)
            make.height.equalTo(90 * Constraint.yCoeff)
        }

        saveButton.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(104 * Constraint.xCoeff)
            make.bottom.equalTo(view.snp.bottom).offset(-44 * Constraint.yCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }
    }

    func setScannedTimeAndDistance(hours: Int, minutes: Int, seconds: Int, distance: Double) {
        let hourTens = hours / 10
        let hourOnes = hours % 10
        let minTens = minutes / 10
        let minOnes = minutes % 10
        let secTens = seconds / 10
        let secOnes = seconds % 10

        hourFields[0].text = "\(hourTens)"
        hourFields[1].text = "\(hourOnes)"
        minuteFields[0].text = "\(minTens)"
        minuteFields[1].text = "\(minOnes)"
        secondFields[0].text = "\(secTens)"
        secondFields[1].text = "\(secOnes)"

        workoutDistanceTextField.text = "\(distance)"

        calculateAndDisplaySpeed()
    }

    private func makeUnitLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .whiteColor
        label.font = UIFont.funnelDesplayMedium(size: 12)
        return label
    }

    private func updatePlaceHolder() {
        (hourFields + minuteFields + secondFields).forEach {
            $0.placeholder = "0"
            $0.textAlignment = .center
            $0.textColor = .whiteColor
            $0.backgroundColor = .grayColorBackgroundColor
            $0.keyboardType = .numberPad
            $0.font = UIFont.funnelDesplayMedium(size: 16)
            $0.tintColor = .blueColor
            $0.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        }
    }

    @objc private func pressBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func pressKmButton() {
        viewModel.setUnit(.km)
        kmButton.backgroundColor = .blueColor
        milesButton.backgroundColor = .clear
        kmOrMileLabel.text = viewModel.getUnitLabel()
        kmHourView.kmOrMilesHourLabel.text = viewModel.getSpeedUnitLabel()
    }

    @objc private func pressMilesButton() {
        viewModel.setUnit(.miles)
        kmButton.backgroundColor = .clear
        milesButton.backgroundColor = .blueColor
        kmOrMileLabel.text = viewModel.getUnitLabel()
        kmHourView.kmOrMilesHourLabel.text = viewModel.getSpeedUnitLabel()
    }

    private func calculateAndDisplaySpeed() {
        let h1 = Int(hourFields[0].text ?? "0") ?? 0
        let h2 = Int(hourFields[1].text ?? "0") ?? 0
        let m1 = Int(minuteFields[0].text ?? "0") ?? 0
        let m2 = Int(minuteFields[1].text ?? "0") ?? 0
        let s1 = Int(secondFields[0].text ?? "0") ?? 0
        let s2 = Int(secondFields[1].text ?? "0") ?? 0

        let h = h1 * 10 + h2
        let m = m1 * 10 + m2
        let s = s1 * 10 + s2
        let d = Double(workoutDistanceTextField.text ?? "0") ?? 0

        viewModel.updateTime(hours: h, minutes: m, seconds: s)
        viewModel.updateDistance(d)
        kmHourView.distanceLabel.text = viewModel.speedString
    }

    private func tabGestureChooseWorkout() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChooseWorkout))
        chooseWorkoutView.isUserInteractionEnabled = true
        chooseWorkoutView.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapChooseWorkout() {
        workoutsView.isHidden = false
        print("pressed tab gesture")
    }

    func hideWorkoutView() {
        workoutsView.isHidden = true
    }

    @objc private func handleInputChange() {
        calculateAndDisplaySpeed()
    }

    @objc private func pressScanButton() {
        let scannerVC = ScannerController()
        navigationController?.pushViewController(scannerVC, animated: true)
    }

    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }


    //TODO: add func
    @objc private func pressSaveButton() {

    }
}

extension ChooseWorkout {
    func setWorkout(data: ExerciseStatModel) {
        iconImageView.image = UIImage(named: data.workoutIconName)?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = data.workoutName
    }
}
