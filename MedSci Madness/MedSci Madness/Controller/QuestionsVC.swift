//
//  ViewController.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 03/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit
import Firebase

class QuestionsVC: UIViewController {
    
//OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionHolderView: GradientView!
    
    @IBOutlet weak var correctLbl: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    @IBOutlet weak var answer5: UILabel!
    

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var answer3button: RoundedButton!
    @IBOutlet weak var answer2button: RoundedButton!
    @IBOutlet weak var answer1button: RoundedButton!
    @IBOutlet weak var answer5button: RoundedButton!
    @IBOutlet weak var answer4button: RoundedButton!
    
    var question: String = ""
    var answers = [String]()
    var solution = -1
    var correct: Float = 0
    var incorrect: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        questionHolderView.layer.cornerRadius = 6
        questionHolderView.setNeedsLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupView(){
        imageView.image = #imageLiteral(resourceName: "imperialCrest")
    }
    
    func retrieveQuestion(){

            setupView()
        
        answer4button.isHidden = true
        answer4.text = ""
        answer4.isHidden = true
        answer5.text = ""
        answer5.isHidden = true
        answer5button.isHidden = true
            
            (question, answers, solution) = QuestionService.instance.generateQuestion(completion: { (success) in
                if success{
                    print(self.question, self.answers)
                }
            })
        
            questionLbl.text! = question
        
            if answers.count >= 3 {
                answer1.text = answers[0]
                answer2.text = answers[1]
                answer3.text = answers[2]
            }
            
            if answers.count >= 4{
                answer4.text = answers[3]
                answer4.isHidden = false
                answer4button.isHidden = false
                answer4.layoutIfNeeded()
                answer4button.layoutIfNeeded()
            }
            if answers.count >= 5 {
                answer5.text = answers[4]
                answer5.isHidden = false
                answer5button.isHidden = false
                answer5.layoutIfNeeded()
                answer5button.layoutIfNeeded()
            }
        
            //TODO: make this a table view
            answer1button.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
            answer2button.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
            answer3button.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
            answer4button.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
            answer5button.backgroundColor = UIColor(red: 1, green: 147/255, blue: 0, alpha: 1)
    }
    
    func updateProgressBar(){
        if (correct + incorrect) >= 1{
            progressBar.setProgress(Float(correct/(correct + incorrect)), animated: true)
        } else {
            progressBar.setProgress(Float(correct/1), animated: true)
        }
        correctLbl.text = "Correct: \(Int(correct)) out of \(Int(correct+incorrect))"
    }
    
    @IBAction func answer1Pressed(_ sender: Any) {
        if solution == 0 {
            answer1button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            correct += 1
        }else{
            answer1button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            incorrect += 1
        }
        updateProgressBar()
    }
    @IBAction func answer2Pressed(_ sender: Any) {
        if solution == 1 {
            answer2button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            correct += 1
        }else{
            answer2button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            incorrect += 1
        }
        updateProgressBar()
    }
    @IBAction func answer3Pressed(_ sender: Any) {
        if solution == 2 {
            answer3button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            correct += 1
        }else{
            answer3button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            incorrect += 1
        }
        updateProgressBar()
    }
    @IBAction func answer4Pressed(_ sender: Any) {
        if solution == 3 {
            answer4button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            correct += 1
        }else{
            answer4button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            incorrect += 1
        }
        updateProgressBar()
    }
    
    @IBAction func answer5Pressed(_ sender: Any) {
        if solution == 4 {
            answer5button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            correct += 1
        }else{
            answer5button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            incorrect += 1
        }
        updateProgressBar()
    }
    
    
    @IBAction func refreshPressed(_ sender: Any) {
        retrieveQuestion()
    }
    
}


