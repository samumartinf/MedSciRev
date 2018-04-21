//
//  ViewController.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 03/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import UIKit
import Firebase

class QuestionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionHolderView: GradientView!
    @IBOutlet weak var correctLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var questions = [[String:Any]]()
    
    
    var question: String = ""
    var answers: [String] = ["Tap", "Refresh", "To get", "New", "Questions"]
    var solution = -1
    var correct: Float = 0
    var incorrect: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        questionHolderView.layer.cornerRadius = 6
        questionHolderView.setNeedsLayout()
        tableView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
        downloadQuestions()
        tableView.reloadData()
    }
    
    func downloadQuestions(){
        Firestore.firestore().collection("questions").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.questions.append(document.data())
                    }
                }
        }
    }
    
    func setupView(){
        imageView.image = #imageLiteral(resourceName: "imperialCrest")
        restoreTableView()
    }
    
    func retrieveQuestion(){
        if questions.count <= 0 {
            return
        }
        setupView()
        let docCount = questions.count
        let ranNum = Int(arc4random_uniform(UInt32(docCount)))
        
        let questionDic = questions[ranNum]
        
        
        question = questionDic["question"] as! String
        questionLbl.text = question
        answers = questionDic["answers"] as! [String]
        solution = questionDic["solution"] as! Int
        
        self.tableView.reloadData()
        print(questionDic.description)
    }
    
    func updateProgressBar(){
        if (correct + incorrect) >= 1{
            progressBar.setProgress(Float(correct/(correct + incorrect)), animated: true)
        } else {
            progressBar.setProgress(Float(correct/1), animated: true)
        }
        correctLbl.text = "Correct: \(Int(correct)) out of \(Int(correct+incorrect))"
    }
    
    func restoreTableView(){
        for cell in tableView.visibleCells{
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    
    @IBAction func refreshPressed(_ sender: Any) {
        retrieveQuestion()
        tableView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerTableViewCell{
            let answer = answers[indexPath.row]
            cell.configureCell(answer: answer, number: indexPath.row+1)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == solution {
            correct += 1
            tableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            incorrect += 1
            tableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }
        updateProgressBar()
    }
    
}


