//
//  TodayViewController.swift
//  usedDisk
//
//  Created by Dealjava on 1/31/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    private let heightCollapse = 36;
    private let heightExpand = 135;
    
    @IBOutlet weak var detailDisk :UILabel!
    @IBOutlet weak var progresDisk : UIProgressView!
    @IBOutlet weak var percentDisk : UILabel!
    
    private var usedRate : Double! {
        get{
            if let rt = NSUserDefaults.standardUserDefaults().valueForKey("rateKey") as? Double {
                return rt
            }else{
                return 0
            }
        }
        set{
            return  NSUserDefaults.standardUserDefaults().setDouble(newValue, forKey: "rateKey")
        }
    }
    
    private var fileSystemSize,freeSize,usedSize : UInt64!
    private var isExpand = false
    
    private var ads : adsOn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 0, height: heightCollapse)
        ads = adsOn(frame: CGRect(x: 0, y: 105, width: self.view.frame.width - 48, height: 30))
        self.view.addSubview(ads)
        
        updateInterface()
        detailDisk.alpha = 1
        let tap = UITapGestureRecognizer(target: self, action: "istapped")
        self.view.addGestureRecognizer(tap)
        self.view.userInteractionEnabled = true
        
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
//        coordinator.animateAlongsideTransition({ context in
//            self.detailDisk.alpha = 1
//            }, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        updateSize()
        let newRate = Double(usedSize) / Double(fileSystemSize)

        if newRate - usedRate < 0.0001 {
            
        }else{
            usedRate = newRate
            updateInterface()
        }
    }
    
    override func viewDidLayoutSubviews() {
        ads.frame = CGRect(x: 0, y: 105, width: self.view.frame.width , height: 30)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func istapped(){
        if isExpand {
            isExpand = false
            self.preferredContentSize = CGSize(width: 0, height: heightCollapse)
        }else{
            isExpand = true
            updateDetailsLabel()
            self.preferredContentSize = CGSize(width: 0, height: heightExpand)
        }
    }
    
    func updateSize(){
        do{
            let dict = try NSFileManager().attributesOfFileSystemForPath(NSHomeDirectory())
            // Set the values
            self.fileSystemSize = dict["NSFileSystemSize"]?.unsignedLongLongValue
            self.freeSize       = dict["NSFileSystemFreeSize"]?.unsignedLongLongValue
            self.usedSize       = self.fileSystemSize - self.freeSize;
        }catch{
            
        }
    }
    
    func updateInterface(){
//        ads.frame = CGRect(x: 0, y: 105, width: self.view.frame.width - 48, height: 30)
        let rate = self.usedRate ; // retrieve the cached value
        
        if (rate < 0.5) {
            percentDisk.textColor = UIColor.greenColor()
            
        }else if (rate > 0.5 && rate < 0.75 ){
            percentDisk.textColor = UIColor.orangeColor()
        }else if (rate > 0.9 ){
            percentDisk.textColor = UIColor.redColor()
        }
        self.percentDisk.text = NSString(format: "%.1f%%", (rate * 100)) as String
        self.progresDisk.progress = Float(rate);
        
        self.progresDisk.progressTintColor = percentDisk.textColor;
    }
    
    func updateDetailsLabel(){
        let formarter = NSByteCountFormatter()
        formarter.countStyle = .File

        detailDisk.text = "Used\t:\t\(formarter.stringFromByteCount(Int64(usedSize)))\nFree\t:\t\(formarter.stringFromByteCount(Int64(freeSize)))\nTotal\t:\t\(formarter.stringFromByteCount(Int64(fileSystemSize)))"
    }
    
    func openApp(){
        let url: NSURL = NSURL(string:"usedDisk://notif")!
        self.extensionContext?.openURL(url, completionHandler: nil)
    }
    
    //MARK: - widget
    func widgetMarginInsetsForProposedMarginInsets(var defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        defaultMarginInsets.bottom = 10
        return defaultMarginInsets;
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

        
        
    }
    
}
