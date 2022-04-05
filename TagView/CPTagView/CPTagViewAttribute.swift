//
//  CPTagViewAttribute.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

struct CPTagViewAttribute {
    let background: UIColor
    let spacingBetweenRows: CGFloat
    let tagArrangement: TagArrangement
    let removeItemOnRightImageClick: Bool
    let widthExpansionPolicy: WidthExpansionPolicy
    
    let border: (width: CGFloat, color: UIColor) = (0, .clear)
    let userInteraction: Bool = true
    
    let numberOfRow: Int
    let textColor, tagBackgroundColor: (selected: UIColor, unSelected: UIColor)
    let fonts: (selected: UIFont, unSelected: UIFont)
    let sizeCalculationType: SizeCalculationType
    let cornerRadius: CGFloat
    
    let rightSideImage: UIImage? // If tag individual item has rightSideImage then this will not reflect.
    let sizeOfRightImage: CGSize// If tag individual item has sizeOfRightImage then this will not reflect.
    let extraWidth: CGFloat = 0
    
    public init(background: UIColor = .white,
                spacingBetweenRows: CGFloat = 8,
                tagArrangement: CPTagViewAttribute.TagArrangement = .splitInColumn,
                removeItemOnRightImageClick: Bool = false,
                widthExpansionPolicy: CPTagViewAttribute.WidthExpansionPolicy = .lessThanOrEqualToWidth,
                numberOfRow: Int,
                textColor: (selected: UIColor, unSelected: UIColor),
                tagBackgroundColor: (selected: UIColor, unSelected: UIColor),
                fonts: (selected: UIFont, unSelected: UIFont),
                sizeCalculationType: CPTagViewAttribute.SizeCalculationType,
                cornerRadius: CGFloat,
                rightSideImage: UIImage? = nil,
                sizeOfRightImage: CGSize = .init(width: 20, height: 20), extraWidth: CGFloat = 0) {
        
        self.background = background
        self.spacingBetweenRows = spacingBetweenRows
        self.tagArrangement = tagArrangement
        self.removeItemOnRightImageClick = removeItemOnRightImageClick
        self.widthExpansionPolicy = widthExpansionPolicy
        self.numberOfRow = numberOfRow
        self.textColor = textColor
        self.tagBackgroundColor = tagBackgroundColor
        self.fonts = fonts
        self.sizeCalculationType = sizeCalculationType
        self.cornerRadius = cornerRadius
        self.rightSideImage = rightSideImage
        self.sizeOfRightImage = sizeOfRightImage
    }
    
    public enum TagArrangement {
        case sequenceInRow
        case splitInColumn
        case vertical
    }
    
    public enum SizeCalculationType {
        case auto
        case manual(size: CGSize)
    }
    
    public enum WidthExpansionPolicy {
        case lessThanOrEqualToWidth
        case lessThanOrEqualTo(limit: CGFloat)
        case userDefined(width: CGFloat)
        case automatic
    }
}
