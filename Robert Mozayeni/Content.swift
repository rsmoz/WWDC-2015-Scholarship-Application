//
//  Content.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/24/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit
import StoreKit

//Images stored with X_TITLE.png

enum Action {
    case URL(String)
    case AppStorePage(String)
}

/*
SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];

// Configure View Controller
[storeProductViewController setDelegate:self];
[storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"594467299"} completionBlock:^(BOOL result, NSError *error) {
if (error) {
NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);

} else {
// Present Store Product View Controller
[self presentViewController:storeProductViewController animated:YES completion:nil];
}
}];
*/

extension UIViewController: SKStoreProductViewControllerDelegate {
    func performAction(act: Action) {
        switch act {
        case let .URL(urlStr):
            UIApplication.sharedApplication().openURL(NSURL(string: urlStr)!)
        case let .AppStorePage(appID):
            let controller = SKStoreProductViewController()
            controller.delegate = self
            controller.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier : appID], completionBlock: { result, error in
                self.presentViewController(controller, animated: true, completion: nil)
            })
        }
    }
    
    public func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

//URL literal convertible

typealias Card = (title: String, body: String, destination: Action?) //Maybe make array of URLs, and show sheet to pick one?

let lotsOfStuff: [String : [Card]] = [
    "Projects" : [
        ("Snappp", "I built an app that uses a custom algorithm to find the location of the caption bar in a screenshot of a Snapchat message. My algorithm also automatically finds any text in the caption. It then removes the caption bar and text, compensating for the lost image data using the Open Computer Vision library.\n\nMy code for Snappp is almost entirely Swift, but there's also some Objective-C, Objective-C++, and C++.\n\nSnappp has been downloaded over 63,000 times and has more than 25,300 monthly active users. Every day, users collectively spend nearly 2 days' worth of time using Snappp. At the time of writing, 23 people currently have the app open.", Action.AppStorePage("896890211")),
        ("Bitcoin Live", "I built an app that tracks the exchange rate of Bitcoin, which it displays as a badge on the app icon. It updates every 60 seconds. Bitcoin Live does not have an astonishing number of downloads, but it has been profitable.", Action.AppStorePage("628282018")),
        ("Thoughtcrime", "At Bitcamp Spring 2015, I built Thoughtcrime, a tool to battle censorship. It uses the Multipeer Connectivity framework in iOS, and then uses it to build a mesh architecture. This mesh network is then used to extend one device's internet connection to other devices, even those that are not immediately connected. If device A is connected to device B, and B to C, and C to D, then if D wants to make a web request, it can relay the request to A, which will execute it and send the data back to D. If cellular networks are shut down, one person can share their WiFi connection through what is essentially a series of repeaters to individuals outside the range of the original WiFi network. This will be open-sourced soon.", Action.URL("http://challengepost.com/software/thoughtcrime-ak05e")),
        ("Scolio", "Scolio was a team project built at PennApps Fall 2014. It placed in the Top 10. We developed an easy way for anyone to detect a very common health issue from the comfort of one's home. With one's iPhone, one can now detect signs of Scoliosis and connect with a doctor if the app thinks one is likely to have the illness.", Action.URL("http://challengepost.com/software/scolio")),
        ("Masky", "Built at MHacks Spring 2015. Shows an image that appears clear to the human eye, but cannot be screenshotted fully because of high-speed, imperceptible blurring.", Action.URL("http://challengepost.com/software/masky")),
        ("Tesla In the Home", "Tesla In the Home was a team project built at MHacks Fall 2014.\n\nImagine you're coming home from a long day at work and when you walk inside, there's a fresh margarita waiting there for you! We combined the Tesla API with a margarita mixer we modified to be internet-connected. We take the proximity of your car to your home, and trigger the mixer to start making you a drink! Also, as you arrive, your friends will be notified about the margarita party at your house! When your friends arrive, they can then open their iPhone app which allows them to place orders from the mixed drink machine. The best part? \"Hey Siri, make me a drink!\"\n(Yes, it works.)", Action.URL("http://challengepost.com/software/tesla-in-the-home")),
        ("Routr", "Routr won 2nd Place at HackUMBC 2014. I built Routr by myself.\n\nRoutr is an iOS Safari Action Extension that scans the HTML of a page for actionable data types (Twitter handles to follow, Bitcoin address to pay to, mail links to open in apps other than the default app) and then scans for apps on the system that can handle those data types. The user selects one app to which they want to route a piece of data.", Action.URL("http://challengepost.com/software/routr-da8h5")),
        ("Convoy", "I created the iOS client for Treehouse Island Inc.’s in‐house email replacement system during my paid summer internship.", nil),
        ("Open Source", "I've contributed to a number of open source projects.", Action.URL("https://github.com/rsmoz"))
        
    ],
    
    "Education" : [
        ("UMBC", "I attend The University of Maryland, Baltimore County, from which I will graduate with a B.S. in Computer Science in 2018 (I'm a freshman now). I really like it here, and have become close with my fellow members of UMBC Hackers. We travel to different hackathons and win frequently.\n\nWe also host evening workshops, where any student can come in and learn a new skill from scratch. I run the iOS workshop.", nil),
        ("WJ", "Before UMBC, I went to Walter Johnson High School. For the 4 years I was there, I participated in the Debate Team. I went to Finals every year. In my final year, I was a captain. With my two co-captains, we led a team of dozens of debaters to First Place in the county. My debate partner and I also made it to Semifinals, making us a Top 4 pair out of hundreds of debaters.", nil),
        
    ],
    
    "Technical" : [
        ("Swift", "Holy moly, do I love Swift! It's hands-down my favorite language, ever. Since Swift came out, I've written almost all of my code in it(except for projects for my CS classes). Generics, enums, functional goodness (OMG Higher Order Functions!), type checking, and that beautiful syntax! What's not to like?", nil),
        ("Objective-C", "I've known Objective-C for a few years. I don't use it that much any more (I'm a Swifter now), but I'm fond of the good times we had together.", nil),
        ("Haskell", "Haskell is awesome! I started learning Haskell several months before Swift came out. What I've loved about learning Haskell is that it's been like learning how to program all over again. I really enjoyed the first time, so having an opportunity to see things with awe and excitement once again is very welcome.\n\nFunctional Programming in general is very cool, and when I can, I now make my code in other languages as functional as possible. One of the reasons I love Swift is because I can do more functional stuff than I could in Objective-C, by far.", nil),
        ("Python", "I wrote my first programs in Python, so it has a very special place in my heart. Up until Swift came out, Python was the language I'd use to quickly prototype algorithms before implementing them in other languages.", nil),
        ("C++", "C++ is weird, but kinda neat.", nil)
        
    ],
    
    "Interests" : [
        ("Philosophy", "I find it exhilirating to think about the nature of knowledge, reality, and existence.\n\nWhen I first read Plato's (Well, his insomuch as he recorded Socrates' spoken words) Republic, I was delighted by the wonderful back-and-forth dialogue that Socrates had with his contemporaries. The process by which they analyzed ideas, I thought, was just really neat.", nil),
        ("Reading", "Before I was The Geeky Kid Who Made Apps™, I was The Nerdy Kid Who Read A Lot™. Especially when I was younger, when I didn't spend as much time on the computer writing code, my productive time was spent reading for hours and hours on end. These days, I still read a good amount.\n\nMy favorite author is Aldous Huxley. He wrote Island (Incidentally, my favorite book), Brave New World, and Doors of Perception.\n\nDisclaimer: I don't actually have trademarks on these titles.", nil),
        ("Psychology", "Psychology has interested me since 10th Grade. ", Action.URL("https://github.com/rsmoz/books")),
        ("Space", "Space, the final frontier indeed. So many things about space travel excite me. I spend an unhealthy amount of time reading Wikipedia pages about various rockets, satellites, celestial bodies, comparing sizes, masses, and other attributes. Any time some new Apollo 11 (The first manned moon landing) simulation or visualization comes out, I try it out as soon as I can.\n\nI also play a lot of Kerbal Space Program, a video game in which one attempts to build rockets and conduct various missions. I love the kOS mod, which allows me to script my rockets for automated, unmanned spaceflight.\n\n\nLLAP 🖖", nil)
    ]

]


