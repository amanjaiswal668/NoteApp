//
//  addNoteViewController.swift
//  noteApp
//
//  Created by Aman Jaiswal on 19/10/20.
//

import UIKit

class addNoteViewController: UIViewController {
    
    var note: Note?
    var update = false
    
    //    MARK: - Creating IBOutlets.
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextField: UITextView!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    //    MARK: - LifeCycle.
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false{
            self.deleteBtn.isEnabled = false
            self.deleteBtn.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        Customising bodyTextField.
        
        bodyTextField.delegate = self
        bodyTextField.text = "Add note"
        bodyTextField.textColor = UIColor.systemGray
        bodyTextField.font = UIFont(name: "Helvetica Neue", size: 17)
        bodyTextField.returnKeyType = .done
        
        if update == true {
            
            titleTextField.text = note!.title
            bodyTextField.text = note!.note
        }
    }
    //    MARK: - Save and Delete button Functionality.
    
    //    Save button.
    @IBAction func saveTapped(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        if update == true {
            
            APIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextField.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
            
        } else if titleTextField.text != "" && bodyTextField.text != ""{
            
            APIFunctions.functions.addNote(date: date, title: titleTextField.text!, note: bodyTextField.text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //    Delete button.
    @IBAction func deleteTapped(_ sender: Any) {
        
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Extensions.

//Extension for UITextViewDelegate.

extension addNoteViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add note"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            
            bodyTextField.text = "Add note"
            bodyTextField.textColor = UIColor.systemGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
