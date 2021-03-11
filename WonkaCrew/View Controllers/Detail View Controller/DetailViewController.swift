//
//  DetailViewController.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 10/3/21.
//

import UIKit

class DetailViewController: UIViewController, Storyboardable {
    
    // MARK: - Private constants
    
    private enum Constants {
        enum Header {
            enum Constraints {
                private static var statusBarHeight: CGFloat {
                    if #available(iOS 13.0, *) {
                        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                    } else {
                        return  UIApplication.shared.statusBarFrame.height
                    }
                }
                
                static let thresholdPercentage: CGFloat = 0.3
                static let maxHeight: CGFloat = 250.0
                static let minHeight: CGFloat = 30.0 + statusBarHeight
                static let heightRange = minHeight...maxHeight
            }
            
            enum Label {
                enum Constraints {
                    static let defaultWidth: CGFloat = 150.0
                    static let maxWidth: CGFloat = UIScreen.main.bounds.width * 0.85
                }
            }
            
            enum BackgroundGradient {
                enum Constraints {
                    static let topAlpha: CGFloat = .zero
                    static let bottomAlpha: CGFloat = 0.7
                }
            }
        }
        
        enum EmailLabel {
            enum Constraints {
                static let minimumScaleFactor: CGFloat = 0.7
            }
        }
        
        enum FavoritesStackView {
            enum Constraints {
                static let borderThickness: CGFloat = 2.0
            }
        }
        
        static let viewModelError: String = "Could not load Oompa Loompa Presentable."
        static let wonkaColor: String = "WonkaColor"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundGradientView: UIView!
    
    @IBOutlet weak var headerImageView: UIImageView! {
        didSet {
            headerImageView.setIndicator()
        }
    }
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var favoritesStackView: UIStackView!
    
    var viewModel: OompaLoompaPresentable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configure()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupHeaderView()
        setupScrollView()
        setupFavoritesStackView()
    }
    
    private func setupHeaderView() {
        // Set default header height
        headerViewHeightConstraint.constant = Constants.Header.Constraints.maxHeight
        
        // Set default label header width
        headerLabelWidthConstraint.constant = Constants.Header.Label.Constraints.defaultWidth
        
        // Set gradient to background gradient view
        backgroundGradientView.setGradientBackground(
            colorTop: UIColor.black.withAlphaComponent(Constants.Header.BackgroundGradient.Constraints.topAlpha),
            colorBottom: UIColor.black.withAlphaComponent(Constants.Header.BackgroundGradient.Constraints.bottomAlpha))
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    private func setupFavoritesStackView() {
        favoritesStackView.addBorder(color: .white,
                                     backgroundColor: UIColor(named: Constants.wonkaColor) ?? UIColor.white.withAlphaComponent(.zero),
                                     thickness: Constants.FavoritesStackView.Constraints.borderThickness)
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            fatalError(Constants.viewModelError)
        }
        
        // Configure Header ImageView
        headerImageView.setImage(url: URL(string: viewModel.image), withFailure: true)
        
        // Configure Header Label
        headerLabel.text = viewModel.fullName
        
        // Configure Oompa Loompa Details Labels
        professionLabel.text = viewModel.profession
        genderLabel.text = viewModel.gender
        emailLabel.text = viewModel.email
        countryLabel.text = viewModel.country
        ageLabel.text = "\(viewModel.age)"
        heightLabel.text = "\(viewModel.height)"
        colorLabel.text = viewModel.color
        foodLabel.text = viewModel.food
        songLabel.text = viewModel.song
        
        // Resize some labels
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.minimumScaleFactor = Constants.EmailLabel.Constraints.minimumScaleFactor
    }
    
}

// MARK: - ScrollView Delegate

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate content offset at y-axis
        let y = scrollView.contentOffset.y
        
        // Calculate new header height
        let newHeaderViewHeight = headerViewHeightConstraint.constant - y
        
        // Calculate progression percentage
        let percentage = newHeaderViewHeight.percentage(from: Constants.Header.Constraints.minHeight, to: Constants.Header.Constraints.maxHeight)
        
        // Set new alpha for background image
        headerImageView.alpha = percentage
        
        // Set new alpha for gradient background view
        backgroundGradientView.alpha = percentage
        
        // Change label width according to a threshold percentage
        if percentage < Constants.Header.Constraints.thresholdPercentage {
            headerLabelWidthConstraint.constant = Constants.Header.Label.Constraints.maxWidth
        } else {
            headerLabelWidthConstraint.constant = Constants.Header.Label.Constraints.defaultWidth
        }
        
        // Check if the new header height is inside the range of the min and max allowed heights
        if Constants.Header.Constraints.heightRange ~= newHeaderViewHeight {
            // Change header height
            headerViewHeightConstraint.constant = newHeaderViewHeight
            
            // Reset content offset of the scroll view
            scrollView.contentOffset.y = .zero
        } else if newHeaderViewHeight > Constants.Header.Constraints.maxHeight {
            // Set max height
            headerViewHeightConstraint.constant = Constants.Header.Constraints.maxHeight
        } else {
            // Set min height
            headerViewHeightConstraint.constant = Constants.Header.Constraints.minHeight
        }
    }
}
