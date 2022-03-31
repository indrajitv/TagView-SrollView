//
//  TagView+Extension.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

extension TagView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        
        self.itemClickObserver?(item)
    }
}

extension TagView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.cellId,
                                                      for: indexPath) as! TagViewCell
        cell.item = item
        cell.rightSideButtonClickObserver = { [weak self] item in
            self?.rightSideButtonClickObserver?(item)
        }
        return cell
    }
}

extension TagView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.item]
        let size =  item.getSizeOfCell()
        if size.height == 0 {
            let numberOfRow: CGFloat = CGFloat(attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow)
            let spacingBwLine: CGFloat = (attribute.spacingBetweenRows/numberOfRow)
            let heightOfCell: CGFloat = collectionView.frame.height/numberOfRow - spacingBwLine
            return .init(width: size.width + (item.rightSizeImage != nil ? heightOfCell : 0),
                         height: heightOfCell)
        } else {
            return size
        }
    }
}

