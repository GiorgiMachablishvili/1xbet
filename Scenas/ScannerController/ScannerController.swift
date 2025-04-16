

import UIKit
import SnapKit
import Vision
import CoreImage
import AVFoundation
import Vision


class ScannerController: UIViewController {

    private var photoOutput = AVCapturePhotoOutput()
    private var hasScanned = false

    private var scannedHours: Int?
    private var scannedMinutes: Int?
    private var scannedSeconds: Int?
    private var scannedDistance: Double?
    private var capturedImage: UIImage?

    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoOutput = AVCaptureVideoDataOutput()
    private var visionRequest: VNRequest?


    //    private lazy var backButton: UIButton = {
    //        let view = UIButton(frame: .zero)
    //        view.setImage(UIImage(named: "backButton"), for: .normal)
    //        view.contentMode = .scaleAspectFit
    //        return view
    //    }()

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

    private lazy var scanAgainButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Scan again", for: .normal)
        view.setTitleColor(.whiteColor, for: .normal)
        view.titleLabel?.font = UIFont.funnelDesplayMedium(size: 13)
        view.backgroundColor = .blueColor
        view.makeRoundCorners(26)
        view.isHidden = true
        view.addTarget(self, action: #selector(pressScanAgainButton), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupConstraint()

        setupLiveCamera()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = scannerPreviewImageView.bounds
    }


    private func setup() {
        //        view.addSubview(backButton)
        view.addSubview(manualInputButton)
        view.addSubview(scannerPreviewImageView)
        view.addSubview(scannerImage)
        view.addSubview(currentDayLabel)
        view.addSubview(scanButton)
        view.addSubview(scanAgainButton)
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

        scanAgainButton.snp.remakeConstraints { make in
            make.top.equalTo(scanButton.snp.top)
            make.leading.equalTo(scanButton.snp.trailing).offset(10 * Constraint.xCoeff)
            make.trailing.equalTo(view.snp.trailing).offset(-10 * Constraint.xCoeff)
            make.bottom.equalTo(scanButton.snp.bottom)
        }
    }

    @objc private func pressManualButton() {
        let ScannerManualVC = ScannerManualController()
        navigationController?.pushViewController(ScannerManualVC, animated: true)
    }

    private func setupLiveCamera() {
        captureSession = AVCaptureSession()

        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            print("⚠️ No camera device found")
            return
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            if captureSession?.canAddInput(videoInput) == true {
                captureSession?.addInput(videoInput)
            }
        } catch {
            print("❌ Error setting up camera input: \(error)")
            return
        }

        // ✅ Add video output for live OCR
        if captureSession?.canAddOutput(videoOutput) == true {
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession?.addOutput(videoOutput)
        }

        // ✅ Add photo output for snapshot on "Scan"
        if captureSession?.canAddOutput(photoOutput) == true {
            captureSession?.addOutput(photoOutput)
        }

        // ✅ Configure preview layer to show camera feed
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill

        DispatchQueue.main.async {
            self.previewLayer?.frame = self.scannerPreviewImageView.bounds
            self.scannerPreviewImageView.layer.insertSublayer(self.previewLayer!, at: 0)
            self.scannerPreviewImageView.isHidden = false
        }

        // ✅ Start session on background thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
    }


    @objc private func pressScanButton() {
        if scanButton.title(for: .normal) == "Go next" {
            guard let image = capturedImage else {
                print("⚠️ No captured image available.")
                return
            }
            // Re-run OCR and handle result in callback
            extractDataFromImage(image)

        } else {
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .off
            photoOutput.capturePhoto(with: settings, delegate: self)
            scanAgainButton.isHidden = false
        }
    }

    private func extractDataFromImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self else { return }
            guard error == nil else {
                print("❌ OCR Error: \(error!)")
                return
            }

            let texts = (request.results as? [VNRecognizedTextObservation])?
                .compactMap { $0.topCandidates(1).first?.string } ?? []

            print("📸 OCR Extracted Texts:\n\(texts.joined(separator: ", "))")

            // Find time and distance from OCR
            let timeText = texts.first(where: { $0.contains(":") })
            let distanceText = texts.first(where: { $0.contains(".") && Double($0) != nil })

            // Fallback values
            var hours = 0, minutes = 0, seconds = 0
            let distance = Double(distanceText ?? "0") ?? 0.0

            if let time = timeText {
                let timeParts = time.split(separator: ":").compactMap { Int($0) }
                if timeParts.count == 3 {
                    hours = timeParts[0]
                    minutes = timeParts[1]
                    seconds = timeParts[2]
                } else if timeParts.count == 2 {
                    minutes = timeParts[0]
                    seconds = timeParts[1]
                }
            }

            DispatchQueue.main.async {
                print("✅ FINAL RESULT:")
                print("Time → h:\(hours), m:\(minutes), s:\(seconds)")
                print("Distance → \(distance)")

                self.scannedHours = hours
                self.scannedMinutes = minutes
                self.scannedSeconds = seconds
                self.scannedDistance = distance

                let manualVC = ScannerManualController()
                manualVC.setScannedTimeAndDistance(
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds,
                    distance: distance
                )
                self.navigationController?.pushViewController(manualVC, animated: true)
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false

        DispatchQueue.global(qos: .userInitiated).async {
            try? requestHandler.perform([request])
        }
    }

    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    @objc private func pressScanAgainButton() {
        // Clear previous scan data
        scannedHours = nil
        scannedMinutes = nil
        scannedSeconds = nil
        scannedDistance = nil
        capturedImage = nil
        hasScanned = false

        // Clear the UI
        scannerPreviewImageView.image = nil
        scannerPreviewImageView.isHidden = true
        scanAgainButton.isHidden = true
        scanButton.setTitle("Scan", for: .normal)

        // Restart camera preview
        if let session = captureSession, !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }

            DispatchQueue.main.async {
                if let previewLayer = self.previewLayer {
                    self.scannerPreviewImageView.layer.insertSublayer(previewLayer, at: 0)
                    previewLayer.frame = self.scannerPreviewImageView.bounds
                    self.scannerPreviewImageView.isHidden = false
                }
            }
        }
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
                var allText = ""
                for observation in results {
                    guard let candidate = observation.topCandidates(1).first else { continue }
                    allText += candidate.string + "\n"
                }

                print("🔍 Extracted OCR Text:\n\(allText)")

                // Extract only time and distance patterns
                let matches = self.extractRelevantNumbers(from: allText)
                print("🧾 Filtered Numbers with ':' or '.':\n\(matches)")
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        DispatchQueue.global(qos: .userInitiated).async {
            try? requestHandler.perform([request])
        }
    }

    private func extractRelevantNumbers(from text: String) -> [String] {
        let pattern = #"(\d+:\d+|\d+\.\d+)"# // Matches "30:42" and "11.48"
        let regex = try? NSRegularExpression(pattern: pattern)
        let nsString = text as NSString
        let matches = regex?.matches(in: text, range: NSRange(text.startIndex..., in: text)) ?? []
        return matches.map { nsString.substring(with: $0.range) }
    }

    private func parseScannedText(_ text: String) {
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

        guard hours > 0 || minutes > 0 || seconds > 0 || distance > 0 else { return }

        hasScanned = true

        DispatchQueue.main.async {
            self.scannedHours = hours
            self.scannedMinutes = minutes
            self.scannedSeconds = seconds
            self.scannedDistance = distance

            print("✅ Detected:")
            print("Hours: \(hours)")
            print("Minutes: \(minutes)")
            print("Seconds: \(seconds)")
            print("Distance: \(distance)")

            self.scanButton.setTitle("Go next", for: .normal)
        }
    }
}

extension ScannerController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {

        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("❌ Failed to get image from photo capture")
            return
        }

        // ✅ Hide live preview and show snapshot
        DispatchQueue.main.async {
            self.previewLayer?.removeFromSuperlayer()
            self.scannerPreviewImageView.image = image
            self.scannerPreviewImageView.isHidden = false
            self.captureSession?.stopRunning() // optional: freeze session
            self.scanButton.setTitle("Go next", for: .normal)
            self.capturedImage = image
            // 🔍 Perform OCR on captured image
            self.performOCR(on: image)
        }
    }
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
                //                print("Live OCR Output:\n\(combinedText)")
                self.parseScannedText(combinedText) // your function to extract hour/min/sec/distance
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? requestHandler.perform([request])
    }
}
