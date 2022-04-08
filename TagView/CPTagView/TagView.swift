//
//  CPTagView.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class TagsView: UIView {
    
    /// Previously selected tag.
    var previousSelected: TagContainer?
    
    private var attribute: TagViewAttribute
    
    /// Editing or setting items will automatically reloads the TagsView.
    public var items: [TagViewItem] = [] {
        didSet {
            self.addTagsOnScrollView()
        }
    }
    
    public var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagViewItem?, _ index: Int?) -> ())?
    
    /// If multipleSelectionLimit was set then it will get called on limit reach.
    public var selectionLimitReached: ((_ setLimit: Int, _ tagView: UIView) -> ())?
    
    /// After rendering the tags this will give the size of scroll view.
    public var totalContentSizeOfTagAfterRendering: ((_ size: CGSize) -> ())?
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    public init(attribute: TagViewAttribute) {
        self.attribute = attribute
        
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = attribute.background
       
        self.addSubviews(views: [scrollView])
        scrollView.setFullOnSuperView()
    }
    
    public func updateAttributes(attribute: TagViewAttribute) {
        self.attribute = attribute
    }
    
    public func getAttributes() -> TagViewAttribute {
        return self.attribute
    }
    
    public func reloadTags() {
        let temp = self.items
        self.items = temp
    }
    
    private func addTagsOnScrollView() {
        self.scrollView.contentSize = .zero
        self.scrollView.subviews.forEach({ $0.removeFromSuperview() })
        self.layoutIfNeeded()
        
        if attribute.tagArrangement == .vertical {
            addTagsInVerticalStyle()
        } else {
            self.addTagsInHorizontalStyle()
        }
    }
    
    private func didSetContentSizeOfScrollView(size: CGSize) {
        self.totalContentSizeOfTagAfterRendering?(size)
        if attribute.autoHeightAdjustmentOfContainerFromContentSize {
            let newHeight = size.height - (self.attribute.tagArrangement == .vertical ? self.attribute.spacingBetweenRows : 0)
            var heightFound: Bool = false
            self.scrollView.contentSize.height = newHeight
            
            self.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = newHeight
                    heightFound = true
                }
            }
            if !heightFound {
                self.setHeight(height: newHeight)
            }
        }
    }
    
    private func slotsForHorizontalStyle(numberOfRow: Int) -> [[TagViewItem]] {
        var slots: [[TagViewItem]] = []
        
        for _ in 0..<numberOfRow {
            slots.append([])
        }
        
        if attribute.tagArrangement == .splitInColumn {
            var currentArrayIndex: Int = 0
            for _item in self.items {
                var existingArray = slots[currentArrayIndex]
                existingArray.append(_item)
                slots[currentArrayIndex] = existingArray
                if currentArrayIndex < numberOfRow-1 {
                    currentArrayIndex += 1
                } else {
                    currentArrayIndex = 0
                }
            }
            
        } else {
            var currentArrayIndex: Int = 0
            let limitInOneRow: Int = self.items.count / numberOfRow
            
            var index = 0
            while index < self.items.count {
                let _item = self.items[index]
                
                var existingArray = slots[currentArrayIndex]
                existingArray.append(_item)
                slots[currentArrayIndex] = existingArray
                
                index += 1
                
                if existingArray.count >= limitInOneRow, currentArrayIndex < numberOfRow-1 {
                    currentArrayIndex += 1
                }
            }
        }
        return slots
    }
    
    private func addTagsInHorizontalStyle() {
        let numberOfRow: Int = attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow
        let slots = self.slotsForHorizontalStyle(numberOfRow: numberOfRow)
        
        let top: CGFloat = self.attribute.paddingAroundEdges?.top ?? 0
        let bottom: CGFloat = self.attribute.paddingAroundEdges?.bottom ?? 0
        let left: CGFloat = self.attribute.paddingAroundEdges?.left ?? 0
        let right: CGFloat = self.attribute.paddingAroundEdges?.right ?? 0
        
        var y: CGFloat = top
        var maxX: CGFloat = 0
        
        for slot in slots {
            var x: CGFloat = left
            var maxHeight: CGFloat = 0
            for item in slot {
                let tagView = TagContainer(item: item, generalAttributes: self.attribute)
                self.addObserver(tagView: tagView, item: item)
                
                let size = self.getSizeOfCell(item: item)
                self.scrollView.addSubview(tagView)
                tagView.frame = .init(origin: .init(x: x, y: y), size: size)
                x += size.width + self.attribute.spacingBetweenRows
                
                if size.height > maxHeight {
                    maxHeight = size.height
                }
            }
            if x > maxX {
                maxX = x
            }
            y += maxHeight + attribute.spacingBetweenRows
        }
        
        let contentHeight: CGFloat = attribute.autoHeightAdjustmentOfContainerFromContentSize ? y - attribute.spacingBetweenRows : self.scrollView.frame.height
        
        let contentSize: CGSize = .init(width: maxX + right,
                                        height: contentHeight + bottom)
        self.scrollView.contentSize = contentSize
      
        self.didSetContentSizeOfScrollView(size: contentSize)
    }
    
    private func addTagsInVerticalStyle() {
        let top: CGFloat = self.attribute.paddingAroundEdges?.top ?? 0
        let bottom: CGFloat = self.attribute.paddingAroundEdges?.bottom ?? 0
        let left: CGFloat = self.attribute.paddingAroundEdges?.left ?? 0
        let right: CGFloat = self.attribute.paddingAroundEdges?.right ?? 0
        
        var x: CGFloat = left
        var y: CGFloat = top
        
        var maxY: CGFloat = 0
        for item in self.items {
            let tagView = TagContainer(item: item, generalAttributes: self.attribute)
            let size = self.getSizeOfCell(item: item)
            let estimatedSpace: CGFloat = x + size.width + attribute.spacingBetweenRows
            
            self.addObserver(tagView: tagView, item: item)
            
            if (scrollView.frame.width - estimatedSpace) <= 0 {
                y += size.height + self.attribute.spacingBetweenRows
                x = left
            }
            
            tagView.frame = .init(origin: .init(x: x, y: y), size: size)
            self.scrollView.addSubview(tagView)
            
            x += size.width + self.attribute.spacingBetweenRows
            maxY = y + size.height
        }
        
        self.scrollView.contentSize = .init(width: self.scrollView.frame.width + right - 32, // 32 to remove bounce and scrolling if any
                                            height: maxY + self.attribute.spacingBetweenRows + bottom)
        self.didSetContentSizeOfScrollView(size: self.scrollView.contentSize)
    }
    
    private func addObserver(tagView: TagContainer, item: TagViewItem) {
        tagView.rightSideButtonClickObserver = { [weak self] (selectedItem) in
            guard let self = self else { return }
            if self.attribute.removeItemOnRightImageClick {
                self.removeItemAndRefresh(item: item)
            }
            if let index = self.items.firstIndex(where: { $0.title == item.title &&  $0.id == item.id }) {
                self.rightSideButtonClickObserver?(selectedItem.item, Int(index))
            } else {
                self.rightSideButtonClickObserver?(selectedItem.item, nil)
            }
            
        }
        
        tagView.itemClickObserver = { [weak self] (selectedItem) in
            guard let self = self else { return }
            
            if let setLimit = self.attribute.multipleSelectionLimit {
                let selectedCount = self.items.filter({ $0.isSelected }).count
                if selectedCount >= setLimit {
                    self.selectionLimitReached?(setLimit, tagView)
                    return
                }
            }
            
            if let index = self.items.firstIndex(where: { $0.title == item.title &&  $0.id == item.id }) {
                self.itemClickObserver?(selectedItem.item, Int(index))
            } else {
                self.itemClickObserver?(selectedItem.item, nil)
            }
            
            if self.attribute.selectionStyle == .single {
                if self.previousSelected == selectedItem {
                    self.previousSelected = nil
                } else {
                    self.previousSelected?.toggle()
                    self.previousSelected = selectedItem
                }
            } else {
                self.previousSelected = selectedItem
            }
            
        }
    }
    
    private func removeItemAndRefresh(item: TagViewItem) {
        self.items.removeAll(where: { $0.id == item.id && $0.title == item.title })
    }
    
    private func getSizeOfCell(item: TagViewItem) -> CGSize {
        switch self.attribute.sizeCalculationType {
            case .auto:
                let extraWidth: CGFloat = 10 + attribute.extraWidth // 10 to adjust auto width.
                let fonts = item.isSelected ? attribute.fonts.selected : attribute.fonts.normal
                let sizeFromTexts = estimatedFrame(string: item.title, font: fonts)
                
                let numberOfRow: CGFloat = CGFloat(attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow)
                let spacingBetweenRows: CGFloat = self.attribute.numberOfRow > 1 ? self.attribute.spacingBetweenRows : 0
                
                let rightSideImage = item.rightSideImage?.image ?? self.attribute.rightSideImage?.image
                let sizeOfImage = item.rightSideImage?.size ?? self.attribute.rightSideImage?.size
                var totalWidth: CGFloat = sizeFromTexts.width + (rightSideImage != nil ? sizeOfImage?.width ?? 0 : 0) + extraWidth
                
                var sizeOfCell: CGSize = .zero
                
                switch self.attribute.widthExpansionPolicy {
                    case .lessThanOrEqualToWidth:
                        if totalWidth > self.scrollView.frame.width - (self.attribute.spacingBetweenRows * 2) {
                            totalWidth = self.scrollView.frame.width - (self.attribute.spacingBetweenRows * 2) - 16
                        }
                    case .lessThanOrEqualTo(let limit):
                        totalWidth = totalWidth > limit ? limit : totalWidth
                    case .userDefined(let width):
                        totalWidth = width
                    case .automatic:
                        break
                }
                
                let heightFromFonts: CGFloat = fonts.pointSize * 2.5 // height is 2.5 times of pointSize
                if attribute.tagArrangement == .vertical || self.attribute.autoHeightAdjustmentOfContainerFromContentSize {
                    sizeOfCell = .init(width: totalWidth, height: heightFromFonts)
                } else {
                    let dividedHeight: CGFloat = (self.scrollView.frame.height/numberOfRow) <= 0 ? heightFromFonts : (self.scrollView.frame.height/numberOfRow)
                    let heightOfCell: CGFloat = dividedHeight - spacingBetweenRows
                    sizeOfCell = .init(width: totalWidth,
                                       height: heightOfCell + (numberOfRow > 1 ? attribute.spacingBetweenRows / numberOfRow : 0))
                }
                return sizeOfCell
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
    
    public func getSelectedItems() -> [TagViewItem] {
        return self.items.filter({ $0.isSelected })
    }
    
    public func getUnSelectedItems() -> [TagViewItem] {
        return self.items.filter({ !$0.isSelected })
    }
}
