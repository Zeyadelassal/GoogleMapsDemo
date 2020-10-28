//
//  CustomVIew.swift
//  GoogleMapsDemo
//
//  Created by Zeyad Elassal on 10/13/20.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

     func loadView() -> CustomView{
        let customInfoWindow = Bundle.main.loadNibNamed("CustomView",
            owner: self, options: nil)?[0] as! CustomView
        return customInfoWindow
    }
}
