//
//  TagViewCell.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

public class TagContainer: UIView {
    private var labelTrailingConstraintWithView,
                labelTrailingConstraintWithButton: NSLayoutConstraint!
    
    private var heightOfButton, widthOfButton: NSLayoutConstraint!
    
    private(set) var item: TagViewItem
    private var generalAttributes: TagViewAttribute
    
    public var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagContainer) -> ())?
    
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
    
    public init(item: TagViewItem, generalAttributes: TagViewAttribute) {
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
        if let rightSizeImageTint = generalAttributes.rightSizeImageTint {
            buttonClose.tintColor = rightSizeImageTint
            buttonClose.setImage(rightSideImage?.image.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            buttonClose.setImage(rightSideImage?.image, for: .normal)
        }
        
        self.buttonClose.isHidden = rightSideImage == nil
        labelTrailingConstraintWithView.isActive = rightSideImage == nil
        labelTrailingConstraintWithButton.isActive = rightSideImage != nil
        
        heightOfButton?.constant = rightSideImage?.size.height ?? 0
        widthOfButton?.constant = rightSideImage?.size.width ?? 0
        
        labelTitle.font = item.isSelected ? generalAttributes.fonts.selected : generalAttributes.fonts.normal
        labelTitle.textColor = item.isSelected ? generalAttributes.textColor.selected : generalAttributes.textColor.normal
        containerView.backgroundColor = item.isSelected ? generalAttributes.tagBackgroundColor.selected : generalAttributes.tagBackgroundColor.normal
        containerView.layer.cornerRadius = item.isSelected ? generalAttributes.cornerRadius.selected : generalAttributes.cornerRadius.normal
        
        let border = item.isSelected ? generalAttributes.border?.selected : generalAttributes.border?.normal
        containerView.layer.borderWidth = border?.width ?? 0
        containerView.layer.borderColor = border?.color.cgColor
        
        if let shadow = generalAttributes.shadow {
            containerView.layer.shadowColor = shadow.color.cgColor
            containerView.layer.shadowOpacity = generalAttributes.shadowOpacity
            containerView.layer.shadowOffset = shadow.offset
            containerView.layer.shadowRadius = containerView.layer.cornerRadius
        }
        
        self.isUserInteractionEnabled = generalAttributes.userInteraction
    }
    
    @objc private func buttonCloseClicked() {
        rightSideButtonClickObserver?(self)
    }
    
    @objc private func didSelectTag() {
        toggle()
        itemClickObserver?(self)
    }
    
    func toggle() {
        item.isSelected = !item.isSelected
        configureCell()
    }
    
}
