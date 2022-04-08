import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach({ addSubview($0) })
    }
    
    func setAnchors(top: NSLayoutYAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    topConstant: CGFloat = 0,
                    bottomConstant: CGFloat = 0,
                    leadingConstant: CGFloat = 0,
                    trailingConstant: CGFloat = 0) {
        if let value = leading {
            setLeading(with: value, constant: leadingConstant)
        }
        if let value = trailing {
            setTrailing(with: value, constant: trailingConstant)
        }
        if let value = top {
            setTop(with: value, constant: topConstant)
        }
        if let value = bottom {
            setBottom(with: value, constant: bottomConstant)
        }
    }
    
    func setHeight(height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setHeight(height: NSLayoutDimension, multiplier: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: height, multiplier: multiplier).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
   
    func setHeightAndWidth(height: CGFloat, width: CGFloat) {
        setHeight(height: height)
        setWidth(width: width)
    }
    
    
    func setTrailing(with: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setLeading(with: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setTop(with:NSLayoutYAxisAnchor, constant:CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setBottom(with: NSLayoutYAxisAnchor,constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setFullOnSuperView(safeArea: Bool = true) {
        if let superViewOfThis = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superViewOfThis.topAnchor),
                self.bottomAnchor.constraint(equalTo: superViewOfThis.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: superViewOfThis.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: superViewOfThis.trailingAnchor)
            ])
        }
    }
  
    func setCenterY() {
        if let superViewOfThis = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                self.centerYAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerYAnchor,
                                              constant: 0).isActive = true
            } else {
                self.centerYAnchor.constraint(equalTo: superViewOfThis.centerYAnchor,
                                              constant: 0).isActive = true
            }
        }
    }
  
    func setCenterX() {
        if let superViewOfThis = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                self.centerXAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerXAnchor,
                                              constant: 0).isActive = true
            } else {
                self.centerXAnchor.constraint(equalTo: superViewOfThis.centerXAnchor,
                                              constant: 0).isActive = true
            }
        }
    }
    
}

