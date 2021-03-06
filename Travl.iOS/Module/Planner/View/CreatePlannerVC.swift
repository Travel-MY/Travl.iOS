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
    private let presenter = CreatePlannerPresenter()
    private let analytic = AnalyticManager(engine: MixPanelAnalyticEngine())
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.minimumDate = Date()
        picker.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        return picker
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        destinationTextfield.delegate = self
        configureDatePicker()
    }
    //MARK: - Action
    @IBAction func createPlannerTap(_ sender: UIBarButtonItem) {
        if let destination = destinationTextfield.text, let startDate = startDateTextField.text, let endDate = endDateTextField.text {
            let sDate = DateFormatter().convertStringToDate(startDate)
            let eDate = DateFormatter().convertStringToDate(endDate)
            presenter.didTapCreatePlanner(destination, sDate, eDate)
        }
    }
    
    @objc func selectNextDate() {
        startDateTextField.text = DateFormatter().convertDateToString(datePicker.date)
        startDateTextField.resignFirstResponder()
        endDateTextField.becomeFirstResponder()
    }
    
    @objc func doneSelectDate() {
        createButton.isEnabled = true
        endDateTextField.text = DateFormatter().convertDateToString(datePicker.date)
        endDateTextField.resignFirstResponder()
    }
}
//MARK: - Presenter Delegate
extension CreatePlannerVC : CreatePlannerPresenterDelegate {
    func presentActionForCreatePlanner(_ CreatePlannerPresenter: CreatePlannerPresenter) {
    analytic.log(.addNewPlanner)
       navigationController?.popToRootViewController(animated: true)
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
//MARK: - Private Methods
extension CreatePlannerVC {
    private func configureDatePicker() {
        if !destinationTextfield.text!.isEmpty, !startDateTextField.text!.isEmpty, !endDateTextField.text!.isEmpty {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
        
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
