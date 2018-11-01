//
//  ColorPickTipView.swift
//  ColorPickTip
//
//  Created by 山下優樹 on 2018/10/26.
//

import UIKit

public class ColorPickTip: UIView {
    
    
    weak internal var delegate: ColorPickTipDelegate?
    fileprivate var colors:[[UIColor?]]
    internal var style: Options.PaletteStyle
    
    internal init(viewSize: CGSize, palette: [[UIColor?]], options: Options) {
        
        self.colors = palette
        self.style = options.paletteStyle
        
        super.init(frame: CGRect.zero)
        
        // set self frame
        self.frame = CGRect(x: viewSize.width * 0.05, y: viewSize.height * 0.1, width: viewSize.width * 0.9, height: viewSize.height * 0.8)
        
        // setting layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let col = self.colors.max(by: {$0.count < $1.count})?.count ?? 0
        let row = self.colors.count
        layout.itemSize = CGSize(width: (self.frame.width ) / CGFloat(col), height: (self.frame.height) / CGFloat(row))
        
        // create CollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        
        // resist cell
        collectionView.register(ColorPickCollectionCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Options
    
    
    public struct Options {
        
        /// Theme color of PopupView. Default is light.
        public var popoverViewTheme: PopoverViewTheme
        
        /// Style for color palette. Default is round.
        public var paletteStyle: PaletteStyle
        
        /// Dismiss popover after picked. Default is true.
        public var isDismissOnPick: Bool
        
        /// ViewSize. Default is width:240 / height:150.
        public var viewSize: CGSize
        
        public init(popupViewTheme: PopoverViewTheme = .light,
             paletteStyle: PaletteStyle = .round,
             isDismissOnPick: Bool = true,
             viewSize: CGSize = CGSize.zero) {
            self.popoverViewTheme = popupViewTheme
            self.paletteStyle = paletteStyle
            self.isDismissOnPick = isDismissOnPick
            self.viewSize = viewSize
            
        }
        
        
        public enum PopoverViewTheme: Int {
            case light
            case dark
        }
        
        public enum PaletteStyle: Int {
            case round
            case square
        }
        
    }
    
}



// MARK: - stubs for UICollectionView
extension ColorPickTip: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    // cell count
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.flatMap({$0}).count
    }
    
    // return cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! ColorPickCollectionCell
        cell.style = self.style
        
        let paletteColors = self.colors.flatMap({$0})
        let color = paletteColors.indices.contains(indexPath.row) ? paletteColors[indexPath.row] : nil
        cell.setColor(color: color)
        
        return cell
    }
    
    // did select cell
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorPickCollectionCell
        self.delegate?.colorPickTip(self, pickedColor: cell.getColor(), index: indexPath.row)
        
    }
    
}




