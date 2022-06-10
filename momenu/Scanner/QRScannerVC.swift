//
//  QRScannerVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/24/22.
//

import UIKit
import AVFoundation

class QRScannerVC: UIViewController {

    // MARK: - Properties
    lazy var captureSession = AVCaptureSession()
    lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer? = nil
    lazy var qrCodeFrameView: UIView? = nil
    lazy var promptStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemIndigo
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.layer.cornerRadius = 8
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowOffset.height = 3
        
        
        return stack
    }()
    lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Scan the code to see the menu."
        label.numberOfLines = 2
        label.textColor = UIColor(named: "textColor")
        
        return label
    }()
    lazy var isLightOn: Bool = false {
        didSet {
            // Depending on this value change the image of the flashlight button property.
            isLightOn ? flashLightButton.setImage(UIImage(systemName: "flashlight.on.fill"), for: .normal) : flashLightButton.setImage(UIImage(systemName: "flashlight.off.fill"), for: .normal)
            
            // Checking if user is on dark/light mode
            if traitCollection.userInterfaceStyle == .dark {
                // Dark mode
                flashLightButton.backgroundColor = isLightOn ? .darkGray : .secondarySystemBackground
            } else {
                // Light mode
                flashLightButton.backgroundColor = isLightOn ? .secondarySystemBackground : .darkGray
            }
            
        }
    }
    lazy var flashLightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "flashlight.off.fill"), for: .normal)
        button.addTarget(self, action: #selector(toggleTorch(_:)), for: .touchUpInside)
        
        let backgroundColor: UIColor
        if traitCollection.userInterfaceStyle == .dark { backgroundColor = .secondarySystemBackground } else { backgroundColor = .darkGray }
        button.backgroundColor = backgroundColor
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset.height = 3
        
        return button
    }()
    lazy var amountOfScans: Int = 0
    lazy var restaurant: Restaurant? = nil
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupQRCodeScanner()
        setupPrompt()
        setupFlashLightButton()
    }
    
    // MARK: - Methods
    private func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupPrompt() {
        // Add to view's hierarchy
        view.addSubview(promptStack)
        promptStack.addArrangedSubview(promptLabel)
        
        // Add constraints
        NSLayoutConstraint.activate([
            promptStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            promptStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            promptStack.heightAnchor.constraint(equalTo: promptLabel.heightAnchor, constant: 20),
            promptStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            promptLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupFlashLightButton() {
        // Add view's hierarchy
        view.addSubview(flashLightButton)
        
        // Add constraints
        NSLayoutConstraint.activate([
            flashLightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            flashLightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            flashLightButton.heightAnchor.constraint(equalTo: promptStack.heightAnchor, multiplier: 1),
            flashLightButton.widthAnchor.constraint(equalTo: flashLightButton.heightAnchor),
        ])
    }
    
    private func setupQRCodeScanner() {
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture
            captureSession.startRunning()
            
            // Initialize QR Code Frame to highlight the QR Code
            qrCodeFrameView = UIView()
            
            if let qrcodeFrameView = qrCodeFrameView {
                qrcodeFrameView.layer.borderColor = UIColor.systemYellow.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue anymore
            print(error)
            return
        }
    }
    
    @objc private func toggleTorch(_ button: UIButton) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        isLightOn.toggle()
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = isLightOn ? .on : .off
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}

// MARK: - AVCaptureMetadataDelegate
extension QRScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == .qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                amountOfScans += 1
                
                // Once the QR Code is detected this code will run with the stringValue
                if amountOfScans <= 1 {
                    
                    // This is to pass the restaurantID before the request method is called inside HomeVC
                    MomenuServicer.restaurantID = getRestaurantID(stringValue: metadataObj.stringValue)
                    
                    navigationController?.pushViewController(TabBarController(), animated: true)
                    
                    captureSession.stopRunning()
                }
                
                
            }
        }
    }
    
    private func getRestaurantID(stringValue: String?) -> String {
        return String(stringValue?.split(separator: " ").last ?? "")
    }
}
