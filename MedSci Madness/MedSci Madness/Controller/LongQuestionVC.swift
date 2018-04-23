//
//  LongQuestionVC.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 21/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit
import Firebase

class LongQuestionVC: UIViewController{
    
    @IBOutlet weak var questionImage: RoundedImageView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var solutionTxtView: UITextView!
    @IBOutlet weak var answerTxtView: UITextView!
    
    var longQuestions = [[String:Any]]()
    var question: String = ""
    var answer: String = ""
    var imageURL: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadQuestions()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func downloadQuestions(){
        Firestore.firestore().collection("longQuestions").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.longQuestions.append(document.data())
                }
            }
        }
    }
    
    func setupView(){
        solutionTxtView.text = ""
        questionImage.image = #imageLiteral(resourceName: "imperialCrest")
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if longQuestions.count <= 0 {
            return
        }
        setupView()
        
        let docCount = longQuestions.count
        let ranNum = Int(arc4random_uniform(UInt32(docCount)))
        
        let questionDic = longQuestions[ranNum]
        
        question = questionDic["question"] as! String
        answer = questionDic["answer"] as! String
        imageURL = questionDic["imageURL"] as! String?

        //Download image from URL
        if let stringURL = imageURL{
            if let url = URL(string: stringURL){
                questionImage.downloadedFrom(url: url)
            }
        }
        
        questionLbl.text = question
        
        print(questionDic.description)
    }
    
    @IBAction func correctPressed(_ sender: Any) {
        solutionTxtView.text = answer
    }
    
    
    
}
