//
//  tilesViewController.swift
//  demo
//
//  Created by Dealjava on 2/17/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit

class tilesViewController: UIViewController,IXNTileBoardViewDelegate {
    
    @IBOutlet weak var boardTiles : IXNTileBoardView!
    var step : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        boardTiles.playWithImage(UIImage(named: "plane"), size: 3)
        boardTiles.shuffleTimes(100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tileBoardViewDidFinished(tileBoardView: IXNTileBoardView!) {
        
    }
    
    func tileBoardView(tileBoardView: IXNTileBoardView!, tileDidMove position: CGPoint) {
        step++
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
