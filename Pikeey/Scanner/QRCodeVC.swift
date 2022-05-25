//
//  ViewController.swift
//  Pikeey
//
//  Created by Eric Morales on 5/23/22.
//

import UIKit

class QRCodeVC: UIViewController {

    // MARK: - Properties
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
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Picky"
        
        return label
    }()
    lazy var scanButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .secondarySystemBackground
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
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupBrandLabel()
        setupScanButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Make sure the navigationBar is always being display for this VC.
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Methods
    private func setupNavBar() {
        let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(loginButtonSelected(_:)))
        loginButton.setTitleTextAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single], for: .normal)
        self.navigationItem.rightBarButtonItem = loginButton
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
            scanButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            scanButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
    
    @objc func scanButtonSelected(_ button: UIButton) {
        print("Scan button tapped!")
        
        navigationController?.pushViewController(QRScannerVC(), animated: true)
    }
}

