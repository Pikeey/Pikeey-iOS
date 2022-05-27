//
//  FoodVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class FoodVC: UIViewController {
    
    // MARK: - Properties
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.insertSegment(withTitle: "Starters", at: 0, animated: true)
        control.insertSegment(withTitle: "Mains", at: 1, animated: true)
        control.insertSegment(withTitle: "Deserts", at: 2, animated: true)
        control.selectedSegmentIndex = 0
        
        return control
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 60
        
        return table
    }()
    lazy var text: [String] = [String](repeating: "List Item Name", count: 5)
    lazy var secondaryText: [String] = [String](repeating: "Secondary Text", count: 5)
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Food"
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }
    
    // MARK: - Methods
    private func setupNavBar() {
        let loginButton = UIBarButtonItem(image: UIImage(systemName: "person"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(loginButtonSelected(_:)))
        loginButton.tintColor = .label
        self.navigationItem.rightBarButtonItem = loginButton
    }
    
    private func setupSegmentedControl() {
        // Add to view's hierarchy
        view.addSubview(segmentedControl)
        
        // Add constraints
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        // Add to view's hierarchy
        view.addSubview(tableView)
        
        // Register cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Add constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
}

// MARK: - TableView's DataSource
extension FoodVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = UIListContentConfiguration.sidebarSubtitleCell()
        content.text = text[indexPath.row]
        content.secondaryText = secondaryText[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - TableView's Delegate
extension FoodVC: UITableViewDelegate {
    
}
