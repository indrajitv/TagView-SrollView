//
//  ViewController.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tag1 = TagView(attribute: TagViewAttribute())
    
    let tag2 = TagView(attribute: TagViewAttribute(numberOfRow: 1))
    
    let tag3 = TagView(attribute: TagViewAttribute(numberOfRow: 3, spacingBetweenRows: 16))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tag1)
        
        tag1.setHeight(height: 70)
        tag1.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 100)
        
        tag1.items = [
            
            .init(title: "1 Something Important", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .black), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "2 Some random string", id: "Item1", rightSizeImage: nil, textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "3 Student subjects", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "4 Course overview is done", id: "Item1", rightSizeImage: nil, textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "5 showCrossButton", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "6 systemFont", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "7 background", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "8 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "9 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "10 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "11 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "12 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "13 Long text long long text to test", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "14 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "15 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "16 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "17 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "18 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "19 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
            
                .init(title: "20 Item", id: "Item1", rightSizeImage: UIImage(named: "close"), textColor: (selected: .black, unSelected: .darkGray), backgroundColor: (selected: .yellow, unSelected: .systemRed), fonts: (selected: .systemFont(ofSize: 14, weight: .bold), unSelected: .systemFont(ofSize: 14, weight: .regular)), isSelected: false),
        ]
        
        tag1.itemClickObserver = { item in
            print("did select cell", item?.title ?? "-")
        }
        
        tag1.rightSideButtonClickObserver = { item in
            print("did select button", item?.title ?? "-")
        }
        
        self.view.addSubview(tag2)
        
        tag2.setHeight(height: 35)
        tag2.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 400)
        tag2.items = tag1.items
//        
        self.view.addSubview(tag3)
        
        tag3.setHeight(height: 130)
        tag3.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 600)
        tag3.items = tag1.items
    }
}
