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
        return imageView
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
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
        imageView.image = UIImage(systemName: "multiply.circle") ?? UIImage()
        warningLabel.text = "No Data"
    }
}
