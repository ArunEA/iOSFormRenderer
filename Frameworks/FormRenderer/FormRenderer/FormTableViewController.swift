//
//  TableViewController.swift
//  FormRenderer
//
//  Created by Arun Eswaramurthi on 23/11/20.
//

import UIKit

class FormTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
	private weak var tableView: UITableView?
	private weak var controller: UIViewController?
	private var config: FormConfiguration
	private var lastPickedCell: ImagePickerTableViewCell?
	private var imagePicker: ImagePicker?
	private var dataManager: FormDataManager = FormDataManager.shared
	
	init(tableView: UITableView, controller: UIViewController, config: FormConfiguration) {
		self.tableView = tableView
		self.controller = controller
		self.config = config
		
		super.init()
		
		self.tableView?.dataSource = self
		self.tableView?.delegate = self
		self.registerCells()
		self.imagePicker = ImagePicker(presentationController: controller, delegate: self)
	}
	
	func refreshTable() {
		self.tableView?.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataManager.formData.count
	}
	
	private func registerCells() {
		tableView?.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.reuseId)
		tableView?.register(FootnoteButtonTableViewCell.self, forCellReuseIdentifier: FootnoteButtonTableViewCell.reuseId)
		tableView?.register(FromToDatePickerTableViewCell.self, forCellReuseIdentifier: FromToDatePickerTableViewCell.reuseId)
		tableView?.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.reuseId)
		tableView?.register(JustTextTableViewCell.self, forCellReuseIdentifier: JustTextTableViewCell.reuseId)
		tableView?.register(SegmentControlTableViewCell.self, forCellReuseIdentifier: SegmentControlTableViewCell.reuseId)
		tableView?.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.reuseId)
		tableView?.register(TextEditTableViewCell.self, forCellReuseIdentifier: TextEditTableViewCell.reuseId)
		tableView?.register(TextPickerTableViewCell.self, forCellReuseIdentifier: TextPickerTableViewCell.reuseId)
		tableView?.register(TwoLabelTableViewCell.self, forCellReuseIdentifier: TwoLabelTableViewCell.reuseId)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell? = nil
		
		let cellData = dataManager.formData[indexPath.row]
		
		switch cellData {
		case .date(let model):
			guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseId, for: indexPath) as? DatePickerTableViewCell else {
				return UITableViewCell()
			}
			
			dateCell.configure(model)
			dateCell.delegate = self
			cell = dateCell
			
		case .textEdit(let model):
			guard let textEditCell = tableView.dequeueReusableCell(withIdentifier: TextEditTableViewCell.reuseId, for: indexPath) as? TextEditTableViewCell else {
				return UITableViewCell()
			}
			
			textEditCell.configure(model)
			textEditCell.delegate = self
			cell = textEditCell
			
		case .textPicker(let model):
			guard let textPickerCell = tableView.dequeueReusableCell(withIdentifier: TextPickerTableViewCell.reuseId, for: indexPath) as? TextPickerTableViewCell else {
				return UITableViewCell()
			}
			
			textPickerCell.configure(model)
			textPickerCell.delegate = self
			cell = textPickerCell
			
		case .fromToDate(let model, let toModel):
			guard let dateCell = tableView.dequeueReusableCell(withIdentifier: FromToDatePickerTableViewCell.reuseId, for: indexPath) as? FromToDatePickerTableViewCell else {
				return UITableViewCell()
			}
			
			dateCell.delegate = self
			dateCell.configure(model, toModel: toModel)
			cell = dateCell
		
		case .imagePicker(let model):
			guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: ImagePickerTableViewCell.reuseId, for: indexPath) as? ImagePickerTableViewCell else {
				return UITableViewCell()
			}
			
			buttonCell.configure(model, delegate: self)
			cell = buttonCell
			
		case .toggle(let model):
			guard let toggleCell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseId, for: indexPath) as? SwitchTableViewCell else {
				return UITableViewCell()
			}
			
			toggleCell.configure(model, delegate: self, config: config)
			cell = toggleCell
			
		case .segment:
			guard let toggleCell = tableView.dequeueReusableCell(withIdentifier: SegmentControlTableViewCell.reuseId, for: indexPath) as? SegmentControlTableViewCell else {
				return UITableViewCell()
			}
			toggleCell.delegate = self
			cell = toggleCell
			
		case .text(let model):
			guard let textCell = tableView.dequeueReusableCell(withIdentifier: JustTextTableViewCell.reuseId, for: indexPath) as? JustTextTableViewCell else {
				return UITableViewCell()
			}
			
			textCell.configure(model)
			cell = textCell
			
		case .attrText(let model):
			guard let textCell = tableView.dequeueReusableCell(withIdentifier: JustTextTableViewCell.reuseId, for: indexPath) as? JustTextTableViewCell else {
				return UITableViewCell()
			}
			
			textCell.configure(model)
			cell = textCell
			
		case .button(let model):
			guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: FootnoteButtonTableViewCell.reuseId, for: indexPath) as? FootnoteButtonTableViewCell else {
				return UITableViewCell()
			}
			
			buttonCell.configure(model)
			cell = buttonCell
		
		case .twoLabel(let model):
			guard let infoCell = tableView.dequeueReusableCell(withIdentifier: TwoLabelTableViewCell.reuseId, for: indexPath) as? TwoLabelTableViewCell else {
				return UITableViewCell()
			}
			
			infoCell.configure(model)
			cell = infoCell
		}
		
		cell?.selectionStyle = .none
		
		return cell ?? UITableViewCell()
	}
}

extension FormTableViewController: CellDataFetchProtocol, TextPickerDelegate, FootnoteButtonDelegate, SegmentCellDelegate, SwitchCellDelegate, ImagePickerCellDelegate {
	func segmentTapped(key: String, _ value: String) {
		updateForm(for: key, value: value)
	}
	
	func toggleValueChanged(_ key: String, value: Bool) {
		updateForm(for: key, value: value)
	}
	
	func pickImage(_ key: String, cell: ImagePickerTableViewCell) {
		self.lastPickedCell = cell
		
		if let view = self.controller?.view {
			imagePicker?.present(from: view)
		}
	}
	
	func valueChanged(keyValuePair: (key: String, value: String)) {
		updateForm(for: keyValuePair.key, value: keyValuePair.value)
	}
	
	func didPickText(_ key: String, _ value: String) {
		updateForm(for: key, value: value)
	}
	
	func footnoteButtonCallback(_ title: String) {
		
	}
	
	private func updateForm(for key: String, value: Any) {
		do {
			try dataManager.updateValue(value, key: key)
		}
		catch FormError.incorrectDataType(let message) {
			print("FORM ERROR: This is not supposed to happen : ", message)
		} catch FormError.keyNotExist {
			print("FORM ERROR: This is not supposed to happen : Key doesn't exist")
		} catch {
			print("No other errors")
		}
	}
}

extension FormTableViewController: PickerDelegate {
	func didSelect(url: URL?, type: String) {
		if let filePath = url?.path, let image = UIImage(contentsOfFile: filePath) {
			if let value = image.jpegData(compressionQuality: 1.0), let key = self.lastPickedCell?.model?.key {
				updateForm(for: key, value: value)
			}
		}
		
	}
	
	func didCaptureImage(_ image: UIImage) {
		if let value = image.jpegData(compressionQuality: 1.0), let key = self.lastPickedCell?.model?.key {
			updateForm(for: key, value: value)
		}
	}
}
