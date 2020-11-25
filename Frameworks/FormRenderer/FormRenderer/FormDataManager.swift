//
//  FormDataManager.swift
//  FormRenderer
//
//  Created by KnilaDev on 25/11/20.
//

import Foundation

struct FormDataManager {
	static let shared = FormDataManager()
	
	var formData: [FormCellType] = []
	private var formValues: [String: Any] = [:]
	
	public func getFormValues() -> [String: Any] {
		return formValues
	}
	
	func getFormCellType(_ key: String) -> FormCellType? {
		return formData.first {
			$0.model.first { (model) -> Bool in
				return model.key == key
			} != nil
		}
	}
	
	mutating func updateValue(_ value: Any, key: String) throws {
		for cellType in formData {
			for model in cellType.model {
				if model.key == key {
					try model.updateValue(value)
					formValues[key] = value
					
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
