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
            self.collectionView.reloadData()
        }
    }
    
    var rightSideButtonClickObserver, itemClickObserver: ((_ item: TagViewItem?) -> ())?
    
    private lazy var collectionLayout: AlignedCollectionViewFlowLayout = {
        let layout = AlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = self.attribute.spacingBetweenRows
        layout.minimumLineSpacing = 0
        return layout
    }()
    
     lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: self.collectionLayout)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(TagViewCell.self, forCellWithReuseIdentifier: TagViewCell.cellId)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .lightGray
        cv.contentInset = .init(top: 0,
                                left: self.attribute.spacingBetweenRows,
                                bottom: 0,
                                right: self.attribute.spacingBetweenRows)
        return cv
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
        
        self.addSubviews(views: [collectionView])
        collectionView.setFullOnSuperView()
    }
}
