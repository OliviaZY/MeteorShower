//
//  ViewController.swift
//  MeteorShower
//
//  Created by Yuan zhou on 5/7/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let earthRadiusKm:CGFloat = 6371
    let moonRadiusKm:CGFloat = 1731.5
    let earthMoonDistance:CGFloat = 384400
    let scale:CGFloat = 1/50000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(self.configuration)
    }
    
    
    @IBAction func pressedAddEarth(_ sender: Any) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: earthRadiusKm*scale)
        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earth_daymap")
        earth.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earth_specular_map")
        earth.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earth_clouds")
        earth.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earth_elevation_normal_map")
        
        
        earth.position = SCNVector3(0,0,-0.5)
        
        sceneView.scene.rootNode.addChildNode(earth)
        let earthRotationAction = SCNAction.rotateBy(x: 0, y:CGFloat(360.degressToRadians), z: 0, duration: 8.0)
        let earthRotateForever = SCNAction.repeatForever(earthRotationAction)
        earth.runAction(earthRotateForever)
    }
    

    @IBAction func pressedAddMoon(_ sender: Any) {
    }
}

extension Int{
    var degressToRadians:Double{
        return Double(self) * .pi/180
    }
}
