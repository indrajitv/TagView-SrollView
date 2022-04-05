//
//  CPTagViewItem.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class CPTagViewItem {
    public let title, id: String
    public var isSelected: Bool
    public let rightSideImage: UIImage?
    public let sizeOfRightImage: CGSize?
    
    public init(title: String,
                id: String,
                rightSizeImage: UIImage? = nil,
                sizeOfRightImage: CGSize? = nil,
                isSelected: Bool = false) {
        self.title = title
        self.id = id
        self.isSelected = isSelected
        self.rightSideImage = rightSizeImage
        self.sizeOfRightImage = sizeOfRightImage
    }
}
