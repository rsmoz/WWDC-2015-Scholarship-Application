//
//  CardStackViewController.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/25/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

class CardStackViewController: UIViewController, UIPageViewControllerDataSource {
    
    let cardsController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    var namee: String!
    var vcs: [NiftyContentViewController]!
    var eventualColor: UIColor!
    var pt: CGPoint!
    
    let btn = UIButton(frame: CGRect(x: 0, y: 10, width: 50, height: 50))
    let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 45))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsController.dataSource = self
        
        vcs = lotsOfStuff[namee]!.map { NiftyContentViewController(info: $0) }
    }
    
    func setup() {
        
        view.backgroundColor = .clearColor()
        
        /*
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        view.backgroundColor = [UIColor blueColor];
        
        CAShapeLayer *shape = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:view.center radius:(view.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
        shape.path = path.CGPath;
        view.layer.mask=shape;
*/
        let circ = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        circ.center = pt
        circ.backgroundColor = self.eventualColor
        circ.layer.cornerRadius = circ.bounds.width / 2
        circ.layer.masksToBounds = true

        view.addSubview(circ)
        UIView.animateWithDuration(0.4, animations: {
        circ.transform = CGAffineTransformMakeScale(25, 25)
        }, completion: { bl in
            circ.removeFromSuperview()
            self.cardsController.setViewControllers([self.vcs.first!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            self.addChildViewController(self.cardsController)
            self.cardsController.view.alpha = 0
            self.view.addSubview(self.cardsController.view)
            self.cardsController.view.frame.size = CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 100)
            self.cardsController.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 10)
            
            self.cardsController.didMoveToParentViewController(self)
            self.view.backgroundColor = self.eventualColor
            
            
            self.btn.setImage(UIImage(named: "btnX"), forState: .Normal)
            self.btn.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
            self.btn.alpha = 0
            self.view.addSubview(self.btn)
            
            
            self.lbl.center = CGPoint(x: self.view.center.x, y: 34)
            self.lbl.font = UIFont(name: "Helvetica", size: 30)
            self.lbl.numberOfLines = 1
            self.lbl.textColor = .whiteColor()
            self.lbl.textAlignment = .Center
            
            self.lbl.text = self.namee
            self.lbl.alpha = 0
            self.view.addSubview(self.lbl)
            
            UIView.animateWithDuration(0.8) {
                self.lbl.alpha = 1
                self.cardsController.view.alpha = 1
                self.btn.alpha = 1
            }
        })
        
        
        
        
        
        
    }
    
    func close() {
        
        
        
        
        UIView.animateWithDuration(0.3, animations: {
            self.lbl.alpha = 0
            self.cardsController.view.alpha = 0
            self.btn.alpha = 0
        }, completion: { bl in
            
            let circ = UIView(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
            circ.center = self.pt
            circ.backgroundColor = self.eventualColor
            circ.layer.cornerRadius = circ.bounds.width / 2
            circ.layer.masksToBounds = true
            self.view.addSubview(circ)
            self.view.backgroundColor = .clearColor()
            UIView.animateWithDuration(0.2, animations: {
                circ.transform = CGAffineTransformMakeScale(0.001, 0.001)
            }, completion: { bl in
                self.dismissViewControllerAnimated(false, completion: nil)
            })
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let ind = find(vcs, viewController as! NiftyContentViewController)!
        if ind == 0 {
            return nil
        }
        return vcs[ind - 1]
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let ind = find(vcs, viewController as! NiftyContentViewController)!
        if ind == vcs.count - 1 {
            return nil
        }
        return vcs[ind + 1]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 1
    }

    

}
