//
//  ViewController.swift
//  TagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tag1 = TagView(attribute: TagViewAttribute(background: .lightGray, spacingBetweenRows: 4, tagArrangement: .splitInColumn, removeItemOnRightImageClick: false, numberOfRow: 2, textColor: (selected: .black, unSelected: .black), tagBackgroundColor: (selected: .yellow, unSelected: .yellow), fonts: (selected: UIFont.systemFont(ofSize: 12), unSelected: UIFont.systemFont(ofSize: 12)),
                                                   sizeCalculationType: .auto(extraWidth: 10), cornerRadius: 3))
    
    let tag2 = TagView(attribute: TagViewAttribute(background: .lightGray, spacingBetweenRows: 8, tagArrangement: .splitInColumn, removeItemOnRightImageClick: false, numberOfRow: 1, textColor: (selected: .black, unSelected: .black), tagBackgroundColor: (selected: .yellow, unSelected: .yellow), fonts: (selected: UIFont.systemFont(ofSize: 12), unSelected: UIFont.systemFont(ofSize: 12)),
                                                   sizeCalculationType: .auto(extraWidth: 10), cornerRadius: 3))
    
    let tag3 = TagView(attribute: TagViewAttribute(background: .lightGray, spacingBetweenRows: 8, tagArrangement: .splitInColumn, removeItemOnRightImageClick: false, numberOfRow: 3, textColor: (selected: .black, unSelected: .black), tagBackgroundColor: (selected: .yellow, unSelected: .yellow), fonts: (selected: UIFont.systemFont(ofSize: 12), unSelected: UIFont.systemFont(ofSize: 12)),
                                                   sizeCalculationType: .auto(extraWidth: 10), cornerRadius: 3))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tag1)
        
        tag1.setHeight(height: 100)
        tag1.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 100)
        var array = [TagViewItem]()
        for i in 1...20 {
            if i == 1 {
                array.append(.init(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a", id: UUID().uuidString, rightSizeImage: UIImage(named: "close")))
            } else {
                array.append(.init(title: randomWord() + " \(i)", id: UUID().uuidString, rightSizeImage: UIImage(named: "close")))
            }
            
        }
        tag1.items = array
        
        tag1.itemClickObserver = { item in
            print("did select cell", item?.title ?? "-")
        }
        
        tag1.rightSideButtonClickObserver = { item in
            print("did select button", item?.title ?? "-")
        }
        
        self.view.addSubview(tag2)
        
        tag2.setHeight(height: 50)
        tag2.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 250)
        tag2.items = tag1.items
        
        self.view.addSubview(tag3)
        
        tag3.setHeight(height: 150)
        tag3.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 350)
        tag3.items = tag1.items
    }
    
    func randomWord() -> String {
        var x = ""
        for _ in 0..<Int.random(in: 5...30){
            let string = String(format: "%c", Int.random(in: 97..<123)) as String
            x+=string
        }
        return x
    }
}

