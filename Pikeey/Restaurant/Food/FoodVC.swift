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
        
        let handler: (UIAction) -> Void = { [unowned self] _ in self.tableView.reloadData() }
        control.insertSegment(action: UIAction(title: "Starters", handler: handler), at: 0, animated: true)
        control.insertSegment(action: UIAction(title: "Mains", handler: handler), at: 1, animated: true)
        control.insertSegment(action: UIAction(title: "Deserts", handler: handler), at: 2, animated: true)
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
    lazy var foods: Foods =  Foods(foods: Foods.getFood())
    
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
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return foods.getStartedFood().count
        case 1:
            return foods.getMainsFood().count
        case 2:
            return foods.getDesertsFood().count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = UIListContentConfiguration.sidebarSubtitleCell()
        
        var foodsToDisplay: [Food] = []
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            foodsToDisplay = foods.getStartedFood()
        case 1:
            foodsToDisplay = foods.getMainsFood()
        case 2:
            foodsToDisplay = foods.getDesertsFood()
        default:
            break
        }
        
        content.text =  foodsToDisplay[indexPath.row].name
        content.secondaryText =  foodsToDisplay[indexPath.row].description
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - TableView's Delegate
extension FoodVC: UITableViewDelegate {
    
}
