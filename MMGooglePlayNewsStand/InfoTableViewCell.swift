//
//  InfoTableViewCell.swift
//  MMGooglePlayNewsStand
//
//  Created by Alexey Korotkov on 11/10/16.
//  Copyright © 2016 madapps. All rights reserved.
//

import GoogleMaps

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var middleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        middleView.layer.shadowColor=UIColor.blackColor().CGColor
        middleView.layer.shadowRadius = 8.0
        middleView.layer.shadowOpacity  = 1.0
        middleView.layer.masksToBounds=true
        
        let camera = GMSCameraPosition.cameraWithLatitude(53.899684,
                                                          longitude: 27.555612, zoom: 17)
        mapView.camera = camera
        
        let position = CLLocationCoordinate2DMake(53.899684, 27.555612)
        let marker = GMSMarker(position: position)
        marker.title = "Барбершоп Cut"
        marker.map = mapView
        
    }
    
}
