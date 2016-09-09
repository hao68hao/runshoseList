//
//  mapViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/23.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController,MKMapViewDelegate {
    
    var mapShose : RunShoseRecord!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //实例化CLGeocoder
        let geocoder = CLGeocoder()
        //调用geocodeAddressString方法，获取到详情页传递过来的地址字符串，转化为坐标
        geocoder.geocodeAddressString(mapShose.shoseLocation) { (Placemark, error) -> Void in
            if error != nil{
                print(error)
                return
            }
            
            if let placemarks = Placemark{
                
//                print(placemarks)
                
                let placmark = placemarks[0]
                
//                print(placmark)
                
                let annotation = MKPointAnnotation()
                annotation.title = self.mapShose.shoseName
                annotation.subtitle = self.mapShose.shoseType
                
                if let location = placmark.location{
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
                
            }
 
        }
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
  
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "我的图钉"
        
        //用户位置视图也是一个标注视图
        if annotation is MKUserLocation{
            return nil
        }
        
        //考虑性能重用已经存在的标注视图
        var annotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(id) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: mapShose.shoseImage)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        annotationView?.pinTintColor = UIColor.greenColor()
        
        return annotationView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
