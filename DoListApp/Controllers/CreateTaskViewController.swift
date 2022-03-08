//
//  CreateTaskViewController.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//

import UIKit
import CoreData
import Lottie

class CreateTaskViewController: UIViewController, UITextFieldDelegate, UIAnimatable {
    
    var coreData = CoreDataManager()
    let category = [ "Work", "Travelling", "Home", "Shopping", "Study", "Food"]
    var userCategory: String?
    var callback : (() -> Void)?
  
    
    
    private let headerView:UIView = {
        let header = UIView()
        let lable = UILabel(frame: CGRect(x: 10 , y: 20, width: 300, height: 150))
        lable.text = "CREATE NEW TASK"
        lable.lineBreakMode = .byWordWrapping
        lable.font = .systemFont(ofSize: 30)
        header.addSubview(lable)
        header.clipsToBounds = true
        header.contentMode = .scaleAspectFit
        return header
    }()
    
    private let textField: TextField  = {
        var textField = TextField()
        textField.placeholder = "Task text..."
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .systemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.contentMode = .left
        datePicker.contentMode = .scaleAspectFit
        return datePicker
    }()
    
    private let saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .systemPink
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.contentMode = .scaleAspectFit
        return saveButton
    }()
    
    private let cancelButton: UIButton = {
        var cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 8
        cancelButton.backgroundColor = .systemPink
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.contentMode = .scaleAspectFit
        return cancelButton
    }()
    
    private let categoryPicker: UIPickerView = {
        var categoryPicker = UIPickerView()
        categoryPicker.contentMode = .scaleAspectFit
        return categoryPicker
        
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.contentMode = .scaleAspectFit
        categoryLabel.text = "CHOOSE CATEGORY AND DATE"
        return categoryLabel
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.contentMode = .scaleAspectFit
        view.contentMode = .scaleAspectFit
        self.hideKeyboardWhenTappedAround() 
        
        
        textField.delegate = self
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        saveButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
       
        view.addSubview(textField)
        view.addSubview(datePicker)
        view.addSubview(headerView)
        view.addSubview(categoryPicker)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        view.addSubview(categoryLabel)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTaskViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTaskViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "headerView2")!)
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.bounds.width,
                                  height: view.bounds.height/3.5)
        categoryLabel.frame = CGRect(x: 10,
                                     y: headerView.bottom + 10,
                                     width: view.frame.size.width - 20,
                                     height: view.frame.height / 9)
        categoryPicker.frame = CGRect(x: 0,
                                      y: categoryLabel.bottom + 10,
                                      width: view.frame.size.width - 10,
                                      height: view.frame.height / 11)
        textField.frame = CGRect(x: 10,
                                 y: datePicker.bottom + 20,
                                 width: view.frame.size.width - 20,
                                 height: view.frame.height / 9 )
        datePicker.frame = CGRect(x: 0,
                                  y: categoryPicker.bottom + 10,
                                  width: view.frame.size.width - 20,
                                  height: view.frame.size.height / 16)
        saveButton.frame = CGRect(x: 25,
                                  y: textField.bottom + 30,
                                  width: view.frame.width - 50,
                                  height: view.frame.size.height / 16)
        cancelButton.frame = CGRect(x: 25,
                                    y: saveButton.bottom + 15,
                                    width: view.frame.width - 50,
                                    height: view.frame.size.height / 16)
      //  view.addSubview(animationView)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
    }
    
    
    @objc func goBack(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        nextViewController.modalPresentationStyle = .fullScreen
        callback?()
        self.dismiss(animated: true)
    }
    
    
    @objc func saveTask() {
        
        //  UIPicker data
        let row = categoryPicker.selectedRow(inComponent: 0)
        pickerView(categoryPicker, didSelectRow: row, inComponent:0)
        
        guard let text = self.textField.text  else {
            return
        }
        
        if text.isEmpty {
            
            let ac = UIAlertController(title: "", message: "Please, provide task text!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        } else {
            
            // UIAlertController has been replaced with animation
            //let ac = UIAlertController(title: "", message: "Task has been saved!", preferredStyle: .alert)
           // ac.addAction(UIAlertAction(title: "Ok", style: .default){ [weak self] action in
            
            showAnimation(animation: "done-animation")
            
            guard let userCategory = userCategory else {
                return
            }
            
            let dateString = getDate(date: datePicker.date)
            
            insertValueWithKey(context: coreData.context, taskText: text, date: dateString, category: userCategory)
            
            textField.text?.removeAll()
            categoryPicker.reloadAllComponents()
            datePicker.date = .now
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: goBack)
            
          // present(ac, animated: true)
            
        }
    }
    
    // converting date into string
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = datePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        return dateString
    }
    
    // save task in CoreData
    
    func insertValueWithKey(context: NSManagedObjectContext,taskText: String, date: String, category: String){
        
        
        do {
            
            let paramsDescription = NSEntityDescription.entity(forEntityName: "UserTasks", in: context)
            let params = NSManagedObject(entity: paramsDescription!, insertInto: context) as! UserTasks
            params.taskText = taskText
            params.date = date
            params.category = category
            
            do {
                try context.save()
                
                // handling errors if operation wasn't sucessful
                
            }
            catch let error as NSError {
                
                let ac = UIAlertController(title: "Something went wrong", message: "We were unable to save yout task, please try again \(error.localizedDescription)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(ac, animated: true)
                
            }
            
        }
    }
}

// MARK: UIPicker delegate, datascource

extension CreateTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.width - 20
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCategory = category[row]
        userCategory = selectedCategory
    }
    
}
