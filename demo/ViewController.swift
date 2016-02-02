//
//  ViewController.swift
//  demo
//
//  Created by Dealjava on 11/24/15.
//  Copyright © 2015 originesia. All rights reserved.
//

import UIKit


class ViewController: UIViewController ,SplitflapDataSource,SplitflapDelegate{

    var split : Splitflap!
    
    var sikl = ["hellow" , "finish" , "bloww"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sikl.reverse())
        
//        FlapViewBuilder { builder in
//            builder.backgroundColor = UIColor.whiteColor()
//        }
        
        split = Splitflap()
        split.frame = CGRect(x: 0, y: 80, width: 300, height: 50)
        split.center.x = self.view.center.x
        split.datasource = self
        split.delegate = self
        split.reload()
        
        self.view.addSubview(split)
        
    }
    
    func alert(){
        let alertcontroll = UIAlertController(title: "token", message: NSUserDefaults.standardUserDefaults().stringForKey("tokenby"), preferredStyle: .Alert)
        let alertbttn = UIAlertAction(title: "oke", style: .Default,
            handler: {(action : UIAlertAction) in
        
        })
        alertcontroll.addAction(alertbttn)
        self.presentViewController(alertcontroll, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        split.setText(sikl[Int(arc4random_uniform(3))], animated: true, completionBlock: {
            print("finish")
            self.alert()
        })
    }
    
    func numberOfFlapsInSplitflap(splitflap: Splitflap) -> Int {
        return 7
    }
    func tokensInSplitflap(splitflap: Splitflap) -> [String] {
        return SplitflapTokens.AlphanumericAndSpace
    }

    
    func splitflap(splitflap: Splitflap, rotationDurationForFlapAtIndex index: Int) -> Double {
        return 0.2
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

