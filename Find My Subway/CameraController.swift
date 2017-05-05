//
//  CameraController.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/5/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: NSObject {
    
    private var containerView: UIView!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    // MARK: - Initializer
    
    func initCamera(inContainer container: UIView) {
        
        self.containerView = container
        createCamera()
    }
    
    
    // MARK: - UI Layout
    
    func layoutPreviewLayer() {
        
        guard (self.previewLayer != nil) else { return }
        self.previewLayer.frame = self.containerView.bounds
        if let connection = self.previewLayer?.connection {
            connection.videoOrientation = AVCaptureVideoOrientation(ui:UIApplication.shared.statusBarOrientation)
        }
    }
    
    
    // MARK: - Camera Setup
    
    private func createCamera() {
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let deviceInput : AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            print("Can't get capture device input.")
            return
        }
        
        let captureSession  = AVCaptureSession()
        guard let preview = AVCaptureVideoPreviewLayer(session: captureSession) else {
            print("Can't get AVCaptureVideoPreviewLayer.")
            return
        }
        
        self.previewLayer = preview
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.previewLayer.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(self.previewLayer)
        
        guard captureSession.canAddInput(deviceInput as AVCaptureInput) else {
            print("Failed add video input.")
            return
        }
        
        captureSession.addInput(deviceInput as AVCaptureDeviceInput)
        captureSession.startRunning()
    }
}


// MARK: - EXTENSION: AVCaptureVideoOrientation

extension AVCaptureVideoOrientation {
    var uiInterfaceOrientation: UIInterfaceOrientation {
        get {
            switch self {
            case .landscapeLeft:        return .landscapeLeft
            case .landscapeRight:       return .landscapeRight
            case .portrait:             return .portrait
            case .portraitUpsideDown:   return .portraitUpsideDown
            }
        }
    }
    
    init(ui:UIInterfaceOrientation) {
        switch ui {
        case .landscapeRight:       self = .landscapeRight
        case .landscapeLeft:        self = .landscapeLeft
        case .portrait:             self = .portrait
        case .portraitUpsideDown:   self = .portraitUpsideDown
        default:                    self = .portrait
        }
    }
}

