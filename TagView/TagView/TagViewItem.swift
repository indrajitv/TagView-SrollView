//
//  TagViewItem.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class TagViewItem {
    let title, id: String
    var isSelected: Bool
    let rightSideImage: UIImage?
    let sizeOfRightImage: CGSize
    
    init(title: String,
                  id: String,
                  rightSizeImage: UIImage? = nil,
                  sizeOfRightImage: CGSize = .init(width: 20, height: 20),
                  isSelected: Bool = false) {
        self.title = title
        self.id = id
        self.isSelected = isSelected
        self.rightSideImage = rightSizeImage
        self.sizeOfRightImage = sizeOfRightImage
    }
}
