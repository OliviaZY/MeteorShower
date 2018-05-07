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
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentPositionOfCamera = orientation + location
        let earthLocation = currentPositionOfCamera + orientation
        
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
        
        let moonParent = SCNNode()
        moonParent.position = SCNVector3(0,0,-0.5)
        sceneView.scene.rootNode.addChildNode(moonParent)
        let moonParentRotationAction = SCNAction.rotateBy(x: 0, y:CGFloat(360.degressToRadians), z: 0, duration: 14.0)
        let moonParentRotateForever = SCNAction.repeatForever(earthRotationAction)
        moonParent.runAction(earthRotateForever)
        
        let moon = SCNNode()
        moon.geometry = SCNSphere(radius: moonRadiusKm * scale)
        moon.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "moon")
        moon.position = SCNVector3(0,0,earthMoonDistance)
        earth.addChildNode(moon)
        self.sceneView.scene.rootNode.addChildNode(moon)
    }
    

    @IBAction func pressedAddMoon(_ sender: Any) {
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentPositionOfCamera = orientation + location
        let earthLocation = currentPositionOfCamera + orientation
        
        let meteor = SCNNode()
        meteor.geometry = SCNSphere(radius: moonRadiusKm * scale)
        meteor.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "meteor")
        meteor.position = location
        sceneView.scene.rootNode.addChildNode(meteor)
    }
}

extension Int{
    var degressToRadians:Double{
        return Double(self) * .pi/180
    }
}

func +(left:SCNVector3, right:SCNVector3)->SCNVector3{
    return SCNVector3Make(left.x+right.x, left.y+right.y, left.z+right.z)
}
