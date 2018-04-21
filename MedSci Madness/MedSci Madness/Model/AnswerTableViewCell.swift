//
//  AnswerTableViewCell.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 11/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var numberLbl: RoundedLbl!
    
    func configureCell(answer: String, number: Int){
        answerLbl.text = answer
        numberLbl.text = String(number)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
