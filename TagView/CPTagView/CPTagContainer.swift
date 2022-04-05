//
//  TagViewCell.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class CPTagContainer: UIView {
    private var labelTrailingConstraintWithView,
        labelTrailingConstraintWithButton: NSLayoutConstraint!
  
    private var heightOfButton, widthOfButton: NSLayoutConstraint!
    
    private var item: CPTagViewItem
    private var generalAttributes: CPTagViewAttribute
    
    var rightSideButtonClickObserver, itemClickObserver: ((_ item: CPTagViewItem?) -> ())?
    
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
    
    init(item: CPTagViewItem, generalAttributes: CPTagViewAttribute) {
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
        containerView.setFullOnSuperView()
        
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
        let rightSideImage = item.rightSideImage ?? generalAttributes.rightSideImage
        buttonClose.setImage(rightSideImage, for: .normal)
        
        self.buttonClose.isHidden = rightSideImage == nil
        labelTrailingConstraintWithView.isActive = rightSideImage == nil
        labelTrailingConstraintWithButton.isActive = rightSideImage != nil
        
        let sizeOfRightImage = item.sizeOfRightImage ?? self.generalAttributes.sizeOfRightImage
        heightOfButton?.constant = sizeOfRightImage.height
        widthOfButton?.constant = sizeOfRightImage.width
        
        labelTitle.font = item.isSelected ? generalAttributes.fonts.selected : generalAttributes.fonts.unSelected
        labelTitle.textColor = item.isSelected ? generalAttributes.textColor.selected : generalAttributes.textColor.unSelected
        containerView.backgroundColor = item.isSelected ? generalAttributes.tagBackgroundColor.selected : generalAttributes.tagBackgroundColor.unSelected
        containerView.layer.cornerRadius = generalAttributes.cornerRadius
        
        containerView.layer.borderWidth = generalAttributes.border.width
        containerView.layer.borderColor = generalAttributes.border.color.cgColor
        containerView.isUserInteractionEnabled = generalAttributes.userInteraction
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
