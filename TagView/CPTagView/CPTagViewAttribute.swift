//
//  CPTagViewAttribute.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class CPTagViewAttribute {
    let textColor, tagBackgroundColor: (normal: UIColor, selected: UIColor)
    let fonts: (normal: UIFont, selected: UIFont)
    
    public var background: UIColor = .white
    public var spacingBetweenRows: CGFloat = 8
    public var tagArrangement: TagArrangement = .splitInColumn
    public var removeItemOnRightImageClick: Bool = false
    public var widthExpansionPolicy: WidthExpansionPolicy = .lessThanOrEqualToWidth
    public var numberOfRow: Int = 1
    
    public var border: (normal: (width: CGFloat, color: UIColor),
                        selected: (width: CGFloat, color: UIColor))? = nil
    public var userInteraction: Bool = true
    public var sizeCalculationType: SizeCalculationType = .auto
    public var cornerRadius: (normal: CGFloat, selected: CGFloat) = (3, 3)
    
    public var rightSideImage: (image: UIImage, size: CGSize)? // If tag individual item has rightSideImage then this will not reflect.
    public var extraWidth: CGFloat = 0
    public var shadow: (offset: CGSize, color: UIColor)?
    public var shadowOpacity: Float = 0.3
    public var contentInset: UIEdgeInsets?
    public var rightSizeImageTint: UIColor?
    public var selectionStyle: CPTagsSelectionStyle = .multiple
    
    init(textColor: (normal: UIColor, selected: UIColor),
         tagBackgroundColor: (normal: UIColor, selected: UIColor), fonts: (normal: UIFont, selected: UIFont)) {
        self.textColor = textColor
        self.tagBackgroundColor = tagBackgroundColor
        self.fonts = fonts
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
    
    public enum CPTagsSelectionStyle {
        case single
        case multiple
    }
}
