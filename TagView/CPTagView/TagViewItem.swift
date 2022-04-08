//
//  TagViewItem.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class TagViewItem {
    public let title, id: String
    public var isSelected: Bool
    
    /// This property will impact current tag. TagViewAttribute has same property, If individual has the value then CPTagViewAttribute's property will not have any impact.
    public var rightSideImage: (image: UIImage, size: CGSize)?
    
    /// Show round colour badge like dot on right top side of tag/
    public var roundBadge: (size: CGFloat, color: UIColor)?
    
    public init(title: String,
                id: String,
                isSelected: Bool = false) {
        self.title = title
        self.id = id
        self.isSelected = isSelected
    }
}
