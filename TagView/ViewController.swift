//
//  ViewController.swift
//  CPTagView
//
//  Created by Indrajit Chavda on 28/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tag1: CPTagsView = {
        var att = CPTagViewAttribute(
                                  textColor: (normal: .blue,
                                              selected: .black),
                                  tagBackgroundColor: (normal: .white, selected: .lightGray),
                                  fonts: (normal: UIFont.systemFont(ofSize: 12),
                                          selected: UIFont.systemFont(ofSize: 12)))
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        att.numberOfRow = 3
        return CPTagsView(attribute: att)
    }()
    
    lazy var tag2: CPTagsView = {
        var att = CPTagViewAttribute(
            textColor: (normal: .blue,
                        selected: .black),
            tagBackgroundColor: (normal: .white, selected: .lightGray),
            fonts: (normal: UIFont.systemFont(ofSize: 12),
                    selected: UIFont.systemFont(ofSize: 12)))
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        return CPTagsView(attribute: att)
    }()
    
    lazy var tag3: CPTagsView = {
        var att = CPTagViewAttribute(
            textColor: (normal: .blue,
                        selected: .black),
            tagBackgroundColor: (normal: .white, selected: .lightGray),
            fonts: (normal: UIFont.systemFont(ofSize: 12),
                    selected: UIFont.systemFont(ofSize: 12)))
        att.shadow = (.init(width: -1, height: 1), .black)
        att.rightSizeImageTint = .blue
        att.tagArrangement = .vertical
        return CPTagsView(attribute: att)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        self.view.addSubview(tag1)
        
        tag1.setHeight(height: 100)
        tag1.setAnchors(top: self.view.topAnchor,
                        leading: self.view.leadingAnchor,
                        trailing: self.view.trailingAnchor,
                        topConstant: 100)
        var array = [CPTagViewItem]()
        for i in 1...20 {
            if i == 1 {
                let item: CPTagViewItem = .init(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a", id: UUID().uuidString)
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

