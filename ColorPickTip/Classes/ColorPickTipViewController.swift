//
//  ColorPickTipViewController.swift
//  ColorPickTip
//
//  Created by 山下優樹 on 2018/10/26.
//

import UIKit

protocol ColorPickTipDelegate: class {
    func colorPickTip(_ colorPickTip: ColorPickTip, pickedColor: UIColor?, index: Int)
}

// Controller
open class ColorPickTipController: UIViewController {
    
    private var palette = [[UIColor?]]()
    internal var options: ColorPickTip.Options
    public var selected: ((_ color: UIColor?, _ index: Int)->())?
    
    public init(palette: [[UIColor?]] ,options: ColorPickTip.Options?) {
        
        self.palette = palette
        self.options = options ?? ColorPickTip.Options()
        
        super.init(nibName: nil, bundle: nil)
        
        if self.options.viewSize == CGSize.zero {
            // Default size
            self.options.viewSize.width = 240
            self.options.viewSize.height = 150
        }
        
        self.modalPresentationStyle = .popover
        
        
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // size for popover
        self.preferredContentSize = CGSize(width: options.viewSize.width, height: options.viewSize.height)
        
        self.popoverPresentationController?.backgroundColor = {
            switch options.popoverViewTheme {
            case .light: return #colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9490196078, alpha: 0.7997110445)
            case .dark: return #colorLiteral(red: 0.1647058824, green: 0.168627451, blue: 0.1843137255, alpha: 0.8045804795)
            }
        }()
        
        let viewSize = CGSize(width: self.preferredContentSize.width, height: self.preferredContentSize.height)
        let colorPickTip = ColorPickTip(viewSize: viewSize, palette: self.palette, options: options)
        colorPickTip.delegate = self
        
        self.view.addSubview(colorPickTip)
        
    }
    
}


// popover for iPhone
extension ColorPickTipController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}


extension ColorPickTipController: ColorPickTipDelegate {
    func colorPickTip(_ colorPickTip: ColorPickTip, pickedColor: UIColor?, index: Int) {
        
        self.selected?(pickedColor, index)
        
        if options.isDismissOnPick {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
