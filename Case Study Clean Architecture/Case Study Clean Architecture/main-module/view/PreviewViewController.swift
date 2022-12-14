//
//  PreviewViewController.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

class PreviewViewController: UIViewController {
    var previewImage: UIImage = UIImage()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        setNavigationBarAttributes()
        setViewAttributes()
        setConstraints()
        setImageView()
    }
    
    func setViewAttributes(){
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setNavigationBarAttributes() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = Constants.backgroundColor
        navigationController.navigationBar.tintColor = Constants.textColor
    }
    
    func setConstraints() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            //Image View Constraints
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func setImageView() {
        imageView.image = previewImage
    }
}

fileprivate enum Constants {
    static let textColor: UIColor = UIColor(named: "Text Color")!
    static let backgroundColor: UIColor = UIColor(named: "Background Color")!
}
