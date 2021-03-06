//
//  TourMenuVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit

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
    var navBarLabel : String?
    var destinationName : String! {
        didSet {
            presenter.setViewDelegate(delegate: self)
            print("KEY DESTINATION : \(String(describing: destinationName!))")
            presenter.fetchParentPlanner(destinationName)
        }
    }
    private var datePicker : UIDatePicker = {
        let start = UserDefaults.standard.object(forKey: Constants.UserDefautlsKey.parentStartDate)  as! Date
        let end = UserDefaults.standard.object(forKey: Constants.UserDefautlsKey.parentEndDate)  as! Date
        let date = UIDatePicker()
        date.minimumDate = start
        date.maximumDate = end
        return date
    }()
    
    private var dateFormatter = DateFormatter()
    private var plannerData : Planner?
    private let presenter = TourMenuPresenter()
    private let analytic = AnalyticManager(engine: MixPanelAnalyticEngine())

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        analytic.log(.createActivitiesScreenView)
        renderView()
        configureDate()
    }
    
    //MARK: - Actions
    @IBAction func saveTap(_ sender: UIBarButtonItem) {
        presenter.didSaveButtonTap()
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
//MARK: - Presenter Delegate
extension TourMenuVC :TourMenuPresenterDelegate {
    func presentFetchParentPlanner(_ TourMenuPresenter: TourMenuPresenter, data: Planner) {
        DispatchQueue.main.async { [weak self] in
            print("DATAAA :\(data)")
            self?.plannerData = data
        }
    }
    
    func presentActionForSaveTap(_ TourMenuPresenter: TourMenuPresenter) {
        presenter.saveNewActivity(category :title!,name: nameTextField.text!, address: addressTextField.text!, startDate: startDateTextField.text!, endDate: endsDateTextField.text!, parentPlanner: plannerData!, phoneNumber: phoneTextField.text ?? "N/A", website: websiteTextField.text ?? "N/A", notes: notesTextField.text ?? "N/A")
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Dismiss"), object: nil, userInfo: [:]))
        analytic.log(.addNewActivities)
    }
}

//MARK: - Private Methods
extension TourMenuVC {
    @objc private func doneToolBarTap(_ UIBarButtonItem : UIBarButtonItem) {
        if startDateTextField.isEditing {
            startDateTextField.text = dateFormatter.convertDateToString(datePicker.date)
            endsDateTextField.becomeFirstResponder()
        } else if endsDateTextField.isEditing {
            startDateTextField.resignFirstResponder()
            endsDateTextField.text = dateFormatter.convertDateToString(datePicker.date)
            endsDateTextField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        }
    }
    
    private func configureDate() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
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

