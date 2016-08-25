//
//  GyroViewController.swift
//  gyrotest
//
//  Created by Michael Ferenduros on 25/08/2016.
//  Copyright © 2016 Mike Ferenduros. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class GyroViewController: UIViewController {

    @IBOutlet var sceneView: SCNView!
    var cube: SCNNode!

    let moMan = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        cube = sceneView.scene!.rootNode.childNode(withName: "cube", recursively: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moMan.deviceMotionUpdateInterval = 1.0/60.0
        moMan.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical, to: OperationQueue.main) { [weak self] (motion, error) in
            if let q = motion?.attitude.quaternion {
                self?.cube.orientation = SCNQuaternion(q.x, q.y, q.z, -q.w)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        moMan.stopDeviceMotionUpdates()
    }
}
