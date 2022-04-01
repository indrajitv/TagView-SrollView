//
//  TagView.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class TagView: UIView {
    let attribute: TagViewAttribute
    
    var items: [TagViewItem] = [] {
        didSet {
            self.addTagsOnScrollView()
        }
    }
    
    var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagViewItem?) -> ())?
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.contentInset.right = self.attribute.spacingBetweenRows
        return sv
    }()
    
    init(attribute: TagViewAttribute) {
        self.attribute = attribute
        
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.backgroundColor = attribute.background
        
        self.addSubviews(views: [scrollView])
        scrollView.setFullOnSuperView()
    }
    
    private func addTagsOnScrollView() {
        self.scrollView.subviews.forEach({ $0.removeFromSuperview() })
        self.layoutIfNeeded()
        
        let numberOfRow: Int = attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow
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
        
        var y: CGFloat = self.attribute.spacingBetweenRows/2
        var maxX: CGFloat = 0
        
        for slot in slots {
            var x: CGFloat = self.attribute.spacingBetweenRows/2
            var maxHeight: CGFloat = 0
            for item in slot {
                let tagView = TagContainer(item: item, generalAttributes: self.attribute)
                
                tagView.rightSideButtonClickObserver = { [weak self] (selectedItem) in
                    guard let self = self else { return }
                    if self.attribute.removeItemOnRightImageClick {
                        self.removeItemAndRefresh(item: item)
                    }
                    self.rightSideButtonClickObserver?(selectedItem)
                }
                
                tagView.itemClickObserver = { [weak self] (selectedItem) in
                    self?.itemClickObserver?(selectedItem)
                }
                
                let size = self.getSizeOfTag(item: item)
                self.scrollView.addSubview(tagView)
                tagView.frame = .init(origin: .init(x: x, y: y), size: size)
                x += size.width
                
                if size.height > maxHeight {
                    maxHeight = size.height
                }
            }
            if x > maxX {
                maxX = x
            }
            y += maxHeight
        }
        
        self.scrollView.contentSize = .init(width: maxX,
                                            height: self.scrollView.frame.height)
    }
    
    private func getSizeOfTag(item: TagViewItem) -> CGSize {
        let size =  getSizeOfCell(item: item)
        if size.height == 0 { // auto
            let numberOfRow: CGFloat = CGFloat(attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow)
            let heightOfCell: CGFloat = (self.frame.height/numberOfRow) - self.attribute.spacingBetweenRows/numberOfRow
            let width: CGFloat = size.width + (item.rightSideImage != nil ? heightOfCell : 0)
            return .init(width: width, height: heightOfCell)
        } else {
            return size
        }
    }
    
    private func removeItemAndRefresh(item: TagViewItem) {
        self.items.removeAll(where: { $0.id == item.id && $0.title == item.title })
    }
    
    private func getSizeOfCell(item: TagViewItem) -> CGSize {
        switch self.attribute.sizeCalculationType {
            case .auto(extraWidth: let extraWidth):
                let fonts = item.isSelected ? attribute.fonts.selected : attribute.fonts.unSelected
                let size = estimatedFrame(string: item.title, font: fonts)
                var totalWidth = size.width + extraWidth
                
                if self.attribute.expansionPolicy == .lessThanOrEqualToWidth,
                   totalWidth > self.frame.width - (self.attribute.spacingBetweenRows * 2) {
                    
                    totalWidth = self.frame.width - (self.attribute.spacingBetweenRows * 2) - 40
                    if item.rightSideImage != nil {
                        totalWidth -= item.sizeOfRightImage.width
                    }
                    
                }
                return .init(width: totalWidth, height: .zero)
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
