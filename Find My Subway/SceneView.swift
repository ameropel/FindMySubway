//
//  SceneView.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/4/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion


class SceneView: UIView {
    
    private var scnView: SCNView!
    private var scnScene: SCNScene!
    private var scnCamera: SCNNode!
    fileprivate var scnWorld: SCNNode!
    
    let motionManager = CMMotionManager()
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSceneView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSceneView()
    }

    
    // MARK: - Scene Setup
    
    private func setupSceneView() {
        
        guard (self.scnView == nil) else { return }
        
        // Declare the SCNView that renders the content of the SCNScene on the display.
        self.scnView = SCNView()
        self.scnView.backgroundColor = .clear
        self.scnView.autoenablesDefaultLighting = true
        self.scnView.allowsCameraControl = true
        self.scnView.frame = self.bounds
        self.addSubview(self.scnView)
        
        // Declare the SCNScene. You’ll add components like lights, camera, geometry and particle emitters as children of this scene.
        self.scnScene = SCNScene()
        self.scnView.scene = self.scnScene
        
        self.setupSceneCamera()
        self.setupCameraMotion()
        self.createWorld()
    }
    
    private func setupSceneCamera() {
        
        // Create a camera and attach it to a node
        let camera = SCNCamera()
        camera.xFov = 10
        camera.yFov = 45
        camera.zFar = 500
        
        self.scnCamera = SCNNode()
        self.scnCamera.camera = camera
        self.scnCamera.position = SCNVector3(0, 0, 0)
        self.scnScene.rootNode.addChildNode(self.scnCamera)
    }
    
    
    // MARK: - Scene Camera Movement
    
    private func setupCameraMotion() {
        
        guard self.motionManager.isDeviceMotionAvailable else {
        
            print("Device motion is not available")
            return
        }
        
        self.motionManager.deviceMotionUpdateInterval = 0.017 // 60 times a second
        //self.motionManager.startDeviceMotionUpdates(to: OperationQueue(), withHandler: deviceDidMove as! CMDeviceMotionHandler)
            
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue(), withHandler:{
            deviceManager, error in
                
            if let motion = deviceManager {
                
                self.scnCamera.orientation = motion.gaze(atOrientation: UIApplication.shared.statusBarOrientation)
            }
        })
    }
    
    private func deviceDidMove(motion: CMDeviceMotion?, error: NSError?) {
        
        if let motion = motion {
            
            self.scnCamera.orientation = motion.gaze(atOrientation: UIApplication.shared.statusBarOrientation)
        }
    }
    
    
    // MARK: - World
    
    private func createWorld() {
        
        guard (self.scnScene != nil && self.scnWorld == nil) else {
            print("No scene was created. Can't add object.")
            return
        }
        
        self.scnWorld = SCNNode()
        self.scnWorld.position = SCNVector3(0, 0, 0)
        self.scnScene.rootNode.addChildNode(self.scnWorld)
        
        
        // Will initialize world when data is completely loaded
        //NotificationCenter.default.addObserver(self, selector: #selector(initializeWorld), name: Constants().Notification_DataLoaded, object: nil)
        
        //self.addTestNodeToScene()
        //self.addTestCubeToScene()
        //self.addTestTextToScene()
    }
    
    @objc private func initializeWorld() {
        
        // World Objects
        for station in DataManager.shared.retrieveAllSubwayData() {
            station.initializeNode(inWorld: self.scnWorld)
        }
    }
    
    
    // MARK: - Test Scripts
    
    private func addTestNodeToScene() {
        
        guard (self.scnWorld != nil) else {
            print("No scene was created. Can't add object.")
            return
        }
        
        // Create a cube and place it in the scene
        let cube = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
        cube.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(0, 0, -50)
        
        let myText = SCNText(string: "Test", extrusionDepth: 2)
        myText.font = UIFont(name: "Optima", size: 4)
        let myTextNode = SCNNode(geometry: myText)
        
        print( myText.boundingBox.min)
        print( myText.boundingBox.max)
        
        
        myTextNode.position = SCNVector3(x: -3, y: 3, z: 0)
        myTextNode.constraints = [SCNBillboardConstraint()]
        cubeNode.addChildNode(myTextNode)
        
        self.scnWorld.addChildNode(cubeNode)
    }

    
    private func addTestCubeToScene() {
        
        guard (self.scnWorld != nil) else {
            print("No scene was created. Can't add object.")
            return
        }
        
        // Create a cube and place it in the scene
        let cube = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
        cube.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(10, -50, 0)
        self.scnWorld.addChildNode(cubeNode)
    }
    
    private func addTestTextToScene() {
        
        guard (self.scnWorld != nil) else {
            print("No scene was created. Can't add object.")
            return
        }
        
        let myText = SCNText(string: "Hello", extrusionDepth: 2)
        myText.font = UIFont(name: "Optima", size: 15)
        //myText.materials = [myStar, myBlue]
        let myTextNode = SCNNode(geometry: myText)
        myTextNode.position = SCNVector3(x: -10, y: -500, z: 0)
        myTextNode.constraints = [SCNBillboardConstraint()]
        self.scnWorld.addChildNode(myTextNode)
    }
}
