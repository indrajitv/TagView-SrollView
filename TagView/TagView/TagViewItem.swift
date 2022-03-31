//
//  TagViewItem.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

enum TagViewItemSize {
    case auto(extraPadding: CGFloat)
    case manual(size: CGSize)
}

class TagViewItem {
    let title, id: String
    let isSelected: Bool
    let rightSizeImage: UIImage?
    let sizeOfRightImage: CGSize
    let textColor, backgroundColor: (selected: UIColor, unSelected: UIColor)
    let fonts: (selected: UIFont, unSelected: UIFont)
    let tagViewItemSize: TagViewItemSize
    
    internal init(title: String,
                  id: String,
                  rightSizeImage: UIImage? = nil,
                  sizeOfRightImage: CGSize = .init(width: 20, height: 20),
                  textColor: (selected: UIColor, unSelected: UIColor),
                  backgroundColor: (selected: UIColor, unSelected: UIColor),
                  fonts: (selected: UIFont, unSelected: UIFont),
                  isSelected: Bool = false,
                  tagViewItemSize: TagViewItemSize = .auto(extraPadding: 16)) {
        self.title = title
        self.id = id
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.fonts = fonts
        self.isSelected = isSelected
        self.rightSizeImage = rightSizeImage
        self.tagViewItemSize = tagViewItemSize
        self.sizeOfRightImage = sizeOfRightImage
    }
    
    func getBackground() -> UIColor {
        return isSelected ? backgroundColor.selected : backgroundColor.unSelected
    }
    
    func getTextColor() -> UIColor {
        return isSelected ? textColor.selected : textColor.unSelected
    }
    
    func getFonts() -> UIFont {
        return isSelected ? fonts.selected : fonts.unSelected
    }
    
    func getSizeOfCell() -> CGSize {
        switch tagViewItemSize {
            case .auto(extraPadding: let extraPadding):
                let size = self.title.estimatedFrame(font: getFonts())
                return .init(width: size.width + extraPadding, height: .zero)
            case .manual(size: let size):
                return size
        }
    }
}
