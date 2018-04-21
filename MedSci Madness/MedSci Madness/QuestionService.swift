//
//  QuestionService.swift
//  MedSci Madness
//
//  Created by Samuel Martin on 09/04/2018.
//  Copyright © 2018 Samuel Martin. All rights reserved.
//

import Foundation
import Firebase

class QuestionService{
    static let instance = QuestionService()
    
    let docRef = Firestore.firestore().document("questions/q0")
    let db = Firestore.firestore()
    
    var question: String = ""
    var answers = [String]()
    var solution = -1
    
    func generateQuestion(completion: @escaping (Bool) -> () ) -> (question: String, answers: [String], solution: Int){
        db.collection("questions").getDocuments { (snapshot, error) in
            if let error = error{
                print("Error retrieving data \(error.localizedDescription)")
                completion(false)
            } else {
                let docCount = snapshot?.documents.count ?? 0
                let ranNum = Int(arc4random_uniform(UInt32(docCount)))
                guard let myDoc = snapshot?.documents[ranNum] else {return}
                let myData = myDoc.data()
                self.question = myData["question"] as? String ?? "Error retrieving, tap Refresh again!"
                self.answers = myData["answers"] as? [String] ?? [String]()
                self.solution = myData["solution"] as? Int ?? -1
                print(myData)
                completion(true)
            }
        }
        return(question, answers, solution)
    }
        
    func uploadQuestion(question: String, answers: [String], solution: Int){
            let uploadData = ["question": question, "answers": answers, "solution":solution] as [String:Any]
            db.collection("questions").addDocument(data: uploadData)
            print("Successful upload of question")
    }
    
    
}
