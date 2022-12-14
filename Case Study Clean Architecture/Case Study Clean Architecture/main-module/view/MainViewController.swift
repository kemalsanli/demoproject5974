//
//  MainViewController.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 25.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = UIColor.black.withAlphaComponent(1.0)
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = UIColor.clear
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createCVLayout(spacing: 10 , columnCount: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ElementCell.self, forCellWithReuseIdentifier: ElementCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var noDataView: NoDataView = {
        let noDataView = NoDataView()
        noDataView.isHidden = true
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        return noDataView
    }()
    
    var MainPresenter: ViewToPresenterMainProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createModule(ref: self)
        setViewAttributes()
        setNavigationBarAttributes()
        setSearchBarAttributes()
        setCollectionViewAttributes()
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    
    func setViewAttributes(){
        view.backgroundColor = .white
        self.title = "KABAK"
    }
    
    func setNavigationBarAttributes() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = true
    }
    
    func configureViews(){
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(noDataView)
        
        
        NSLayoutConstraint.activate([
            //Search Bar Constraints
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            
            //Collection View Constraints
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            //No Data View Constraints
            noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noDataView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            noDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}


extension MainViewController: PresenterToViewMainProtocol {    
    func performDataRefresh() {
        self.collectionView.reloadData()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
