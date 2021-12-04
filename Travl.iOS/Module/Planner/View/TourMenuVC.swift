//
//  TourMenuVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit

protocol TourMenuVCDelegate : AnyObject {
    func presentTourActivity(_ tourVC : TourMenuVC, activity : Activity)
}

final class TourMenuVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var selectedActivityLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endsDateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    //MARK: - Variables
    private var datePicker = UIDatePicker()
    private var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM d, y"
        return formatter
    }()
    
    weak var delegate : TourMenuVCDelegate?
    var navBarLabel : String?
    var plannerData : Planner?
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        configureDate()
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
        let activity = Activity(category: selectedActivityLabel.text, name: nameTextField.text ?? "", address: addressTextField.text, startDate: startDateTextField.text ?? "\(Date())", endDate: endsDateTextField.text ?? "\(Date())", phoneNumber: phoneTextField.text, website: websiteTextField.text, notes: notesTextField.text)
        print("Activity pass from TourMenuVC is : \(activity)")
        delegate?.presentTourActivity(self, activity: activity)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Dismiss"), object: nil, userInfo: [:]))
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextField Delegate
extension TourMenuVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField :
            addressTextField.becomeFirstResponder()
            return true
        case addressTextField :
            startDateTextField.becomeFirstResponder()
            return true
        case startDateTextField :
            endsDateTextField.becomeFirstResponder()
            return true
        case endsDateTextField :
            phoneTextField.becomeFirstResponder()
            return true
        case phoneTextField :
            websiteTextField.becomeFirstResponder()
            return true
        case websiteTextField:
            notesTextField.becomeFirstResponder()
            return true
        case notesTextField :
            notesTextField.resignFirstResponder()
            return true
        default :
            return false
        }
    }
}


//MARK: - Private Methods
extension TourMenuVC {
    
    @objc private func doneToolBarTap(_ UIBarButtonItem : UIBarButtonItem) {
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        
        if startDateTextField.isEditing {
            startDateTextField.text = dateFormatter.string(from: datePicker.date)
            endsDateTextField.becomeFirstResponder()
        } else if endsDateTextField.isEditing {
            startDateTextField.resignFirstResponder()
            endsDateTextField.text = dateFormatter.string(from: datePicker.date)
            endsDateTextField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        }
    }
    
    private func configureDate() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        let endDate = dateFormatter.date(from: plannerData!.endDate)
        let startDate = dateFormatter.date(from: plannerData!.startDate)
//        print("START DATE : \(startDate!)")
//        print("END DATE : \(endDate!)")
        datePicker.minimumDate = startDate
        datePicker.maximumDate = endDate
        
        startDateTextField.inputView = datePicker
        endsDateTextField.inputView = datePicker
        
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(doneToolBarTap(_:)))
        
        dateToolbar.setItems([nextButton], animated: true)
        
        startDateTextField.inputAccessoryView = dateToolbar
        endsDateTextField.inputAccessoryView = dateToolbar
    }
    
    private func renderView() {
        selectedActivityLabel.text = navBarLabel
        
        nameTextField.delegate = self
        addressTextField.delegate = self
        startDateTextField.delegate = self
        endsDateTextField.delegate = self
        phoneTextField.delegate = self
        websiteTextField.delegate = self
        notesTextField.delegate = self
    }
}

