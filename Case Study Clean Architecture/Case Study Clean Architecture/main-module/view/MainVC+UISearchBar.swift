//
//  MainVC+UISearchBar.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation
import UIKit

extension MainViewController: UISearchBarDelegate {
    
    func setSearchBarAttributes(){
        searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainPresenter?.getSearchResult(Keyword: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        MainPresenter?.getSearchResult(Keyword: searchText)
    }
}
