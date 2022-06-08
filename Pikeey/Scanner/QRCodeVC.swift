//
//  ViewController.swift
//  Pikeey
//
//  Created by Eric Morales on 5/23/22.
//

import UIKit

class QRCodeVC: UIViewController {

    // MARK: - Properties
    let textColor: UIColor = .white
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        
        return stack
    }()
    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "momenu."
        label.textColor = textColor
        
        // This aditional work is to add a specific weight to the font.
        let systemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let size = systemDynamicFontDescriptor.pointSize
        let font = UIFont.systemFont(ofSize: size, weight: .semibold)
        label.font = font
        
        return label
    }()
    lazy var scanButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "basicDarkPurpule")
        button.tintColor = textColor
        button.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        
        // Title
        let string = "   Scan QR Code"
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor : UIColor.label
        ]
        let attributeString = NSAttributedString(string: string, attributes: attributes)
        button.setAttributedTitle(attributeString, for: .normal)
        
        button.addTarget(self, action: #selector(scanButtonSelected(_:)), for: .touchUpInside)


        return button
    }()
    lazy var isUserLoggedIn: Bool = false {
        didSet {
            if isUserLoggedIn == true {
                let loginButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(loginButtonSelected(_:)))
                self.navigationItem.setRightBarButton(loginButton, animated: true)
                navigationItem.rightBarButtonItem?.tintColor = textColor
                
            } else {
                let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(loginButtonSelected(_:)))
                self.navigationItem.setRightBarButton(loginButton, animated: true)
                navigationItem.rightBarButtonItem?.tintColor = textColor
            }
        }
    }
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupNavBar()
        setupBrandLabel()
        setupScanButton()
    }

    // MARK: - Methods
    private func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        
        let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(loginButtonSelected(_:)))
        navigationItem.rightBarButtonItem = loginButton
        navigationItem.rightBarButtonItem?.tintColor = textColor
    }
    
    private func setupBrandLabel() {
        // Add to view's hierarchy
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(brandLabel)
        
        // Add constraints
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.65)
        ])
    }
    
    private func setupScanButton() {
        // Add to view's hierarchy
        view.addSubview(scanButton)
        
        // Add constraints
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 30),
            scanButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            scanButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        let alert = UIAlertController(title: "Log In/Out Prompt", message: "Just to have the impression we are loggin or out in select below and action.", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "\(isUserLoggedIn ? "Log out" : "Log in")", style: .default) { [unowned self] _ in
            self.isUserLoggedIn.toggle()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc func scanButtonSelected(_ button: UIButton) {
        print("Scan button tapped!")
        
        navigationController?.pushViewController(QRScannerVC(), animated: true)
    }
}

