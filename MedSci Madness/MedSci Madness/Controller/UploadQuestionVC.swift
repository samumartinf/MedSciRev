//
//  UploadQuestionVC.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 09/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit

class UploadQuestionVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

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
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var mcqStackView: UIStackView!
    @IBOutlet weak var longAnswerStackView: UIStackView!
    @IBOutlet weak var longTxtView: UITextView!
    @IBOutlet weak var imagePreview: UIImageView!
    
    var solution: Int?
    var questionType: Int?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func uploadPressed(_ sender: Any) {
        if selector.selectedSegmentIndex == 0 {
            if questionTxtField.text != "" && answer1TxtField.text != "" && answer2TxtField.text != "" && answer3TxtField.text != "" && solution != nil{
                let question = questionTxtField.text
                var answers = [answer1TxtField.text!,answer2TxtField.text!,answer3TxtField.text!]
                if answer4TxtField.text != "" && answer4TxtField.text != nil {
                    answers.append(answer4TxtField.text!)
                }
                if answer5TxtField.text != "" && answer4TxtField.text != nil {
                    answers.append(answer5TxtField.text!)
                }
                QuestionService.instance.uploadQuestion(question: question!, answers: answers, solution: solution!)
                
            }
        }
        
        if selector.selectedSegmentIndex == 1 {
            if questionTxtField.text != nil && (longTxtView.text != "Blah blah blah long answer here..." || longTxtView.text != nil) {
                if imagePreview.image != #imageLiteral(resourceName: "imperialCrest") && imagePreview.image != nil {
                    QuestionService.instance.uploadLongQuestion(question: questionTxtField.text!, answer: longTxtView.text!, image: imagePreview.image!)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    QuestionService.instance.uploadLongQuestion(question: questionTxtField.text!, answer: longTxtView.text!, image: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func questionSelector(_ sender: Any) {
        if selector.selectedSegmentIndex == 0 {
            mcqStackView.isHidden = false
            longAnswerStackView.isHidden = true
        } else {
            mcqStackView.isHidden = true
            longAnswerStackView.isHidden = false
        }
    }
    
    @IBAction func uploadPicturePressed(_ sender: Any) {
        self.present(self.picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOrignialImage"] as? UIImage{
            selectedImage = originalImage
        }
        
        if let image = selectedImage{
            self.imagePreview.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
