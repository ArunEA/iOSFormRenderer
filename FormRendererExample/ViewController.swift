//
//  ViewController.swift
//  FormRendererExample
//
//  Created by KnilaDev on 24/11/20.
//

import UIKit
import FormRenderer

class ViewController: UIViewController, CellButtonDelegate {

	@IBOutlet var tableView: UITableView!
	
	private var renderer: FormRenderer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		/*
			Construct the form using these array of values
			
			1. Each cell is denoted by a FormCellType and should be supplied with a subclass of CellModelType
			2. Key should be supplied if you need the value entered by user
		*/
		
		let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.systemGreen]
		let attributedQuote = NSAttributedString(string: "Well, How you doin!", attributes: attributes)
		
		let cellData: [FormCellType] = [
			.textEdit(
				TextEditModel(key: "fullName", textValue: nil, contextText: "Full Name", placeHolder: "Enter Full Name", keyboardType: .default, isSecure: false, enabled: true, shouldAddBorder: true)
			),
			.textEdit(
				TextEditModel(key: "password", textValue: nil, contextText: "Password", placeHolder: "Enter Password", keyboardType: .default, isSecure: true, enabled: true, shouldAddBorder: true)
			),
			.textPicker(
				TextPickerModel(key: "userType", textValue: nil, allValues: ["Individual", "Company"], contextText: "User Type", placeHolder: "Select User Type", isEnabled: true, shouldAddBorder: true)
			),
			.date(
				DatePickerModel(key: "dob", minDate: nil, maxDate: Date(), dateValue: nil, contextText: "Date of Birth", isEnabled: true)
			),
			.fromToDate(
				DatePickerModel(key: "fromYear", contextText: "Experience From"), DatePickerModel(key: "toYear", contextText: "To")
			),
			.imagePicker(
				ImagePickerModel(key: "profileImage", titleText: "Pick a Profile Image", contextText: "Profile Image")
			),
			.segment(
				SegmentControlModel(key: "ageGroup", items: ["Under 18", "18 to 24", "Above 24"], selectedItem: nil)
			),
			.toggle(
				ToggleViewModel(key: "copyRightInfo", contextText: "Do you agree to the terms and conditions", defaultValue: false)
			),
			.text(
				SimpleTextDisplayModel(key: nil, textValue: "The above mentioned information will be used only by our services and will not be disclosed anywhere else", alignment: .natural)
			),
			.attrText(
				AttrTextDisplayModel(textValue: attributedQuote)
			),
			.button(
				ButtonCellModel(key: nil, textValue: "Hello, this is a button", alignment: .center, delegate: self)
			)
		]
		
		// Create the renderer by supplying a [FormCellType], tableView, UIViewController and FormConfiguration
		// FormConfiguration can be nil (Will take default values)
		
		let config = FormConfiguration(themeColor: .systemIndigo, altThemeColor: .systemPink)
		renderer = FormRenderer(cellData, tableView: tableView, controller: self, config: config)
		
		// Reload form to refresh
		renderer?.reloadForm()
	}

	@IBAction func submit(_ sender: Any) {
		// Fetch all values from Form
		if let allValues = renderer?.formValues() {
			print(allValues)
		}
		
		// Access a specific value by key
		if let valueForPickerCell = renderer?.value(for: "userType") {
			print(valueForPickerCell)
		}
		
		// Change the attributes of any cell by accessing its model
		let model = renderer?.cellModel(for: "userType")
		if let model = model as? TextEditModel {
			model.isEnabled = false
		}
		
		// Reload to refresh
		renderer?.reloadForm()
	}
	
	
	func cellButtonCallback(_ title: String) {
		print(title, " Tapped!")
	}
}

