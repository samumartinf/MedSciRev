//
//  UploadQuestionVC.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 09/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit

class UploadQuestionVC: UIViewController{

    @IBOutlet weak var questionTxtField: UITextField!
    @IBOutlet weak var answer1TxtField: UITextField!
    @IBOutlet weak var answer2TxtField: UITextField!
    @IBOutlet weak var answer3TxtField: UITextField!
    @IBOutlet weak var answer4TxtField: UITextField!
    @IBOutlet weak var answer5TxtField: UITextField!
    @IBOutlet weak var sol1: RoundedButton!
    @IBOutlet weak var sol2: RoundedButton!
    @IBOutlet weak var sol3: RoundedButton!
    @IBOutlet weak var sol4: RoundedButton!
    @IBOutlet weak var sol5: RoundedButton!
    @IBOutlet weak var solutionLbl: UILabel!
    

    
    var solution: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func uploadPressed(_ sender: Any) {
        if questionTxtField.text != "" && answer1TxtField.text != "" && answer2TxtField.text != "" && answer3TxtField.text != "" && solution != nil{
            let question = questionTxtField.text
            var answers = [answer1TxtField.text!,answer2TxtField.text!,answer3TxtField.text!]
            if answer4TxtField.text != "" || answer4TxtField.text != nil {
                answers.append(answer4TxtField.text!)
            }
            if answer5TxtField.text != "" || answer4TxtField.text != nil {
                answers.append(answer5TxtField.text!)
            }
            QuestionService.instance.uploadQuestion(question: question!, answers: answers, solution: solution!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func unselectAll(){
        sol1.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
        sol2.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
        sol3.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
        sol4.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
        sol5.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
    }
    
    @IBAction func solution1Selected(_ sender: Any) {
        solution = 0
        unselectAll()
        sol1.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        solutionLbl.text = "Solution: 1"
        
    }
    @IBAction func solution2Selected(_ sender: Any) {
        solution = 1
        unselectAll()
        sol2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        solutionLbl.text = "Solution: 2"
    }
    @IBAction func solution3Selected(_ sender: Any) {
        solution = 2
        unselectAll()
        sol3.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        solutionLbl.text = "Solution: 3"
    }
    @IBAction func solution4Selected(_ sender: Any) {
        solution = 3
        unselectAll()
        sol4.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        solutionLbl.text = "Solution: 4"
    }
    @IBAction func solution5Selected(_ sender: Any) {
        solution = 4
        unselectAll()
        sol5.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        solutionLbl.text = "Solution: 5"
    }
    
    
    
    
    
    
}
