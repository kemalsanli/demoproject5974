//
//  NoDataView.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

class NoDataView: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Constants.tintColor
        return imageView
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.backgroundColor
        setConstraints()
        setComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        self.addSubview(imageView)
        self.addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            //Image View Constraints
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //Warning Label Constraints
            warningLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            warningLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
    
    func setComponents() {
        imageView.image = UIImage(systemName: Constants.imageViewImageName) ?? UIImage()
        warningLabel.text = Constants.warningLabelText
    }
}

private enum Constants {
    static let imageViewImageName: String = "multiply.circle"
    static let warningLabelText: String = "No Data"
    static let textColor: UIColor = UIColor(named: "Text Color")!
    static let backgroundColor: UIColor = UIColor(named: "Background Color")!
    static let tintColor: UIColor = UIColor(named: "Tint Color")!
}

