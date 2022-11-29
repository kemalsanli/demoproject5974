//
//  SectionHeader.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 27.11.2022.
//

import Foundation
import UIKit

//Source: https://stackoverflow.com/a/57666316

class SectionHeader: UICollectionReusableView {
    static let identifier = "header"
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = Constants.textColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.backgroundColor
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private enum Constants {
    static let textColor: UIColor = UIColor(named: "Text Color")!
    static let backgroundColor: UIColor = UIColor(named: "Background Color")!
}
