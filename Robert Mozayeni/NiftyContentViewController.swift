//
//  NiftyContentViewController.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/20/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

class NiftyContentViewController: UIViewController, UITextViewDelegate {
    
    lazy var textV: UITextView = {
        let result = UITextView()
        result.contentInset = UIEdgeInsets(top: 210, left: 0, bottom: 100, right: 0)
        result.editable = false
        result.font = UIFont(name: "Helvetica", size: 25)
        result.textColor = .whiteColor()
        result.backgroundColor = .clearColor()
        result.scrollIndicatorInsets = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        return result
    }()
    
    lazy var bar: UIToolbar = {
        let result = UIToolbar()
        result.barStyle = .Black
        result.alpha = 0
        result.translucent = true
        return result
    }()
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont(name: "Helvetica", size: 30)
        result.numberOfLines = 1
        result.textColor = .whiteColor()
        result.textAlignment = .Center
//        result.backgroundColor = .redColor()
        return result
    }()
    
//    let titleLabelHome = CGRect(x: 0, y: 0, width: 290, height: 45)
//    let titleLabelTarget = CGRect(x: 80, y: 25, width: 280, height: 45)
    
    let displayImageView: AstoundingImageView
    
    
    let titleText: String
    let bodyText: String
    let displayImage: UIImage!
    let destination: Action?
    
    init(info: Card) {
        titleText = info.title
        bodyText = info.body
        displayImage = UIImage(named: titleText)
        displayImageView = AstoundingImageView(image: displayImage) //Convenience init
        destination = info.destination
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) { //Actually restore here
        titleText = "PLACEHOLDER"
        bodyText = "PLACEHOLDER"
        displayImage = nil
        displayImageView = AstoundingImageView(image: displayImage)
        destination = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        textV.frame = view.frame
        textV.text = bodyText
        textV.delegate = self
        
        titleLabel.frame.size = CGSize(width: 250, height: 45)
        titleLabel.center = CGPoint(x: view.bounds.midX, y: (displayImage != nil) ? 175 : 100)
        titleLabel.text = titleText
        
        bar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80)
        
//        displayImageView.frame = displayImageViewHome
        displayImageView.center = CGPoint(x: view.bounds.midX, y: 99)
        
        view.backgroundColor = .clearColor()
        /////////////////////////////////////////////////
        
        let blr = UIBlurEffect(style: .Dark)
        let blrView = UIVisualEffectView(effect: blr)
        
        let vib = UIVibrancyEffect(forBlurEffect: blr)
        let vibView = UIVisualEffectView(effect: vib)
        
        
        blrView.frame = view.bounds
        vibView.frame = view.bounds
        
        //        blrView.contentView.addSubview(vibView)
        //        vibView.contentView.addSubview(textV)
        
        
        
        blrView.contentView.addSubview(textV)
        blrView.contentView.addSubview(bar)
        blrView.contentView.addSubview(titleLabel)
        
        
        if displayImage != nil {
            blrView.contentView.addSubview(displayImageView)
        }
        
        if let go = destination {
            let btn = UIButton(frame: CGRect(x: view.bounds.width - 65, y: 14, width: 56, height: 56))
            btn.setImage(UIImage(named: "link"), forState: .Normal)
            btn.addTarget(self, action: "openIt", forControlEvents: .TouchUpInside)
            blrView.contentView.addSubview(btn)
        }
        
        view.addSubview(blrView)
        
        
    }
    
    func openIt() {
        performAction(destination!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let dst = scrollView.contentOffset.y
        
        //For imageView, adjust size and reset the center here
        
        let start: CGFloat = -199
        let end: CGFloat = -100
        //progressBetweenTwoPoints with over -> max and min bounds
        let diff = abs(start - end)
        
        let startLabel = CGPoint(x: view.bounds.midX, y: (displayImage != nil) ? 175 : 100)
        let endLabel = CGPoint(x: view.frame.midX, y: 40)
        
        let startIm = CGPoint(x: view.bounds.midX, y: 99)
        let endIm = CGPoint(x: 35, y: 39)
        
        //Fall back on a specific part here if in the middle
        if dst < start {
            bar.alpha = 0
            
//            titleLabel.frame = titleLabelHome
            titleLabel.center = startLabel
            
            displayImageView.center = startIm
            displayImageView.frame.size = AstoundingImageView.standardSize
        }
        else if dst > end {
            bar.alpha = 1
            
            titleLabel.center = endLabel
            
            displayImageView.center = endIm
            displayImageView.frame.size = AstoundingImageView.miniSize
        }
        else {
            let change = dst - start
            let ratio = change / diff
            bar.alpha = ratio
//            println(ratio)
            let intermediateSize = interpolated(AstoundingImageView.standardSize, AstoundingImageView.miniSize, byRatio: Double(ratio))
            
            let intermediateCoordinate = interpolated(startIm, endIm, byRatio: Double(ratio))
            
            displayImageView.center = intermediateCoordinate!
            displayImageView.frame.size = intermediateSize!
            
            let imLoc = interpolated(startLabel, endLabel, byRatio: Double(ratio))
            
            titleLabel.center = imLoc!
            
        }
        
    }
    
    
}
