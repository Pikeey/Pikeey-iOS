//
//  DrinksVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class DrinksVC: UIViewController {
    
    // MARK: - Properties
    lazy var isSearchBarShown: Bool = false
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonSelected(_:)))
        button.tintColor = .label
        
        return button
    }()
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonSelected(_:)))
        button.tintColor = .label
        
        
        return button
    }()
    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search drink"
        
        return search
    }()
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = .systemIndigo
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")!],
                                       for: .selected)
        
        let handler: (UIAction) -> Void = { [unowned self] _ in self.tableView.reloadData() }
        control.insertSegment(action: UIAction(title: "Alcoholic", handler: handler), at: 0, animated: true)
        control.insertSegment(action: UIAction(title: "Non-Alcoholic", handler: handler), at: 1, animated: true)
        control.selectedSegmentIndex = 0
        
        return control
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        return table
    }()
    lazy var foods: Foods? = nil {
        didSet {
            setupTableView()
        }
    }
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Drinks"
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestFoods()
    }
    
    // MARK: - Methods
    private func setupNavBar() {
        // rightButtonItem
        let loginButton = UIBarButtonItem(image: UIImage(systemName: "person"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(loginButtonSelected(_:)))
        loginButton.tintColor = .label
        self.navigationItem.rightBarButtonItem = loginButton
        
        // leftButtonItem
        self.navigationItem.leftBarButtonItem = searchButton
        self.navigationItem.searchController = nil
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
        tableView.register(DrinkCell.self, forCellReuseIdentifier: DrinkCell.identifier)
        
        // Add constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func requestFoods() {
        MomenuServicer(requestType: .restaurantMenu).request(responseType: [Meal].self) { [unowned self] result in
            switch result {
            case .success(let meals):
                self.foods = Foods(foods: meals)
                self.foods = foods
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestFoodBy(tags: [String]) {
        MomenuServicer.tags = tags
        
        MomenuServicer(requestType: .searchByTag).request(responseType: [Meal].self) { [unowned self] result in
            switch result {
            case .success(let meals):
                let foods = Foods(foods: meals)
                self.foods = foods
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchForMeal(text: String) {
        guard let meals = foods?.searchManager.searchForFoodsWith(text: text) else { return }
        
        self.foods = Foods(foods: meals)
        tableView.reloadData()
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
    
    @objc private func searchButtonSelected(_ button: UIBarButtonItem) {
        navigationItem.searchController = searchController
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
    }
    
    @objc private func backButtonSelected(_ button: UIBarButtonItem) {
        navigationItem.searchController = nil
        self.navigationItem.setLeftBarButton(searchButton, animated: true)
        
        requestFoods()
    }
}

// MARK: - SearchBar Delegate
extension DrinksVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text?.lowercased() else { return }
        
        searchForMeal(text: search)
    }
    
    // Temporary fix...
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
           requestFoods()
        }
    }
}

// MARK: - TableView's DataSource
extension DrinksVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let coldDrinks = FoodSearchManager.getFoodUnder(category: .alcoholic, foods: drinks ?? [])
            
            return coldDrinks.count
        case 1:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let hotDrinks = FoodSearchManager.getFoodUnder(category: .nonAlcoholic, foods: drinks ?? [])
            
            return hotDrinks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkCell.identifier, for: indexPath) as! DrinkCell
        
        var foodsToDisplay: [Meal] = []
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let coldDrinks = FoodSearchManager.getFoodUnder(category: .alcoholic, foods: drinks ?? [])
            
            foodsToDisplay = coldDrinks
        case 1:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let hotDrinks = FoodSearchManager.getFoodUnder(category: .nonAlcoholic, foods: drinks ?? [])
            
            foodsToDisplay = hotDrinks
        default:
            break
        }
        
        let name = foodsToDisplay[indexPath.row].name
        let description = foodsToDisplay[indexPath.row].description
        let price = foodsToDisplay[indexPath.row].price
        cell.setContent(name: name, description: description, price: price)
        
        return cell
    }
}

// MARK: - TableView's Delegate
extension DrinksVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        
        var foodsBeingDisplay: [Meal] = []
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let coldDrinks = FoodSearchManager.getFoodUnder(category: .alcoholic, foods: drinks ?? [])
            
            foodsBeingDisplay = coldDrinks
        case 1:
            let drinks = foods?.searchManager.getFoodUnder(type: .drink)
            let hotDrinks = FoodSearchManager.getFoodUnder(category: .nonAlcoholic, foods: drinks ?? [])
            
            foodsBeingDisplay = hotDrinks
        default:
            break
        }
        
        let vc = MealDetailsVC()
        vc.meal = foodsBeingDisplay[indexPath.row]
        
        present(vc, animated: true)
    }
}
