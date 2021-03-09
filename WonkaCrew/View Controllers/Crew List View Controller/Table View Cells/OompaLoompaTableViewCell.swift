//
//  OompaLoompaTableViewCell.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import UIKit
import Kingfisher

class OompaLoompaTableViewCell: UITableViewCell {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let noImage: String = "noImage"
        static let indicatorName: String = "loadingImage"
        static let indicatorType: String = "gif"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            guard let path = Bundle.main.path(forResource: Constants.indicatorName, ofType: Constants.indicatorType),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return
            }
            
            iconImageView.kf.indicatorType = .image(imageData: data)
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure cell
        selectionStyle = .none
    }
    
    // MARK: - Public API
    
    func configure(with presentable: OompaLoompaPresentable) {
        // Configure icon ImageView
        iconImageView.kf.setImage(with: URL(string: presentable.image)) { [weak self] result in
            if case .failure(_) = result {
                self?.iconImageView.image = UIImage(named: Constants.noImage)
            }
        }
        
        // Configure labels
        fullNameLabel.text = presentable.fullName
        professionLabel.text = presentable.profession
    }
}
