//
//  adsOn.swift
//  demo
//
//  Created by Dealjava on 1/31/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit

class adsOn: UIView {
    
    private var mainScroll : UIScrollView!
    private var label1,label2 : UILabel!
    private var task = NSTimer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        mainScroll = UIScrollView(frame: self.bounds)
        mainScroll.pagingEnabled = true
        mainScroll.showsHorizontalScrollIndicator = false
        mainScroll.showsVerticalScrollIndicator = false
        mainScroll.contentSize = CGSize(width: self.bounds.width * 2, height: self.bounds.height)
        
        label1 = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        label1.text = "test 1"
        label1.textAlignment = .Center
        label1.backgroundColor = UIColor.cyanColor()
        
        label2 = UILabel(frame: CGRect(x: self.bounds.width, y: 0, width: self.bounds.width, height: self.bounds.height))
        label2.text = "test 2"
        label2.textAlignment = .Center
        label2.backgroundColor = UIColor.yellowColor()
        
        mainScroll.addSubview(label1)
        mainScroll.addSubview(label2)
        
        self.addSubview(mainScroll)
        
        task = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "timerAds", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(task, forMode: NSRunLoopCommonModes)
        
    }
    
    func timerAds(){
        var page = mainScroll.contentOffset.x / mainScroll.bounds.width
        if page == 0{
            page = 1
        }else{
            page = 0
        }
        
        mainScroll.contentOffset = CGPoint(x: page * mainScroll.bounds.width , y: 0)
        print("\(page)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
