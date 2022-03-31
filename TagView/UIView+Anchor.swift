import UIKit

public let isPad = UIDevice.current.userInterfaceIdiom == .pad

public extension UIView {
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
    
    func setAnchors(top: NSLayoutYAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    spacing: CGFloat = 0) {
        if let value = leading {
            setLeading(with: value, constant: spacing)
        }
        if let value = trailing {
            setTrailing(with: value, constant: -spacing)
        }
        if let value = top {
            setTop(with: value, constant: spacing)
        }
        if let value = bottom {
            setBottom(with: value, constant: -spacing)
        }
    }
    
    func setAnchors(top: NSLayoutYAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil) {
        if let value = leading {
            setLeading(with: value, constant: 0)
        }
        if let value = trailing {
            setTrailing(with: value, constant: 0)
        }
        if let value = top {
            setTop(with: value, constant: 0)
        }
        if let value = bottom {
            setBottom(with: value, constant: 0)
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
    
    func setWidth(width: NSLayoutDimension, multiplier: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: width, multiplier: multiplier).isActive = true
    }
    
    func setHeightAndWidth(height: CGFloat, width: CGFloat) {
        setHeight(height: height)
        setWidth(width: width)
    }
    
    func setHeightAndWidth(height: NSLayoutDimension, width: NSLayoutDimension) {
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
    
    func setTopGreaterThanOrEqualTo(with: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(greaterThanOrEqualTo: with, constant: constant).isActive = true
    }
    
    func setTopLessThanOrEqualTo(with: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(lessThanOrEqualTo: with, constant: constant).isActive = true
    }
    
    func setBottom(with: NSLayoutYAxisAnchor,constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setBottomGreaterThanOrEqualTo(with: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(greaterThanOrEqualTo: with, constant: constant).isActive = true
    }
    
    func setTrailingGreaterThanOrEqualTo(with: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(greaterThanOrEqualTo: with, constant: constant).isActive = true
    }
    
    func setLeadingGreaterThanOrEqualTo(with: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(greaterThanOrEqualTo: with, constant: constant).isActive = true
    }
    
    func setFullOnSuperView(safeArea: Bool = true) {
        if let superViewOfThis = superview {
            if safeArea, #available(iOS 11.0, *) {
                self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor)
                self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor)
                self.setLeading(with: superViewOfThis.safeAreaLayoutGuide.leadingAnchor)
                self.setTrailing(with: superViewOfThis.safeAreaLayoutGuide.trailingAnchor)
            } else {
                self.setTop(with: superViewOfThis.topAnchor)
                self.setBottom(with: superViewOfThis.bottomAnchor)
                self.setLeading(with: superViewOfThis.leadingAnchor)
                self.setTrailing(with: superViewOfThis.trailingAnchor)
            }
            
        }
    }
    
    func setFullOnSuperView(withTopBottomSpacing: CGFloat) {
        if let superViewOfThis = superview {
            if #available(iOS 11.0, *) {
                self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor,
                            constant: withTopBottomSpacing)
                self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor,
                               constant: -withTopBottomSpacing)
                self.setLeading(with: superViewOfThis.safeAreaLayoutGuide.leadingAnchor)
                self.setTrailing(with: superViewOfThis.safeAreaLayoutGuide.trailingAnchor)
            } else {
                self.setTop(with: superViewOfThis.topAnchor,
                            constant: withTopBottomSpacing)
                self.setBottom(with: superViewOfThis.bottomAnchor,
                               constant: -withTopBottomSpacing)
                self.setLeading(with: superViewOfThis.leadingAnchor)
                self.setTrailing(with: superViewOfThis.trailingAnchor)
            }
            
        }
    }
    
    func setFullOnSuperView(withLeftRightSpacing: CGFloat) {
        if let superViewOfThis = superview {
            if #available(iOS 11.0, *) {
                self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor)
                self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor)
                self.setLeading(with: superViewOfThis.safeAreaLayoutGuide.leadingAnchor,
                                constant: withLeftRightSpacing)
                self.setTrailing(with: superViewOfThis.safeAreaLayoutGuide.trailingAnchor,
                                 constant: -withLeftRightSpacing)
            } else {
                self.setTop(with: superViewOfThis.topAnchor)
                self.setBottom(with: superViewOfThis.bottomAnchor)
                self.setLeading(with: superViewOfThis.leadingAnchor,
                                constant: withLeftRightSpacing)
                self.setTrailing(with: superViewOfThis.trailingAnchor,
                                 constant: -withLeftRightSpacing)
            }
            
        }
    }
    
    func setFullOnSuperView(withSpacing: CGFloat) {
        if let superViewOfThis = superview {
            if #available(iOS 11.0, *) {
                self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor,
                            constant: withSpacing)
                self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor,
                               constant: -withSpacing)
                self.setLeading(with: superViewOfThis.safeAreaLayoutGuide.leadingAnchor,
                                constant: withSpacing)
                self.setTrailing(with: superViewOfThis.safeAreaLayoutGuide.trailingAnchor,
                                 constant: -withSpacing)
            } else {
                self.setTop(with: superViewOfThis.topAnchor,
                            constant: withSpacing)
                self.setBottom(with: superViewOfThis.bottomAnchor,
                               constant: -withSpacing)
                self.setLeading(with: superViewOfThis.leadingAnchor,
                                constant: withSpacing)
                self.setTrailing(with: superViewOfThis.trailingAnchor,
                                 constant: -withSpacing)
            }
            
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
    
    func setCenterY(constant: CGFloat) {
        if let superViewOfThis = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                self.centerYAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerYAnchor,
                                              constant: constant).isActive = true
            } else {
                self.centerYAnchor.constraint(equalTo: superViewOfThis.centerYAnchor,
                                              constant: constant).isActive = true
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
    
    func setCenterX(constant: CGFloat) {
        if let superViewOfThis = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                self.centerXAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerXAnchor,
                                              constant: constant).isActive = true
            } else {
                self.centerXAnchor.constraint(equalTo: superViewOfThis.centerXAnchor,
                                              constant: 0).isActive = true
            }
        }
    }
    
    func setCenterXto(xAnchor:NSLayoutXAxisAnchor, constant:CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: xAnchor,
                                      constant: constant).isActive = true
    }
    
    func setCenterYto(yAnchor:NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: yAnchor,
                                      constant: constant).isActive = true
    }
    
    func setCenterXto(with view: UIView,
                      relatedBy: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self,
                           attribute: .centerX,
                           relatedBy: relatedBy,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: multiplier,
                           constant: constant).isActive = true
    }
    
    func setCenterYto(with view: UIView,
                      relatedBy: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self,
                           attribute: .centerY,
                           relatedBy: relatedBy,
                           toItem: view,
                           attribute: .centerY,
                           multiplier: multiplier,
                           constant: constant).isActive = true
    }
    
    func setCenter(){
        setCenterX()
        setCenterY()
    }
    
    func setCenter(xConstant: CGFloat, yConstant: CGFloat) {
        setCenterX(constant: xConstant)
        setCenterY(constant: yConstant)
    }
    
    func getLeadingConstraint(with constraint: NSLayoutXAxisAnchor, constant: CGFloat?) -> NSLayoutConstraint {
        if let constantValue = constant {
            return self.leadingAnchor.constraint(equalTo: constraint, constant: constantValue)
        }
        return self.leadingAnchor.constraint(equalTo: constraint)
    }
    
    func getLeftConstraint(with constraint: NSLayoutXAxisAnchor, constant: CGFloat?) -> NSLayoutConstraint {
        if let constantValue = constant {
            return self.leftAnchor.constraint(equalTo: constraint, constant: constantValue)
        }
        return self.leftAnchor.constraint(equalTo: constraint)
    }
    
    func getTrailingConstraint(with constraint: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        return self.trailingAnchor.constraint(equalTo: constraint, constant: constant)
    }
    
    func getRightConstraint(with constraint: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        return self.rightAnchor.constraint(equalTo: constraint, constant: constant)
    }
    
    func getBottomConstraint(with constraint: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        return self.bottomAnchor.constraint(equalTo: constraint, constant: constant)
    }
    
    func getTopConstraint(with constraint: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return self.topAnchor.constraint(equalTo: constraint)
    }
    
    func getWidthConstraint(with constant: CGFloat) -> NSLayoutConstraint {
        return self.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
    }
    
    func setWidthGreaterThanOrEqual(constant: CGFloat) {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    func setHeightGreaterThanOrEqual(constant: CGFloat) {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    func setWidthLessThanOrEqual(constant: CGFloat) {
        self.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    func setHeightLessThanOrEqual(constant: CGFloat) {
        self.heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    func getHeightConstraint(with constant: CGFloat) -> NSLayoutConstraint {
        return self.heightAnchor.constraint(equalToConstant: constant)
    }
    
    func getHeightConstraintOfView(with constraint: NSLayoutDimension) -> NSLayoutConstraint {
        return self.heightAnchor.constraint(equalTo: constraint)
    }
    
    func getWidthConstraintOfView(with constraint: NSLayoutDimension) -> NSLayoutConstraint {
        return self.widthAnchor.constraint(equalTo: constraint)
    }
    
}

