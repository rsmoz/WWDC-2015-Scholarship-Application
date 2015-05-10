//
//  AstoundingImageView.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/21/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

@IBDesignable class AstoundingImageView: UIView {
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    @IBInspectable var imageViewSizeRatio: CGFloat = 0.9

    
    @IBInspectable var format: UIViewContentMode = UIViewContentMode.Top {
        didSet {
            self.imageView.contentMode = format
        }
    }
    
    @IBInspectable var maskImage: Bool = true {
        didSet {
            self.imageView.layer.masksToBounds = maskImage
        }
    }
    
    private let imageView = UIImageView()
    
//    var dynamicallyAdjustImageViewSize = true
    
    static let standardSize = CGSize(width: 100, height: 100)
    static let miniSize = CGSize(width: 45, height: 45)
    
    init(image inImage: UIImage?) {
        let rect = CGRect(x: 0, y: 0, width: AstoundingImageView.standardSize.width, height: AstoundingImageView.standardSize.height)
        image = inImage
        super.init(frame: rect)
        setup()
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    func setup() {
        backgroundColor = .whiteColor()
        imageView.image = image
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.size.width / 2
        
        
//        if dynamicallyAdjustImageViewSize {
            imageView.frame = CGRect(x: 0, y: 0, width: frame.width * imageViewSizeRatio, height: frame.height * imageViewSizeRatio)
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
//        }
        
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        imageView.layer.masksToBounds = maskImage
        
    }

}
