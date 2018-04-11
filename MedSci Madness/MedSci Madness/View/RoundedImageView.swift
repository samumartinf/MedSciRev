//
//  RoundedImageView.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 09/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView{
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
