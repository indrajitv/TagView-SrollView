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
    
    private var item: TagViewItem?
    
    var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagViewItem?) -> ())?
    
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
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init(item: TagViewItem) {
        super.init(frame: .zero)
        self.item = item
        setupViews()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubviews(views: [labelTitle, buttonClose])
   
        buttonClose.setCenterY()
        heightOfButton = buttonClose.heightAnchor.constraint(equalToConstant: 0)
        widthOfButton = buttonClose.widthAnchor.constraint(equalToConstant: 0)
        heightOfButton.isActive = true
        widthOfButton.isActive = true
        
        buttonClose.setTrailing(with: self.trailingAnchor)
        
        labelTitle.setAnchors(top: topAnchor,
                              bottom: bottomAnchor,
                              leading: leadingAnchor)
        
        labelTrailingConstraintWithView = labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        labelTrailingConstraintWithButton = labelTitle.trailingAnchor.constraint(equalTo: self.buttonClose.leadingAnchor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectTag))
        self.addGestureRecognizer(tap)
    }
    
    private func configureCell() {
        guard let item = item else { return }
        
        labelTitle.text = item.title
        labelTitle.font = item.getFonts()
        labelTitle.textColor = item.getTextColor()
        buttonClose.setImage(item.rightSizeImage, for: .normal)
        backgroundColor = item.getBackground()
        
        self.buttonClose.isHidden = item.rightSizeImage == nil
        labelTrailingConstraintWithView.isActive = item.rightSizeImage == nil
        labelTrailingConstraintWithButton.isActive = item.rightSizeImage != nil
        
        heightOfButton?.constant = item.sizeOfRightImage.height
        widthOfButton?.constant = item.sizeOfRightImage.width
        
        self.layer.cornerRadius = item.cornerRadius
    }
    
    @objc private func buttonCloseClicked() {
        rightSideButtonClickObserver?(self.item)
    }
    
    @objc private func didSelectTag() {
        if let _item = item {
            _item.isSelected = !_item.isSelected
        }
        configureCell()
        itemClickObserver?(self.item)
    }
    
}
