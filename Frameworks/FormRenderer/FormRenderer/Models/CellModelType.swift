//
//  CellTypeProtocol.swift
//  FormRenderer
//
//  Created by KnilaDev on 23/11/20.
//

import UIKit

public protocol CellModelType {
	var key: String? { get set }
	var value: Any? { get }
	func updateValue(_ value: Any) throws
}

public class DatePickerModel: CellModelType {
	public var key: String?
	public var dateValue: Date?
	
	public var minDate: Date?
	public var maxDate: Date?
	
	public var contextText: String?
	public var isEnabled: Bool = true
	
	public var value: Any? {
		return dateValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.dateValue = value.toDate
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String, minDate: Date? = nil, maxDate: Date? = nil, dateValue: Date? = nil, contextText: String, isEnabled: Bool = true) {
		self.key = key
		self.minDate = minDate
		self.maxDate = maxDate
		self.dateValue = dateValue
		self.contextText = contextText
		self.isEnabled = isEnabled
	}
	
	public convenience init(key: String, dateString: String? = nil, contextText: String, isEnabled: Bool = true) {
		let date = dateString?.toDate
		self.init(key: key, dateValue: date, contextText: contextText, isEnabled: isEnabled)
	}
}

public class ImagePickerModel: CellModelType {
	public var key: String?
	public var titleText: String?
	public var contextText: String?
	public var imageUrl: URL?
	var imageData: Data?
	
	public var value: Any? {
		return imageData
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? (URL, Data) {
			self.imageUrl = value.0
			self.imageData = value.1
		} else if let value = value as? (String, Data) {
			self.titleText = value.0
			self.imageData = value.1
		} else {
			throw FormError.incorrectDataType("Incorrect data type, URL or String with Data type is expected")
		}
	}
	
	public init(key: String?, titleText: String?, contextText: String?) {
		self.key = key
		self.titleText = titleText
		self.contextText = contextText
	}
}

public class SegmentControlModel: CellModelType {
	public var key: String?
	public var selectedItem: String?
	public var items: [String]
	
	public var value: Any? {
		return selectedItem
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.selectedItem = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String? = nil, items: [String], selectedItem: String? = nil) {
		self.key = key
		self.items = items
		self.selectedItem = selectedItem
	}
}

public class ToggleViewModel: CellModelType {
	public var key: String?
	public var attrContextText: NSAttributedString?
	public var contextText: String?
	public var defaultValue: Bool
	
	public var value: Any? {
		return defaultValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? Bool {
			self.defaultValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, Bool type is expected")
		}
	}
	
	public init(key: String, contextText: String? = nil, attrContextText: NSAttributedString? = nil, defaultValue: Bool = false) {
		self.key = key
		self.contextText = contextText
		self.attrContextText = attrContextText
		self.defaultValue = defaultValue
	}
}

public class TextEditModel: CellModelType {
	public var key: String?
	public var isSecure: Bool = false
	public var textValue: String?
	public var placeHolder: String?
	public var keyBoardType: UIKeyboardType
	public var isEnabled: Bool = true
	public var shouldAddBorder: Bool = true
	public var contextText: String?
	
	public var value: Any? {
		return textValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String, textValue: String? = nil, contextText: String, placeHolder: String? = nil, keyboardType: UIKeyboardType = .default, isSecure: Bool = false, enabled: Bool = true, shouldAddBorder: Bool = true) {
		self.key = key
		self.isSecure = isSecure
		self.textValue = textValue
		self.contextText = contextText
		self.keyBoardType = keyboardType
		self.placeHolder = placeHolder
		self.isEnabled = enabled
		self.shouldAddBorder = shouldAddBorder
	}
}

public class TextPickerModel: CellModelType {
	public var key: String?
	public var textValue: String?
	public var placeHolder: String?
	
	public var allValues: [String]?
	public var contextText: String?
	public var isEnabled: Bool = true
	public var shouldAddBorder: Bool = true
	
	public var value: Any? {
		return textValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String, textValue: String? = nil, allValues: [String], contextText: String, placeHolder: String? = nil, isEnabled: Bool = true, shouldAddBorder: Bool = true) {
		self.key = key
		self.textValue = textValue
		self.allValues = allValues
		self.contextText = contextText
		self.placeHolder = placeHolder
		self.isEnabled = isEnabled
		self.shouldAddBorder = shouldAddBorder
	}
}

public protocol TextDisplayModel: CellModelType {
	var alignment: NSTextAlignment { get set }
}

public class SimpleTextDisplayModel: TextDisplayModel {
	public var key: String?
	public var alignment: NSTextAlignment
	public var textValue: String?
	
	public var value: Any? {
		return textValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String? = nil, textValue: String? = nil, alignment: NSTextAlignment = .natural) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
	}
}

public class AttrTextDisplayModel: TextDisplayModel {
	public var key: String?
	public var alignment: NSTextAlignment
	public var textValue: NSAttributedString
	
	public var value: Any? {
		return textValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? NSAttributedString {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, NSAttributedString type is expected")
		}
	}
	
	public init(key: String? = nil, textValue: NSAttributedString, alignment: NSTextAlignment = .natural) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
	}
}

public class TwoTextDisplayModel: CellModelType {
	public var key: String?
	public var leftText: String?
	public var rightText: String?
	public var leftAlignment: NSTextAlignment
	public var rightAlignment: NSTextAlignment
	
	public var value: Any? {
		return (leftText, rightText)
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? (String, String) {
			self.leftText = value.0
			self.rightText = value.1
		} else {
			throw FormError.incorrectDataType("Incorrect data type, (String, String) type is expected")
		}
	}
	
	public init(key: String? = nil, leftText: String? = nil, rightText: String? = nil, leftAlignment: NSTextAlignment = .natural, rightAlignment: NSTextAlignment = .natural) {
		self.key = key
		self.leftText = leftText
		self.rightText = rightText
		self.leftAlignment = leftAlignment
		self.rightAlignment = rightAlignment
	}
}

public class ButtonCellModel: CellModelType {
	public var key: String?
	public var textValue: String
	public var alignment: NSTextAlignment
	weak var delegate: CellButtonDelegate?
	
	public var value: Any? {
		return textValue
	}
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	public init(key: String? = nil, textValue: String, alignment: NSTextAlignment = .natural, delegate: CellButtonDelegate? = nil) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
		self.delegate = delegate
	}
}
