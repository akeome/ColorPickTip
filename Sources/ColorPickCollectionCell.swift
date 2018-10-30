//
//  ColorPickCollectionCell.swift
//  ColorPickTip
//
//  Created by 山下優樹 on 2018/10/30.
//

import UIKit

// MARK: - カスタムセル

/// カスタムセルの定義
final internal class ColorPickCollectionCell: UICollectionViewCell {
    
    internal var palette: UIView!
    internal var style: ColorPickTip.Options.PaletteStyle = .round
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                guard self.palette.backgroundColor != nil else { return }
                self.palette.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 0.9960784314, alpha: 1).cgColor
                self.palette.layer.borderWidth = 2
            } else {
                self.palette.layer.borderColor = UIColor.clear.cgColor
                self.palette.layer.borderWidth = 0
            }
        }
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.palette = UIView()
        self.addSubview(palette)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setColor(color: UIColor?) {
        if let color = color {
            self.palette.backgroundColor = color
        }
        
    }
    internal func getColor() -> UIColor? {
        return self.palette.backgroundColor
    }
    
    override func layoutSubviews() {
        
        let side = min(self.bounds.width, self.bounds.height)
        self.palette.frame.size = CGSize(width: side / 2, height: side / 2)
        self.palette.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        self.palette.layer.cornerRadius = {
            switch style {
            case .round:
                return self.palette.frame.width / 2
            case .square:
                return 3
            }
        }()
    }
    
}
