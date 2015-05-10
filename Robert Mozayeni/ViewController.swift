//
//  ViewController.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/17/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
        
    }
    override func viewDidAppear(animated: Bool) {
        let n = NiftyContentViewController(info: (title: "Some Title", body: tx, destination: nil))
        n.view.frame = view.frame
        n.modalPresentationStyle = .OverFullScreen
        presentViewController(n, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

let tx = "Lorem ipsum dolor sit amet, aliquam fermentum senectus feugiat, id lectus suscipit libero lacus suspendisse, non a metus nibh ante et et, vel diam dolorem non ipsum. Sit ac in libero ultricies platea nam, purus mauris rutrum sagittis ut id, fusce rhoncus risus nam convallis, in ultrices duis suspendisse mi odio erat, rhoncus quis ligula. Sociosqu sit amet donec felis convallis, eget sapien semper ligula nunc pede, vestibulum orci amet pretium bibendum eros vel. Mauris maecenas vel cubilia sed ea urna, porttitor sapien et quis hymenaeos, purus justo lectus duis, ultrices odio amet condimentum, donec viverra sed. Donec integer amet, cursus nunc mattis vestibulum vehicula, auctor ultricies arcu enim, ac at sapien ac commodo sodales, sollicitudin habitasse. Massa turpis, facilisis aenean laborum enim sint vivamus nec, ante tellus ac interdum sociis risus litora. Vel sit feugiat, lacinia vivamus wisi sollicitudin sed mi volutpat, commodo vivamus lectus, purus et tortor aliquam turpis, elit at suscipit. Mauris pretium consectetuer venenatis sed at. Amet et aenean lacinia, magna aptent sociis malesuada aliquam malesuada. Arcu in, libero magna orci. Vestibulum dapibus integer eleifend massa non, id leo quam tincidunt nunc posuere varius. Tellus urna purus, accumsan pellentesque gravida ac"
