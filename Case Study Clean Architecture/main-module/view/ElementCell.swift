//
//  ElementCell.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

class ElementCell: UICollectionViewCell {
    static let identifier = "ElementCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setCell(image: UIImage) {
        setConstraints()
        self.imageView.image = image
    }
    
    func setConstraints() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            //Image View Constraints
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
