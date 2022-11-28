//
//  MainVC+UICollectionViewController.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 25.11.2022.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func createCVLayout(spacing: CGFloat, columnCount: CGFloat) -> UICollectionViewFlowLayout {
        
        let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = view.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let cellWidth = (width - ((columnCount + 1) * spacing)) / columnCount
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        design.minimumInteritemSpacing = spacing
        design.minimumLineSpacing = spacing
        
        return design
    }
    
    func setCollectionViewAttributes() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainPresenter?.getSectionCount() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellCount = MainPresenter?.getCellCount(Section: section) else { return 0 }
        if cellCount == 0 {
            collectionView.isHidden = true
            noDataView.isHidden = false
            return cellCount
        } else {
            collectionView.isHidden = false
            noDataView.isHidden = true
            return cellCount
        }
    }
    
    //Source: https://stackoverflow.com/a/57666316
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
            sectionHeader.label.text = MainPresenter?.getSectionHeaderTitle(Section: indexPath.section)
            return sectionHeader
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    //Source: https://stackoverflow.com/a/57666316
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCell.identifier, for: indexPath) as! ElementCell
        let image = (MainPresenter?.getCellImage(indexPath: indexPath))!
        cell.setCell(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PreviewViewController()
        vc.previewImage = MainPresenter?.getPreviewImage(indexPath: indexPath) ?? UIImage()
        navigationController?.pushViewController(vc, animated: true)
    }
}
