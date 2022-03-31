//
//  TagViewCell.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class TagViewCell: UICollectionViewCell {
    
    static let cellId: String = UUID().uuidString
    
    var labelTrailingConstraintWithView,
        labelTrailingConstraintWithButton: NSLayoutConstraint!
  
    var heightOfButton, widthOfButton: NSLayoutConstraint!
    
    var item: TagViewItem? {
        didSet {
            configureCell()
        }
    }
    
    var rightSideButtonClickObserver: ((_ item: TagViewItem?) -> ())?
    
    lazy var buttonClose: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.buttonCloseClicked),
                         for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets.right = 8
        return button
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelTitle.text = nil
        labelTitle.font = nil
        labelTitle.textColor = nil
        buttonClose.setImage(nil, for: [])
        backgroundColor = nil
        self.buttonClose.isHidden = true
        heightOfButton?.constant = 0
        widthOfButton?.constant = 0
    }
    
    func setupViews() {
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
    }
    
    func configureCell() {
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
    }
    
    @objc func buttonCloseClicked() {
        rightSideButtonClickObserver?(self.item)
    }
}
