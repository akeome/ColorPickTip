//
//  ViewController.swift
//  ColorPickTip
//
//  Created by akeome on 10/26/2018.
//  Copyright (c) 2018 akeome. All rights reserved.
//

import UIKit
import ColorPickTip

class ViewController: UIViewController {

    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var paletteStyleSegment: UISegmentedControl!
    @IBOutlet weak var colorPaletteSegment: UISegmentedControl!
    @IBOutlet weak var dismissSwitch: UISwitch!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 10
        
        colorPaletteSegment.selectedSegmentIndex = 2
        
        widthSlider.minimumValue = 50
        widthSlider.maximumValue = Float(self.view.frame.width * 0.95)
        widthSlider.value = 240
        heightSlider.minimumValue = 50
        heightSlider.maximumValue = Float(self.view.frame.height * 0.8)
        heightSlider.value = 150
    }
    
    @IBAction func widthChanged(_ sender: UISlider) {
        widthLabel.text = Int(sender.value).description
    }
    
    @IBAction func heightChanged(_ sender: UISlider) {
        heightLabel.text = Int(sender.value).description
    }
    
    
    
    // in case of UIButton
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let paletteColors = SamplePalettes.getPalettes(index: colorPaletteSegment.selectedSegmentIndex)
        
        var options = ColorPickTip.Options()
        options.popoverViewTheme = ColorPickTip.Options.PopoverViewTheme(rawValue: themeSegment.selectedSegmentIndex)!
        options.paletteStyle = ColorPickTip.Options.PaletteStyle(rawValue: paletteStyleSegment.selectedSegmentIndex)!
        options.isDismissOnPick = dismissSwitch.isOn
        options.viewSize = CGSize(width: CGFloat(widthSlider.value), height: CGFloat(heightSlider.value))
        
        let colorPickTipVC = ColorPickTipController(palette: paletteColors, options: options)
        colorPickTipVC.popoverPresentationController?.delegate = colorPickTipVC
        colorPickTipVC.popoverPresentationController?.sourceView = sender
        colorPickTipVC.popoverPresentationController?.sourceRect = sender.bounds
        
        self.present(colorPickTipVC, animated: true, completion: nil)
        
        
        
        colorPickTipVC.selected = {
            color in
            guard color != nil else {return}
            self.button.backgroundColor = color
            self.view.tintColor = color
            self.dismissSwitch.onTintColor = color
            self.navigationItem.rightBarButtonItem?.tintColor = color
        }
        
    }
    
    
    // in case of UIBarButtonItem
    @IBAction func barAction(_ sender: UIBarButtonItem) {
        let paletteColors = SamplePalettes.getPalettes(index: colorPaletteSegment.selectedSegmentIndex)
        
        var options = ColorPickTip.Options()
        options.popoverViewTheme = ColorPickTip.Options.PopoverViewTheme(rawValue: themeSegment.selectedSegmentIndex)!
        options.paletteStyle = ColorPickTip.Options.PaletteStyle(rawValue: paletteStyleSegment.selectedSegmentIndex)!
        options.isDismissOnPick = dismissSwitch.isOn
        options.viewSize = CGSize(width: CGFloat(widthSlider.value), height: CGFloat(heightSlider.value))
        
        let colorPickTipVC = ColorPickTipController(palette: paletteColors, options: options)
        colorPickTipVC.popoverPresentationController?.delegate = colorPickTipVC
        // Not set to sourceView but barButtonItem
        colorPickTipVC.popoverPresentationController?.barButtonItem = sender
        
        self.present(colorPickTipVC, animated: true, completion: nil)
        
        
        
        colorPickTipVC.selected = {
            color in
            guard color != nil else {return}
            self.button.backgroundColor = color
            self.view.tintColor = color
            self.dismissSwitch.onTintColor = color
            self.navigationItem.rightBarButtonItem?.tintColor = color
        }
        
    }
    
    
}
