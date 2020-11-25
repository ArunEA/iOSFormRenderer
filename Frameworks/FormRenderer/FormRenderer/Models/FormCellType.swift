//
//  FormCellType.swift
//  FormRenderer
//
//  Created by KnilaDev on 23/11/20.
//

import UIKit

public enum FormCellType: Equatable {
	// Text input
	case textEdit(TextEditModel)
	case textPicker(TextPickerModel)
	
	// Date
	case date(DatePickerModel)
	case fromToDate(DatePickerModel, DatePickerModel)
	
	// Image
	case imagePicker(ImagePickerModel)
	
	// Others
	case segment(SegmentControlModel)
	case toggle(ToggleViewModel)
	
	// Text display
	case text(SimpleTextDisplayModel)
	case attrText(AttrTextDisplayModel)
	case twoLabel(TwoTextDisplayModel)
	
	// Button
	case button(ButtonCellModel)
	
	public static func ==(lhs: FormCellType, rhs: FormCellType) -> Bool {
		switch (lhs, rhs) {
		case let (.textEdit(a), .textEdit(b)):
			return a.key == b.key
		case let (.textPicker(a), .textPicker(b)):
			return a.key == b.key
		case let (.date(a), .date(b)):
			return a.key == b.key
		case let (.fromToDate(a1, a2), .fromToDate(b1, b2)):
			return a1.key == b1.key && a2.key == b2.key
		case let (.imagePicker(a), .imagePicker(b)):
			return a.key == b.key
		case let (.toggle(a), .toggle(b)):
			return a.key == b.key
		case let (.segment(a), .segment(b)):
			return a.key == b.key
		case let (.text(a), .text(b)):
			return a.key == b.key
		case let (.attrText(a), .attrText(b)):
			return a.key == b.key
		case let (.twoLabel(a), .twoLabel(b)):
			return a.key == b.key
		case let (.button(a), .button(b)):
			return a.key == b.key
		default:
			return false
		}
	}
	
	var model: [CellModelType] {
		switch self {
		case .textEdit(let model):
			return [model]
		case .textPicker(let model):
			return [model]
		case .date(let model):
			return [model]
		case .fromToDate(let fromModel, let toModel):
			return [fromModel, toModel]
		case .imagePicker(let model):
			return [model]
		case .segment(let model):
			return [model]
		case .toggle(let model):
			return [model]
		case .text(let model):
			return [model]
		case .attrText(let model):
			return [model]
		case .twoLabel(let model):
			return [model]
		case .button(let model):
			return [model]
		}
	}
}
