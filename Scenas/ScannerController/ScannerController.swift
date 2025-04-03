

import UIKit
import SnapKit
import Vision
import CoreImage
import AVFoundation
import Vision


class ScannerController: UIViewController {

//    private lazy var backButton: UIButton = {
//        let view = UIButton(frame: .zero)
//        view.setImage(UIImage(named: "backButton"), for: .normal)
//        view.contentMode = .scaleAspectFit
//        return view
//    }()

    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoOutput = AVCaptureVideoDataOutput()
    private var visionRequest: VNRequest?


    private lazy var manualInputButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Manual input", for: .normal)
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
        view.addTarget(self, action: #selector(pressManualButton), for: .touchUpInside)
        return view
    }()

    private lazy var scannerPreviewImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .black.withAlphaComponent(0.1)
        view.isHidden = true
        return view
    }()

    private lazy var scannerImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "scanner")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()

    private lazy var currentDayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Align the machine's screen within the frame so that the numbers and letters are clearly visible, then tap 'Scan'."
        view.textColor = .whiteColor
        view.font = UIFont.funnelDesplayMedium(size: 13)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var scanButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Scan", for: .normal)
        view.setTitleColor(.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 13)
        if let originalImage = UIImage(named: "scanner") {
            let resizedImage = originalImage.resize(to: CGSize(width: 20, height: 20))
            view.setImage(resizedImage, for: .normal)
        }
        view.semanticContentAttribute = .forceLeftToRight
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(30)
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(pressScanButton), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()

        setupLiveCamera()

    }

    private func setup() {
//        view.addSubview(backButton)
        view.addSubview(manualInputButton)
        view.addSubview(scannerPreviewImageView)
        view.addSubview(scannerImage)
        view.addSubview(currentDayLabel)
        view.addSubview(scanButton)
//        view.addSubview(scannerManualView)
    }

    private func setupConstraint() {
//        backButton.snp.remakeConstraints { make in
//            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
//            make.leading.equalTo(view.snp.leading).offset(10 * Constraint.xCoeff)
//            make.height.width.equalTo(44 * Constraint.yCoeff)
//        }
        
        manualInputButton.snp.remakeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60 * Constraint.yCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(-10 * Constraint.xCoeff)
            make.height.equalTo(44 * Constraint.yCoeff)
            make.width.equalTo(136 * Constraint.xCoeff)
        }

        scannerPreviewImageView.snp.remakeConstraints { make in
            make.top.equalTo(manualInputButton.snp.bottom).offset(32 * Constraint.yCoeff)
            make.centerX.equalToSuperview()
            make.height.equalTo(376 * Constraint.yCoeff)
            make.width.equalTo(370 * Constraint.xCoeff)
        }

        scannerImage.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scanButton.snp.top).offset(-110 * Constraint.yCoeff)
            make.height.width.equalTo(60 * Constraint.yCoeff)
        }
        
        currentDayLabel.snp.remakeConstraints { make in
            make.top.equalTo(scannerImage.snp.bottom).offset(16 * Constraint.yCoeff)
            make.leading.trailing.equalTo(10 * Constraint.xCoeff)
        }
        
        scanButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-44 * Constraint.yCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(182 * Constraint.xCoeff)
        }
    }

    @objc private func pressManualButton() {
        let ScannerManualVC = ScannerManualController()
        navigationController?.pushViewController(ScannerManualVC, animated: true)
    }

//    @objc private func pressScanButton() {
//        // Mock scanned image
//        scannerPreviewImageView.image = UIImage(named: "mockTreadmillDisplay")
//        scannerPreviewImageView.isHidden = false
//
//        // Simulated scanned values (these would come from OCR in real app)
//        let scannedHours = 1
//        let scannedMinutes = 23
//        let scannedSeconds = 45
//        let scannedDistance = 5.6
//
//        let manualVC = ScannerManualController()
//
//        manualVC.setScannedTimeAndDistance(hours: scannedHours, minutes: scannedMinutes, seconds: scannedSeconds, distance: scannedDistance)
//        navigationController?.pushViewController(manualVC, animated: true)
//    }

    private func setupLiveCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .high

        guard let videoDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession?.canAddInput(videoInput) == true else {
            print("Cannot access camera")
            return
        }

        captureSession?.addInput(videoInput)

        // Add output
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession?.addOutput(videoOutput)

        // Set up preview
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = CGRect(x: 0, y: 160, width: view.bounds.width, height: 400) // adjust as needed
        if let layer = previewLayer {
            view.layer.insertSublayer(layer, at: 0) // behind everything
        }

        captureSession?.startRunning()
    }


    private var hasScanned = false

    @objc private func pressScanButton() {
        hasScanned = false // reset scanning state when user taps "Scan"
        print("Live camera scan started")
    }


//    @objc private func pressScanButton() {
//        presentImagePicker() // simulate picking treadmill screen
//    }


    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }


}


extension ScannerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        if let selectedImage = info[.originalImage] as? UIImage {
            scannerPreviewImageView.image = selectedImage
            scannerPreviewImageView.isHidden = false
            performOCR(on: selectedImage)
        }
    }

    private func performOCR(on image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            guard let self = self else { return }
            guard error == nil else {
                print("OCR error: \(error!)")
                return
            }

            if let results = request.results as? [VNRecognizedTextObservation] {
                var detectedText = ""
                for observation in results {
                    guard let candidate = observation.topCandidates(1).first else { continue }
                    detectedText += candidate.string + "\n"
                }

                print("Detected text:\n\(detectedText)")
                self.parseScannedText(detectedText)
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        DispatchQueue.global(qos: .userInitiated).async {
            try? requestHandler.perform([request])
        }
    }

    private func parseScannedText(_ text: String) {
        // ✅ Prevent multiple pushes
        guard !hasScanned else { return }

        let timePattern = #"(\d{1,2}):(\d{2}):(\d{2})"#
        let distancePattern = #"(Distance|Dist):\s*([\d.]+)"#

        var hours = 0, minutes = 0, seconds = 0
        var distance: Double = 0.0

        if let timeMatch = text.range(of: timePattern, options: .regularExpression) {
            let timeString = String(text[timeMatch])
            let parts = timeString.split(separator: ":").compactMap { Int($0) }
            if parts.count == 3 {
                hours = parts[0]
                minutes = parts[1]
                seconds = parts[2]
            }
        }

        if let distanceMatch = text.range(of: distancePattern, options: .regularExpression) {
            let matchText = String(text[distanceMatch])
            if let value = Double(matchText.components(separatedBy: CharacterSet(charactersIn: ": ")).last ?? "") {
                distance = value
            }
        }

        // Make sure some value was detected
        guard hours > 0 || minutes > 0 || seconds > 0 || distance > 0 else { return }

        hasScanned = true // ✅ prevent future scans

        DispatchQueue.main.async {
            let manualVC = ScannerManualController()
            manualVC.setScannedTimeAndDistance(hours: hours, minutes: minutes, seconds: seconds, distance: distance)
            self.navigationController?.pushViewController(manualVC, animated: true)
        }
    }


//    private func parseScannedText(_ text: String) {
//        // Example text: "01:23:45 Distance: 5.6"
//
//        var hasScanned = false
//
//        let timePattern = #"(\d{1,2}):(\d{2}):(\d{2})"#
//        let distancePattern = #"(Distance|Dist):\s*([\d.]+)"#
//
//        var hours = 0, minutes = 0, seconds = 0
//        var distance: Double = 0.0
//
//        if let timeMatch = text.range(of: timePattern, options: .regularExpression) {
//            let timeString = String(text[timeMatch])
//            let parts = timeString.split(separator: ":").compactMap { Int($0) }
//            if parts.count == 3 {
//                hours = parts[0]
//                minutes = parts[1]
//                seconds = parts[2]
//            }
//        }
//
//        if let distanceMatch = text.range(of: distancePattern, options: .regularExpression) {
//            let matchText = String(text[distanceMatch])
//            if let value = Double(matchText.components(separatedBy: CharacterSet(charactersIn: ": ")).last ?? "") {
//                distance = value
//            }
//        }
//
//        DispatchQueue.main.async {
//            let manualVC = ScannerManualController()
//            manualVC.setScannedTimeAndDistance(hours: hours, minutes: minutes, seconds: seconds, distance: distance)
//            self.navigationController?.pushViewController(manualVC, animated: true)
//        }
//    }
}


extension ScannerController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            guard let self = self else { return }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            let texts = observations.compactMap { $0.topCandidates(1).first?.string }
            let combinedText = texts.joined(separator: "\n")

            DispatchQueue.main.async {
                print("Live OCR Output:\n\(combinedText)")
                self.parseScannedText(combinedText) // your function to extract hour/min/sec/distance
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? requestHandler.perform([request])
    }
}
