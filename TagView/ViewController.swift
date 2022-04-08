//
//  ViewController.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tag1: TagsView = {
        var att = TagViewAttribute(
                                  textColor: (normal: .blue,
                                              selected: .black),
                                  tagBackgroundColor: (normal: .white, selected: .lightGray),
                                  fonts: (normal: UIFont.systemFont(ofSize: 12),
                                          selected: UIFont.systemFont(ofSize: 12)))
        att.removeItemOnRightImageClick = true
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        att.numberOfRow = 3
        att.background = .darkGray
        att.rightSideImage = (UIImage(imageLiteralResourceName: "close"), .init(width: 20, height: 20))
        att.autoHeightAdjustmentOfContainerFromContentSize = true
        att.paddingAroundEdges = .init(top: 10, left: 10, bottom: 10, right: 10)
        return TagsView(attribute: att)
    }()
    
    lazy var tag2: TagsView = {
        var att = TagViewAttribute(
            textColor: (normal: .blue,
                        selected: .black),
            tagBackgroundColor: (normal: .white, selected: .lightGray),
            fonts: (normal: UIFont.systemFont(ofSize: 12),
                    selected: UIFont.systemFont(ofSize: 12)))
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        att.background = .gray
        att.autoHeightAdjustmentOfContainerFromContentSize = true
        att.removeItemOnRightImageClick = true
        att.rightSideImage = (UIImage(imageLiteralResourceName: "close"), .init(width: 20, height: 20))
        att.paddingAroundEdges = .init(top: 10, left: 10, bottom: 10, right: 10)
        return TagsView(attribute: att)
    }()
    
    lazy var tag3: TagsView = {
        var att = TagViewAttribute(
            textColor: (normal: .blue,
                        selected: .black),
            tagBackgroundColor: (normal: .white, selected: .lightGray),
            fonts: (normal: UIFont.systemFont(ofSize: 12),
                    selected: UIFont.systemFont(ofSize: 12)))
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        att.tagArrangement = .vertical
        att.autoHeightAdjustmentOfContainerFromContentSize = true
        att.removeItemOnRightImageClick = true
        att.background = .red
        att.rightSideImage = (UIImage(imageLiteralResourceName: "close"), .init(width: 20, height: 20))
        att.paddingAroundEdges = .init(top: 10, left: 10, bottom: 10, right: 10)
        return TagsView(attribute: att)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGray
        self.view.addSubview(tag1)
        
        tag1.setHeight(height: 100)
        tag1.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 70,leadingConstant: 10, trailingConstant: -10)
        var array = [TagViewItem]()
        
        for i in 1...20 {
            if i == 1 {
                let item: TagViewItem = .init(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a", id: UUID().uuidString)
                item.roundBadge = (12, .blue)
                item.rightSideImage = (image: UIImage(imageLiteralResourceName: "close"), size: .init(width: 20, height: 20))
                array.append(item)
            } else {
                array.append(.init(title: randomWord() + " \(i)", id: UUID().uuidString))
            }
            
        }
        tag1.items = array
        
        tag1.itemClickObserver = { item, index in
            print("did select cell", item?.title ?? "-")
        }
        
        tag1.rightSideButtonClickObserver = { item, index in
            print("did select button", item?.title ?? "-")
        }
        
        self.view.addSubview(tag2)
        
        tag2.setHeight(height: 50)
        tag2.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 200, leadingConstant: 10, trailingConstant: -10)
        tag2.items = array
        
        self.view.addSubview(tag3)
        
        tag3.setHeight(height: 150)
        tag3.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 280,leadingConstant: 10, trailingConstant: -10)
        tag3.items = array
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

