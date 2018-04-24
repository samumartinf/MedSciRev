//
//  RoundedButton.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 03/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton{
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
