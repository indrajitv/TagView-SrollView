//
//  TagViewAttribute.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

struct TagViewAttribute {
    var background: UIColor = .white
    var spacingBetweenRows: CGFloat = 8
    var tagArrangement: TagArrangement = .splitInColumn
    var removeItemOnRightImageClick: Bool = false
    var expansionPolicy: ExpansionPolicy = .lessThanOrEqualToWidth
    
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
    
    enum ExpansionPolicy {
        case lessThanOrEqualToWidth
        case infinite
    }
}
