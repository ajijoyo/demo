//
//  ColorizeViewController.swift
//  demo
//
//  Created by Dealjava on 3/10/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ColorizeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = SCNView(frame: self.view.frame)
        
        
        let scene = SCNScene()
        sceneView.scene = scene;
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -3, y: 3, z: 3.0)

        
        let light = SCNLight()
        light.type = SCNLightTypeOmni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
        
        let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)

        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.redColor()
        cubeGeometry.materials = [redMaterial]
        let cubeNode = SCNNode(geometry: cubeGeometry)
        cubeNode.position = SCNVector3Make(0, 0, 0);
        let constraint = SCNLookAtConstraint(target: cubeNode)
        constraint.gimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cubeNode);
        
        self.view.addSubview(sceneView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
    }

    override func shouldAutorotate() -> Bool {
        return true;
    }
    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
//            return [UIInterfaceOrientationMask.LandscapeLeft,
//                UIInterfaceOrientationMask.LandscapeRight];
//        }else{
//            return [UIInterfaceOrientationMask.LandscapeLeft,
//                UIInterfaceOrientationMask.LandscapeRight];
//        }
//    }
    override func prefersStatusBarHidden() -> Bool {
        return true;
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
