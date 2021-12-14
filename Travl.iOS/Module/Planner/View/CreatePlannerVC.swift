//
//  SetPlannerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 01/10/2021.
//

import UIKit

final class CreatePlannerVC : UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var createButton: UIBarButtonItem!
    
    //MARK: - Variables
    private let datePicker = UIDatePicker()
    private var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationTextfield.delegate = self
        configureDatePicker()
    }
    
    //MARK: - Action
    @IBAction func createPlannerTap(_ sender: UIBarButtonItem) {
        if let destination = destinationTextfield.text, let startDate = startDateTextField.text, let endDate = endDateTextField.text {
            let newPlanner = Planner(context: Constants.accessManageObjectContext)
            newPlanner.destination = destination
            newPlanner.startDate = startDate
            newPlanner.endDate = endDate
            self.saveObjectContext()
            // Store data to plist as reference to pass data to unrelated VC
             UserDefaults.standard.set(newPlanner.destination, forKey: "parentPlanner")
            print("New Planner : \(newPlanner)")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func selectNextDate() {
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        startDateTextField.resignFirstResponder()
    
        endDateTextField.becomeFirstResponder()
    }
    
    @objc func doneSelectDate() {
        createButton.isEnabled = true
        
        endDateTextField.text = dateFormatter.string(from: datePicker.date)
        endDateTextField.resignFirstResponder()
    }
    
    private func saveObjectContext() {
        do {
            try  Constants.accessManageObjectContext.save()
        } catch {
            print("Fail to save created Planner in CoreData : \(error.localizedDescription)")
        }
    }
}

//MARK: - Private Methods
extension CreatePlannerVC {
    
    private func configureDatePicker() {
        
        if !destinationTextfield.text!.isEmpty, !startDateTextField.text!.isEmpty, !endDateTextField.text!.isEmpty {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        
        
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        let startDateToolbar = UIToolbar()
        startDateToolbar.sizeToFit()
        
        let endDateToolbar = UIToolbar()
        endDateToolbar.sizeToFit()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(selectNextDate))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneSelectDate))
        
        startDateToolbar.setItems([nextButton], animated: true)
        endDateToolbar.setItems([doneBtn], animated: true)
        
        startDateTextField.inputAccessoryView = startDateToolbar
        endDateTextField.inputAccessoryView = endDateToolbar
    }
}

//MARK: - UITextField delegate
extension CreatePlannerVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            destinationTextfield.placeholder! += "?"
            return false
        } else {
            startDateTextField.becomeFirstResponder()
            return true
        }
    }
}
