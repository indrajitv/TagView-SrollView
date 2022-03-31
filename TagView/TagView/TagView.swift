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
        sv.contentInset = .init(top: 0,
                                left: self.attribute.spacingBetweenRows/CGFloat(self.attribute.numberOfRow),
                                bottom: 0,
                                right: self.attribute.spacingBetweenRows/CGFloat(self.attribute.numberOfRow))
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
        let spacingBwLine: CGFloat = (attribute.spacingBetweenRows/CGFloat(numberOfRow))
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
        
        var y: CGFloat = self.attribute.spacingBetweenRows/CGFloat(numberOfRow)/2
        var maxX: CGFloat = 0
        
        for slot in slots {
            var x: CGFloat = 0
            var maxHeight: CGFloat = 0
            for item in slot {
                let tagView = TagContainer(item: item)
                
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
                x += (size.width + spacingBwLine)
                
                if size.height > maxHeight {
                    maxHeight = size.height
                }
            }
            if x > maxX {
                maxX = x
            }
            y += (spacingBwLine + maxHeight)
        }
        
        self.scrollView.contentSize = .init(width: maxX,
                                            height: self.scrollView.frame.height)
    }
    
    private func getSizeOfTag(item: TagViewItem) -> CGSize {
        let size =  item.getSizeOfCell()
        if size.height == 0 {
            let numberOfRow: CGFloat = CGFloat(attribute.numberOfRow <= 0 ? 1 : attribute.numberOfRow)
            let spacingBwLine: CGFloat = (attribute.spacingBetweenRows/numberOfRow)
            let heightOfCell: CGFloat = self.frame.height/numberOfRow - spacingBwLine
            return .init(width: size.width + (item.rightSizeImage != nil ? heightOfCell : 0),
                         height: heightOfCell)
        } else {
            return size
        }
    }
    
    func removeItemAndRefresh(item: TagViewItem) {
        self.items.removeAll(where: { $0.id == item.id && $0.title == item.title })
    }
}
