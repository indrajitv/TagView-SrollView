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
    var isSelected: Bool
    let rightSizeImage: UIImage?
    let sizeOfRightImage: CGSize
    let textColor, backgroundColor: (selected: UIColor, unSelected: UIColor)
    let fonts: (selected: UIFont, unSelected: UIFont)
    let tagViewItemSize: TagViewItemSize
    let cornerRadius: CGFloat
    
    internal init(title: String,
                  id: String,
                  rightSizeImage: UIImage? = nil,
                  sizeOfRightImage: CGSize = .init(width: 20, height: 20),
                  textColor: (selected: UIColor, unSelected: UIColor),
                  backgroundColor: (selected: UIColor, unSelected: UIColor),
                  fonts: (selected: UIFont, unSelected: UIFont),
                  isSelected: Bool = false,
                  tagViewItemSize: TagViewItemSize = .auto(extraPadding: 16),
                  cornerRadius: CGFloat = 3) {
        self.title = title
        self.id = id
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.fonts = fonts
        self.isSelected = isSelected
        self.rightSizeImage = rightSizeImage
        self.tagViewItemSize = tagViewItemSize
        self.sizeOfRightImage = sizeOfRightImage
        self.cornerRadius = cornerRadius
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
                let size = estimatedFrame(string: self.title, font: getFonts())
                return .init(width: size.width + extraPadding, height: .zero)
            case .manual(size: let size):
                return size
        }
    }
    
    private func estimatedFrame(string: String, font: UIFont) -> CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: string).boundingRect(with: size,
                                                     options: options,
                                                     attributes: [NSAttributedString.Key.font: font],
                                                     context: nil)
    }
}
