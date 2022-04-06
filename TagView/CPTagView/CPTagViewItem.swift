//
//  CPTagViewItem.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class CPTagViewItem {
    public let title, id: String
    public var isSelected: Bool
    public var rightSideImage: (image: UIImage, size: CGSize)? 
    
    public init(title: String,
                id: String,
                isSelected: Bool = false) {
        self.title = title
        self.id = id
        self.isSelected = isSelected
    }
}
