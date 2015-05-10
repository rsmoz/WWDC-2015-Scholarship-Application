//
//  ExcellentMenuViewController.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/23/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

class ExcellentMenuViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIViewControllerTransitioningDelegate
{
    
    let colors = [(52, 152, 219), (46, 204, 113), (231, 76, 60), (26, 188, 156)].map { UIColor(tuple: $0) }
    
    @IBOutlet var myCV: UICollectionView!
    @IBOutlet var headView: AstoundingImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var heroImageView: UIImageView!
    
    var currentPoint: CGPoint!
    var transitionColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.textColor = .whiteColor()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        myCV.dataSource = self
        myCV.delegate = self
        
        let blr = UIBlurEffect(style: .Dark)
        let blrView = UIVisualEffectView(effect: blr)
        
        
        blrView.frame = view.bounds
        
        view.addSubview(blrView)
        view.sendSubviewToBack(blrView)
        view.sendSubviewToBack(heroImageView)
        
        blrView.alpha = 0
        
        heroImageView.alpha = 0
        heroImageView.hidden = false
        myCV.alpha = 0
        headView.alpha = 0
        nameLabel.alpha = 0
        
        
        
        UIView.animateWithDuration(3, animations: {
            self.heroImageView.alpha = 1
        }, completion: { done in
            UIView.animateWithDuration(0.7) {
                blrView.alpha = 1
            }
            UIView.animateWithDuration(2) {
                self.myCV.alpha = 1
                self.headView.alpha = 1
                self.nameLabel.alpha = 1
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lotsOfStuff.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(QuiteGoodCell.identifier, forIndexPath: indexPath) as! QuiteGoodCell
        cell.title = lotsOfStuff.keys.array[indexPath.row]
        cell.scheme = colors[indexPath.row % colors.count]
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! QuiteGoodCell
//        cell.expand()
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! QuiteGoodCell
        let goTo = CardStackViewController()
        goTo.namee = lotsOfStuff.keys.array[indexPath.row]
        goTo.transitioningDelegate = self
        goTo.modalPresentationStyle = .Custom
        let c = cell.convertPoint(cell.glyphView.center, toView: collectionView)
        currentPoint = collectionView.convertPoint(c, toView: self.view)
        transitionColor = cell.glyphView.backgroundColor
        presentViewController(goTo, animated: true, completion: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        //Do animation here with a short delay so a presentation can occur
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! QuiteGoodCell
        cell.shrink()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = RSMTransition()
        transition.isPresenting = true
        transition.newColor = transitionColor
        transition.fromPoint = currentPoint
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = RSMTransition()
        transition.isPresenting = false
        return transition
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

class RSMTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = true
    var fromPoint: CGPoint!
    var newColor: UIColor!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let menu = transitionContext.viewControllerForKey( self.isPresenting ? UITransitionContextFromViewControllerKey : UITransitionContextToViewControllerKey) as! ExcellentMenuViewController
        
        let cardStack = transitionContext.viewControllerForKey(self.isPresenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey) as! CardStackViewController
        
        let container = transitionContext.containerView()
        
        if isPresenting {
            container.addSubview(cardStack.view)
            cardStack.eventualColor = newColor
            cardStack.pt = fromPoint
            
            cardStack.setup()
            
            transitionContext.completeTransition(true)
        }
        else {
            cardStack.view.alpha = 0
            transitionContext.completeTransition(true)
        }
        
        
        

    }
    
    
    
    
}

class QuiteGoodCell: UICollectionViewCell {
    static let identifier = "muchidentify"
    
    @IBOutlet var glyphView: AstoundingImageView!
    @IBOutlet var titleLabel: UILabel!
    
     lazy var qv: UIView = {
        let a = UIView()
        
        return a
    }()
    
    
    var title: String? {
        didSet {
            titleLabel.text = title
            glyphView.image = flatMap(title) { UIImage(named: $0) }
        }
    }
    var scheme: UIColor? {
        didSet {
            glyphView.backgroundColor = scheme
//            expandView.backgroundColor = scheme
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    
    func setup() {
//        expandView.frame.size = glyphView.frame.size
//        expandView.center = glyphView.center
//        expandView.layer.cornerRadius = expandView.frame.size.width/2
//        expandView.layer.masksToBounds = true
//        contentView.insertSubview(expandView, belowSubview: glyphView)
    }
    
    func expand() {
        qv.frame = glyphView.frame
        qv.backgroundColor = scheme
        contentView.insertSubview(qv, belowSubview: glyphView)
        
//        glyphView.dynamicallyAdjustImageViewSize = false
        UIView.animateWithDuration(0.1) {
            self.qv.frame.size = CGSize(width: 100, height: 100)
            self.qv.layer.cornerRadius = self.qv.frame.size.width / 2
            self.qv.center = self.glyphView.center
            
        }
    }
    func shrink() {
        UIView.animateWithDuration(1, delay: 0.3, options: nil, animations: {
            self.qv.frame.size = self.glyphView.frame.size
            self.qv.center = self.glyphView.center
        }, completion: { finished in
            
        })
    }
    
    
}