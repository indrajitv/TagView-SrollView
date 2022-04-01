//
//  TagViewCell.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class TagContainer: UIView {
    private var labelTrailingConstraintWithView,
        labelTrailingConstraintWithButton: NSLayoutConstraint!
  
    private var heightOfButton, widthOfButton: NSLayoutConstraint!
    
    private var item: TagViewItem
    private var generalAttributes: TagViewAttribute
    
    var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagViewItem?) -> ())?
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.buttonCloseClicked),
                         for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets.right = 8
        return button
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    init(item: TagViewItem, generalAttributes: TagViewAttribute) {
        self.item = item
        self.generalAttributes = generalAttributes
        
        super.init(frame: .zero)
        setupViews()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.addSubview(containerView)
        containerView.setFullOnSuperView(withSpacing: self.generalAttributes.spacingBetweenRows/2)
        
        containerView.addSubviews(views: [labelTitle, buttonClose])
   
        buttonClose.setCenterY()
        heightOfButton = buttonClose.heightAnchor.constraint(equalToConstant: 0)
        widthOfButton = buttonClose.widthAnchor.constraint(equalToConstant: 0)
        heightOfButton.isActive = true
        widthOfButton.isActive = true
        
        buttonClose.setTrailing(with: containerView.trailingAnchor)
        
        labelTitle.setAnchors(top: containerView.topAnchor,
                              bottom: containerView.bottomAnchor,
                              leading: containerView.leadingAnchor)
        
        labelTrailingConstraintWithView = labelTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        labelTrailingConstraintWithButton = labelTitle.trailingAnchor.constraint(equalTo: self.buttonClose.leadingAnchor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectTag))
        self.addGestureRecognizer(tap)
    }
    
    private func configureCell() {
        labelTitle.text = item.title
        buttonClose.setImage(item.rightSideImage, for: .normal)
        
        self.buttonClose.isHidden = item.rightSideImage == nil
        labelTrailingConstraintWithView.isActive = item.rightSideImage == nil
        labelTrailingConstraintWithButton.isActive = item.rightSideImage != nil
        
        heightOfButton?.constant = item.sizeOfRightImage.height
        widthOfButton?.constant = item.sizeOfRightImage.width
        
        labelTitle.font = item.isSelected ? generalAttributes.fonts.selected : generalAttributes.fonts.unSelected
        labelTitle.textColor = item.isSelected ? generalAttributes.textColor.selected : generalAttributes.textColor.unSelected
        containerView.backgroundColor = item.isSelected ? generalAttributes.tagBackgroundColor.selected : generalAttributes.tagBackgroundColor.unSelected
        containerView.layer.cornerRadius = generalAttributes.cornerRadius
    }
    
    @objc private func buttonCloseClicked() {
        rightSideButtonClickObserver?(self.item)
    }
    
    @objc private func didSelectTag() {
        item.isSelected = !item.isSelected
        configureCell()
        itemClickObserver?(self.item)
    }
    
}
