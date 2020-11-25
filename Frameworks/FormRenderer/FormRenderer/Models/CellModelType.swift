//
//  CellTypeProtocol.swift
//  FormRenderer
//
//  Created by KnilaDev on 23/11/20.
//

import UIKit

public protocol CellModelType {
	var key: String? { get set }
	func updateValue(_ value: Any) throws
}

public class DatePickerModel: CellModelType {
	public var key: String?
	var dateValue: Date?
	
	var minDate: Date?
	var maxDate: Date?
	
	var contextText: String?
	var isEnabled: Bool = true
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? Date {
			self.dateValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, Date type is expected")
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
	var titleText: String?
	var contextText: String?
	var imageUrl: URL?
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? URL {
			self.imageUrl = value
		} else if let value = value as? String {
			self.titleText = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, URL or String type is expected")
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
	var selectedItem: String?
	var items: [String]
	
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
	var contextText: NSAttributedString
	var defaultValue: Bool
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? Bool {
			self.defaultValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, Bool type is expected")
		}
	}
	
	public init(key: String, contextText: NSAttributedString, defaultValue: Bool = false) {
		self.key = key
		self.contextText = contextText
		self.defaultValue = defaultValue
	}
}

public class TextEditModel: CellModelType {
	public var key: String?
	var isSecure: Bool = false
	var textValue: String?
	var placeHolder: String?
	var keyBoardType: UIKeyboardType
	var enabled: Bool = true
	var shouldAddBorder: Bool = true
	
	var contextText: String?
	
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
		self.enabled = enabled
		self.shouldAddBorder = shouldAddBorder
	}
}

public class TextPickerModel: CellModelType {
	public var key: String?
	var textValue: String?
	var placeHolder: String?
	
	var allValues: [String]?
	var contextText: String?
	var isEnabled: Bool = true
	var shouldAddBorder: Bool = true
	
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
	var textValue: String?
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	internal init(key: String? = nil, textValue: String? = nil, alignment: NSTextAlignment = .natural) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
	}
}

public class AttrTextDisplayModel: TextDisplayModel {
	public var key: String?
	public var alignment: NSTextAlignment
	var textValue: NSAttributedString
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? NSAttributedString {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, NSAttributedString type is expected")
		}
	}
	
	internal init(key: String? = nil, textValue: NSAttributedString, alignment: NSTextAlignment = .natural) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
	}
}

public class TwoTextDisplayModel: CellModelType {
	public var key: String?
	var leftText: String?
	var rightText: String?
	var leftAlignment: NSTextAlignment
	var rightAlignment: NSTextAlignment
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? (String, String) {
			self.leftText = value.0
			self.rightText = value.1
		} else {
			throw FormError.incorrectDataType("Incorrect data type, (String, String) type is expected")
		}
	}
	
	internal init(key: String? = nil, leftText: String? = nil, rightText: String? = nil, leftAlignment: NSTextAlignment = .natural, rightAlignment: NSTextAlignment = .natural) {
		self.key = key
		self.leftText = leftText
		self.rightText = rightText
		self.leftAlignment = leftAlignment
		self.rightAlignment = rightAlignment
	}
}

public class ButtonCellModel: CellModelType {
	public var key: String?
	var textValue: String
	var alignment: NSTextAlignment
	weak var delegate: FootnoteButtonDelegate?
	
	public func updateValue(_ value: Any) throws {
		if let value = value as? String {
			self.textValue = value
		} else {
			throw FormError.incorrectDataType("Incorrect data type, String type is expected")
		}
	}
	
	internal init(key: String? = nil, textValue: String, alignment: NSTextAlignment = .natural, delegate: FootnoteButtonDelegate? = nil) {
		self.key = key
		self.textValue = textValue
		self.alignment = alignment
		self.delegate = delegate
	}
}
