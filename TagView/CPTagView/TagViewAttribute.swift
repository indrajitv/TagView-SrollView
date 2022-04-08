//
//  TagViewAttribute.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//


import UIKit

/// General attributes of the tags appearance and behaviour.
public class TagViewAttribute {
    
    /// Tuple for normal/unselected and selected text colour of each tag.
    public var textColor: (normal: UIColor, selected: UIColor)
    
    /// Tuple for normal/unselected and selected background colour of each tag. Note: it is background of tag not the entire view.
    public var tagBackgroundColor: (normal: UIColor, selected: UIColor)
    
    /// Tuple for normal/unselected and selected tag's fonts.
    public var fonts: (normal: UIFont, selected: UIFont)
    
    /// Background colour of the view upon which tags are showing. Note: It is not the tag's background.
    public var background: UIColor = .white
    
    /// Spacing between each tags and rows and columns.
    public var spacingBetweenRows: CGFloat = 8
    
    /// Decides how tags should be arranged on the view.
    /// - Parameter splitInColumn: This case will be applicable when number of lines are 2 or more.  Suppose you have 1 to 10 items then 1,3 5,7,9 will be in first row and 2,4,6,8,10 will in second row.
    /// Thus 1 to 10 are split into 5 column. ScrollView will scroll in horizontal direction.
    /// - Parameter sequenceInRow: Suppose you have 1 to 10 items then 1,2, 3, 4, 5 will be in first row and 6, 7, 8, 8, 10 will in second row.
    /// Thus 1 to 10 in sequence. ScrollView will scroll in horizontal direction.
    /// - Parameter vertical: It will show the tags in sequence (splits rows according to the size available but always in sequence) and scrollView will scroll in vertical direction.
    /// Thus 1 to 10 in sequence.
    public var tagArrangement: TagArrangement = .splitInColumn
    
    /// Removes item automatically from the array and view if right image view gets clicked
    public var removeItemOnRightImageClick: Bool = false
    
    /// Decides how tag's size should be rendered.
    /// - Parameter auto: Automatically manages the height of the tag according to the height of container view.
    /// - Parameter manual(size: CGSize): Manually it will take the size of width given by user.
    /// - Warning: widthExpansionPolicy expansion policy will not effect few of its param in manual size is given.
    public var sizeCalculationType: SizeCalculationType = .auto
  
    /// Decides how width of tag should be expand.
    /// - Parameter lessThanOrEqualToWidth: Less than the width of container view.
    /// - Parameter lessThanOrEqualTo(limit: CGFloat): Width of tag will be less than(or equal) the limit user has passed.
    /// - Parameter userDefined(width: CGFloat): Takes whatever value user sets.
    /// - Parameter automatic: Take the size o fonts and image(If any).
    public var widthExpansionPolicy: WidthExpansionPolicy = .lessThanOrEqualToWidth
    
    /// Decides how many rows to be rendered,
    public var numberOfRow: Int = 1
    
    public var border: (normal: (width: CGFloat, color: UIColor),
                        selected: (width: CGFloat, color: UIColor))? = nil
    
    /// User interaction of the each tags
    public var userInteraction: Bool = true
    
    /// Corner radius of each tag.
    public var cornerRadius: (normal: CGFloat, selected: CGFloat) = (3, 3)
    
    /// This property will impact all tags. TagViewItem has same property, If TagViewItem has the value then this property will not have any impact.
    public var rightSideImage: (image: UIImage, size: CGSize)?
    
    /// Tint colour of right side image, Image rendering must be in alwaysTemplet mode.
    public var rightSizeImageTint: UIColor?
    
    /// If user wish to give extra width to tag in addition to the rendered width.
    public var extraWidth: CGFloat = 0
    
    public var shadow: (offset: CGSize, color: UIColor)?
    
    public var shadowOpacity: Float = 0.3
    
    /// Content inset of scroll view.
    public var contentInset: UIEdgeInsets?
    
    /// Spacing around top, bottom, left, right. This is not contentInset but constraint spacing.
    public var paddingAroundEdges: UIEdgeInsets?
    
    /// User can select multiple tags or one tag at a time.
    public var selectionStyle: CPTagsSelectionStyle = .multiple
    
    /// Selection limit if selection style is multiple.
    public var multipleSelectionLimit: Int?
    
    /// The container's height will be automatically adjusted or will be fit same as scrollview's height. This will be helpful if user does not want to scroll and all items should be visible.
    /// Warning: Turning it true may impact the container view's height constraint as this adjusts height constraint according to the content size height of scroll view.
    /// Warning: Avoid giving height to container in order to make it adjustable by this property.
    /// Warning: Works best if scrolling style is vertical.
    public var autoHeightAdjustmentOfContainerFromContentSize: Bool = false
  
    public init(textColor: (normal: UIColor, selected: UIColor),
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
