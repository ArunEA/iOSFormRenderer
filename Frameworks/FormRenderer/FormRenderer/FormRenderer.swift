//
//  FormRenderer.swift
//  FormRenderer
//
//  Created by KnilaDev on 23/11/20.
//

import UIKit

public struct FormRenderer {
	private var config: FormConfiguration = FormConfiguration()
	private var tableController: FormTableViewController
	private var dataManager = FormDataManager()
	
	public init(_ formData: [FormCellType], tableView: UITableView, controller: UIViewController, config: FormConfiguration? = nil) {
		if let config = config {
			self.config = config
		} else {
			self.config = FormConfiguration()
		}
		
		FormConfiguration.current = self.config
		self.tableController = FormTableViewController(tableView: tableView, controller: controller, config: self.config, dataManager: dataManager)
		dataManager.formData = formData
	}
	
	public func reloadForm() {
		self.tableController.refreshTable()
	}
	
	public func formValues() -> [String: Any?] {
		tableController.endEditing()
		
		return dataManager.getFormValues()
	}
	
	public func value(for key: String) -> Any? {
		return dataManager.value(for: key)
	}
	
	public mutating func replaceAllFormValues(_ values: [FormCellType]) {
		dataManager.formData = values
		
		self.tableController.refreshTable()
	}
	
	public mutating func cellModel(for key: String) -> CellModelType? {
		return dataManager.cellModel(for: key)
	}
	
	public mutating func updateFormValue(_ value: FormCellType) {
		if let formTypeIndex = dataManager.formData.firstIndex(where: { $0 == value }) {
			dataManager.formData[formTypeIndex] = value
		}
		
		self.tableController.refreshTable()
	}
	
	public mutating func appendFormValues(_ value: FormCellType) {
		dataManager.formData.append(value)
		
		self.tableController.refreshTable()
	}
	
	public mutating func appendFormValues(_ values: [FormCellType]) {
		dataManager.formData.append(contentsOf: values)
		
		self.tableController.refreshTable()
	}
	
	mutating func insertFormValues(at index: Int, values: [FormCellType]) {
		dataManager.formData.insert(contentsOf: values, at: index)
		
		self.tableController.refreshTable()
	}
	
	public mutating func removeFormValue(at index: Int) {
		dataManager.formData.remove(at: index)
		
		self.tableController.refreshTable()
	}
	
	public mutating func removeFormValue(value: FormCellType) {
		dataManager.formData.removeAll { $0 == value }
		
		self.tableController.refreshTable()
	}
}
