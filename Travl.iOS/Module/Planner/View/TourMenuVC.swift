//
//  TourMenuVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit
import CoreData

final class TourMenuVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endsDateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!
    
    //MARK: - Variables
    private var datePicker = UIDatePicker()
    private var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM d, y"
        return formatter
    }()
    
    var navBarLabel : String?
    var plannerData : Planner?
    
    var destinationName : String! {
        didSet {
            print("KEY DESTINATION : \(String(describing: destinationName))")
            fetchParentPlannerData()
        }
    }
    
    let context = Constants.accessManageObjectContext
    
    override func viewWillAppear(_ animated: Bool) {
        fetchParentPlannerData()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        configureDate()
    }
    
    //MARK: - Actions
    @IBAction func saveTap(_ sender: UIBarButtonItem) {
        
        let activity = Activity(context: Constants.accessManageObjectContext)
        activity.name = title!
        activity.address = addressTextField.text!
        activity.startDate = startDateTextField.text!
        activity.endDate = endsDateTextField.text!
        activity.parentPlanner = plannerData!
        print("Planner Data : \(String(describing: plannerData))")
        try! context.save()
        
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Dismiss"), object: nil, userInfo: [:]))
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.text!.isEmpty || addressTextField.text!.isEmpty || startDateTextField.text!.isEmpty || endsDateTextField.text!.isEmpty {
            saveBarBtn.isEnabled = false
        } else {
            saveBarBtn.isEnabled = true
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
    
    func fetchParentPlannerData(with request : NSFetchRequest<Planner> = Planner.fetchRequest(), predicate : NSPredicate? = nil){
        
        let predicate = NSPredicate(format: "destination MATCHES %@", "\(destinationName!)")
        request.predicate = predicate
        
        do {
            let planner = try context.fetch(request)
            plannerData = planner.first
            
        } catch {
            print("Error fetch data : \(error.localizedDescription)")
        }
    }
    
    private func configureDate() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
 
        let endDate = dateFormatter.date(from: plannerData!.endDate)
        let startDate = dateFormatter.date(from: plannerData!.startDate)
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
        saveBarBtn.isEnabled = false
        title = navBarLabel
        
        nameTextField.delegate = self
        addressTextField.delegate = self
        startDateTextField.delegate = self
        endsDateTextField.delegate = self
        phoneTextField.delegate = self
        websiteTextField.delegate = self
        notesTextField.delegate = self
    }
}

