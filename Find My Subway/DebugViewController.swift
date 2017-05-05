//
//  DebugViewController.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/22/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import MapKit

class DebugViewController: UIViewController {

    @IBOutlet weak var debugLocationSwitch: UISwitch!
    @IBOutlet weak var debugMapView: MKMapView!
    @IBOutlet weak var debugLatitudeTextField: UITextField!
    @IBOutlet weak var debugLongitudeTextField: UITextField!
    private var usersAnnotation : MKPointAnnotation!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }


    // MARK: - UI Setup
    
    private func setupUI() {
        
        // Views backdrop
        self.view.backgroundColor = .clear
        self.view.addBlurView(blurStyle: .dark)
        
        self.debugLocationSwitch.isOn = DebugManager.shared.isDebugLocationActive
        self.updateDebugState()
        
        // Switch
        self.debugLocationSwitch.onTintColor = StyleKit.ColorPalette.main
        self.debugLocationSwitch.tintColor   = StyleKit.ColorPalette.main
        
        // Lat / Long TextFields
        self.debugLatitudeTextField.delegate  = self
        self.debugLongitudeTextField.delegate = self
        
        // Map View
        self.debugMapView.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMapView(gestureReconizer:)))
        self.debugMapView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func updateDebugState() {
        
        let isOn: Bool = self.debugLocationSwitch.isOn
        
        self.debugMapView.isUserInteractionEnabled = isOn
        self.debugLatitudeTextField.isUserInteractionEnabled = isOn
        self.debugLongitudeTextField.isUserInteractionEnabled = isOn
        
        self.debugMapView.alpha = (isOn) ? 1 : 0.5
        self.debugLatitudeTextField.alpha = (isOn) ? 1 : 0.5
        self.debugLongitudeTextField.alpha = (isOn) ? 1 : 0.5
        
        self.centerMapOnLocation(location: DebugManager.shared.userCoordinates, withDistance: 2000)
    }
    
    
    // MARK: - Buttons
    
    @IBAction func didPressCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressDebugLocationSwitch(_ sender: Any) {
        DebugManager.shared.isDebugLocationActive = self.debugLocationSwitch.isOn
        if (DebugManager.shared.isDebugLocationActive) {
            DebugManager.shared.userCoordinates = LocationManager.shared.initalMapLocation
        }
        self.updateDebugState()
    }
    
    @objc fileprivate func didTapMapView(gestureReconizer: UILongPressGestureRecognizer) {
    
        let location = gestureReconizer.location(in: self.debugMapView)
        let coordinate = self.debugMapView.convert(location, toCoordinateFrom: self.debugMapView)
        self.centerMapOnLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), withDistance: 2000)
    }
    
    
    // MARK: - Map View
    
    fileprivate func centerMapOnLocation(location: CLLocation, withDistance regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.debugMapView.setRegion(coordinateRegion, animated: true)
        
        DebugManager.shared.userCoordinates = location
        let location = LocationManager.shared.getUserLocation()
        
        let latitude: Float = Float(location.coordinate.latitude)
        let longitude: Float = Float(location.coordinate.longitude)
        
        self.debugLatitudeTextField.text = String(format: "%f", latitude)
        self.debugLongitudeTextField.text = String(format: "%f", longitude)
        
        self.addUsersLocationAnnotation(location: location)
    }
    
    fileprivate func updateMapCoordiates() {
    
        let initialCoords: CLLocationCoordinate2D = LocationManager.shared.initalMapLocation.coordinate
        
        let latitude = self.validateCoord(coordString: self.debugLatitudeTextField.text!, defaultCoord: initialCoords.latitude)
        let longitude = self.validateCoord(coordString: self.debugLongitudeTextField.text!, defaultCoord: initialCoords.longitude)
        
        let newMapLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        self.usersAnnotation.coordinate = newMapLocation.coordinate
        self.debugMapView.addAnnotation(self.usersAnnotation)
        
        self.centerMapOnLocation(location: newMapLocation, withDistance: 2000)
    }
    
    fileprivate func validateCoord(coordString: String, defaultCoord: CLLocationDegrees) -> CLLocationDegrees {
       
        guard (!coordString.isEmpty) else { return defaultCoord }
        
        var characterSet: CharacterSet = CharacterSet.decimalDigits
        characterSet.insert(charactersIn: "-.")
        let formattedCoord = coordString.removeCharacters(from: characterSet.inverted)
        let coord: Double = (formattedCoord as NSString).doubleValue
        
        return (coord > 180 || coord < -180) ? defaultCoord : coord
    }
    
    fileprivate func addUsersLocationAnnotation(location: CLLocation) {
        
        if (self.usersAnnotation == nil) {
            self.usersAnnotation = MKPointAnnotation()
        }

        self.usersAnnotation.coordinate = location.coordinate
        self.debugMapView.addAnnotation(self.usersAnnotation)
    }
}


// MARK: - EXTENSION : UITextFieldDelegate

extension DebugViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       self.updateMapCoordiates()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.updateMapCoordiates()
        return true
    }
}


// MARK: - EXTENSION : MKMapViewDelegate

extension DebugViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            
            // Resize image
            var pinImage = UIImage(named: "test_userlocation")
            pinImage = pinImage?.maskWithColor(color: StyleKit.ColorPalette.main)
            let size = CGSize(width: 20, height: 20)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            annotationView.image = resizedImage
        }
        
        return annotationView
    }
}
