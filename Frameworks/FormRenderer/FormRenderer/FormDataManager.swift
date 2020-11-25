//
//  FormDataManager.swift
//  FormRenderer
//
//  Created by KnilaDev on 25/11/20.
//

import Foundation

class FormDataManager {
	var formData: [FormCellType] = []
	
	func getFormValues() -> [String: Any?] {
		var formValues = [String: Any?]()
		
		formData.forEach { (type) in
			type.model.forEach { (cellModel) in
				if let key = cellModel.key {
					formValues[key] = cellModel.value
				}
			}
		}
		
		return formValues
	}
	
	func value(for key: String) -> Any? {
		for cellType in formData {
			for model in cellType.model {
				if model.key == key {
					return model.value
				}
			}
		}
		
		return nil
	}
	
	func cellModel(for key: String) -> CellModelType? {
		for cellType in formData {
			for model in cellType.model {
				if model.key == key {
					return model
				}
			}
		}
		
		return nil
	}
	
	func getFormCellType(_ key: String) -> FormCellType? {
		return formData.first {
			$0.model.first { (model) -> Bool in
				return model.key == key
			} != nil
		}
	}
	
	func updateValue(_ value: Any, key: String) throws {
		for cellType in formData {
			for model in cellType.model {
				if model.key == key {
					try model.updateValue(value)
					
					return
				}
			}
		}
		
		throw FormError.keyNotExist
	}
}

enum FormError: Error {
	case incorrectDataType(String)
	case keyNotExist
}
