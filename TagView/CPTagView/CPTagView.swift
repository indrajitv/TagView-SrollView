//
//  CPTagView.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class CPTagsView: UIView {
    let attribute: CPTagViewAttribute
    
    public var items: [CPTagViewItem] = [] {
        didSet {
            self.addTagsOnScrollView()
        }
    }
    
    public var rightSideButtonClickObserver, itemClickObserver: ((_ item: CPTagViewItem?) -> ())?
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.contentInset.right = self.attribute.spacingBetweenRows
        return sv
    }()
    
    public init(attribute: CPTagViewAttribute) {
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
    
    private func addTagsOnScrollView() {
        self.scrollView.subviews.forEach({ $0.removeFromSuperview() })
        self.layoutIfNeeded()
        
        if attribute.tagArrangement == .vertical {
            addTagsInVerticalStyle()
        } else {
            self.addTagsInHorizontalStyle()
        }
    }
    
    private func addTagsInHorizontalStyle() {
        let numberOfRow: Int = attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow
        let slots = self.slotsForHorizontalStyle(numberOfRow: numberOfRow)
        
        var y: CGFloat = 0
        var maxX: CGFloat = 0
        
        for slot in slots {
            var x: CGFloat = 0
            var maxHeight: CGFloat = 0
            for item in slot {
                let tagView = CPTagContainer(item: item, generalAttributes: self.attribute)
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
        
        self.scrollView.contentSize = .init(width: maxX,
                                            height: self.scrollView.frame.height)
    }
    
    private func slotsForHorizontalStyle(numberOfRow: Int) -> [[CPTagViewItem]] {
        var slots: [[CPTagViewItem]] = []
        
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
    
    private func addTagsInVerticalStyle() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        var maxY: CGFloat = 0
        for item in self.items {
            let tagView = CPTagContainer(item: item, generalAttributes: self.attribute)
            let size = self.getSizeOfCell(item: item)
            let estimatedSpace: CGFloat = x + size.width + attribute.spacingBetweenRows
            
            self.addObserver(tagView: tagView, item: item)
            
            if (scrollView.frame.width - estimatedSpace) <= 0 {
                y += size.height + self.attribute.spacingBetweenRows
                x = 0
            }
            
            tagView.frame = .init(origin: .init(x: x, y: y), size: size)
            self.scrollView.addSubview(tagView)
            
            x += size.width + self.attribute.spacingBetweenRows
            maxY = y + size.height
        }
        
        self.scrollView.contentSize = .init(width: self.scrollView.frame.width - 32, // 32 to remove bounce and scrolling if any
                                            height: maxY + self.attribute.spacingBetweenRows)
    }
    
    private func addObserver(tagView: CPTagContainer, item: CPTagViewItem) {
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
    }
    
    private func removeItemAndRefresh(item: CPTagViewItem) {
        self.items.removeAll(where: { $0.id == item.id && $0.title == item.title })
    }
    
    private func getSizeOfCell(item: CPTagViewItem) -> CGSize {
        switch self.attribute.sizeCalculationType {
            case .auto:
                let extraWidth: CGFloat = 10 + attribute.extraWidth // 10 to adjust auto width.
                let fonts = item.isSelected ? attribute.fonts.selected : attribute.fonts.unSelected
                let sizeFromTexts = estimatedFrame(string: item.title, font: fonts)
                
                let numberOfRow: CGFloat = CGFloat(attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow)
                let spacingBetweenRows: CGFloat = self.attribute.numberOfRow > 1 ? self.attribute.spacingBetweenRows : 0
                
                let rightSideImage = item.rightSideImage ?? self.attribute.rightSideImage
                let sizeOfImage = item.sizeOfRightImage ?? self.attribute.sizeOfRightImage
                var totalWidth: CGFloat = sizeFromTexts.width + (rightSideImage != nil ? sizeOfImage.width : 0) + extraWidth
                
                var sizeOfCell: CGSize = .zero
                
                switch self.attribute.widthExpansionPolicy {
                    case .lessThanOrEqualToWidth:
                        if totalWidth > self.frame.width - (self.attribute.spacingBetweenRows * 2) {
                            totalWidth = self.frame.width - (self.attribute.spacingBetweenRows * 2) - 16
                        }
                    case .lessThanOrEqualTo(let limit):
                        totalWidth = totalWidth > limit ? limit : totalWidth
                    case .userDefined(let width):
                        totalWidth = width
                    case .automatic:
                        break
                }
                
                if attribute.tagArrangement == .vertical {
                    sizeOfCell = .init(width: totalWidth, height: fonts.pointSize * 2.5) // height is 2.5 times of pointSize
                } else {
                    let heightOfCell: CGFloat = (self.frame.height/numberOfRow) - spacingBetweenRows
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
}
