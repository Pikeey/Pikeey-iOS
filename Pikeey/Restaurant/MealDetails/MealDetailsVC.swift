//
//  MealDetailsVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/27/22.
//

import UIKit

class MealDetailsVC: UIViewController {
    
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        
        // This aditional work is to add a specific weight to the font.
        let systemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
        let size = systemDynamicFontDescriptor.pointSize
        let font = UIFont.systemFont(ofSize: size, weight: .semibold)
        label.font = font
        
        return label
    }()
    lazy var imageView: UIImageView = {
        let image =  UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        
        return image
    }()
    lazy var basicInfoHorizontalStack: BasicInfoStack = {
        let stack = BasicInfoStack()
        
        return stack
    }()
    lazy var longDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    lazy var meal: Meal? = nil {
        didSet {
            // Setting up content
            if let meal = meal {
                titleLabel.text = meal.name
                let imageData = try? Data(contentsOf: meal.image)
                imageView.image = UIImage(data: imageData!)
                basicInfoHorizontalStack.mealNameLabel.text = meal.name
                basicInfoHorizontalStack.mealShortDescriptionLabel.text = meal.description
                basicInfoHorizontalStack.priceLabel.text = "$\(String(format: "%.2f", meal.price))"
                
                
                // Ingredients
                let systemSubHeadDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .subheadline)
                let subHeadSize = systemSubHeadDynamicFontDescriptor.pointSize
                let subHeadFont = UIFont.systemFont(ofSize: subHeadSize, weight: .semibold)
                let ingredientsAttributeText = NSMutableAttributedString(string: "Ingredients: \(meal.ingredients.joined(separator: ", ")).")
                ingredientsAttributeText.addAttribute(.font, value: subHeadFont, range: NSRange(location: 0, length: 12))
                longDescriptionLabel.attributedText = ingredientsAttributeText
                
                // Section
                let systemCaptionDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .caption1)
                let captionSize = systemCaptionDynamicFontDescriptor.pointSize
                let captionFont = UIFont.systemFont(ofSize: captionSize, weight: .bold)
                let sectionAttributeText = NSMutableAttributedString(string: "Section: \(meal.section)")
                sectionAttributeText.addAttribute(.font, value: captionFont, range: NSRange(location: 0, length: 9))
                sectionLabel.attributedText = sectionAttributeText
                
            }
        }
    }
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setuptitleLabel()
        setupImageView()
        setupBasicInfoHorizontalStack()
        setupLongDescription()
        setupCategory()
    }
    
    // MARK: - Methods
    private func setuptitleLabel() {
        // Add to view's hierarchy
        view.addSubview(titleLabel)
        
        // Add constrains
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupImageView() {
        // Add to view's hierarchy
        view.addSubview(imageView)
        
        // Add constrains
        let aspectRatio: CGFloat = (3/5)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupBasicInfoHorizontalStack() {
        // Add to view's hierarchy
        view.addSubview(basicInfoHorizontalStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // mealBasicInfoHorizontalStack
            basicInfoHorizontalStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            basicInfoHorizontalStack.heightAnchor.constraint(equalTo: basicInfoHorizontalStack.mealBasifInfoVerticalStack.heightAnchor, constant: 20),
            basicInfoHorizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            basicInfoHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLongDescription() {
        // Add to view's hierarchy
        view.addSubview(longDescriptionLabel)
        
        // Add constrains
        NSLayoutConstraint.activate([
            longDescriptionLabel.topAnchor.constraint(equalTo: basicInfoHorizontalStack.bottomAnchor, constant: 20),
            longDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            longDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupCategory() {
        // Add to view's hierarchy
        view.addSubview(sectionLabel)
        
        // Add constraints
        NSLayoutConstraint.activate([
            sectionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            sectionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            sectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
