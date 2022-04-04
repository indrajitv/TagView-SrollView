//
//  CPTagViewAttribute.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

struct CPTagViewAttribute {
    var background: UIColor = .white
    var spacingBetweenRows: CGFloat = 8
    var tagArrangement: TagArrangement = .splitInColumn
    var removeItemOnRightImageClick: Bool = false
    var widthExpansionPolicy: WidthExpansionPolicy = .lessThanOrEqualToWidth
    let border: (width: CGFloat, color: UIColor) = (0, .clear)
    let userInteraction: Bool = true
    
    let numberOfRow: Int
    let textColor, tagBackgroundColor: (selected: UIColor, unSelected: UIColor)
    let fonts: (selected: UIFont, unSelected: UIFont)
    let sizeCalculationType: SizeCalculationType
    let cornerRadius: CGFloat
    
    enum TagArrangement {
        case sequenceInRow
        case splitInColumn
    }
    
    enum SizeCalculationType {
        case auto(extraWidth: CGFloat)
        case manual(size: CGSize)
    }
    
    enum WidthExpansionPolicy {
        case lessThanOrEqualToWidth
        case lessThanOrEqualTo(limit: CGFloat)
        case userDefined(width: CGFloat)
        case automatic
    }
}
