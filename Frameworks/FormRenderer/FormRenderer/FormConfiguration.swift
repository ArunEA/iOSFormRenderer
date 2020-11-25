//
//  FormConfiguration.swift
//  FormRenderer
//
//  Created by KnilaDev on 23/11/20.
//

import UIKit

public class FormConfiguration {
	static var current = FormConfiguration()
	
	public var themeColor: UIColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1)
	public var altThemeColor: UIColor = UIColor(red: 0.7, green: 0.94, blue: 1, alpha: 1)
	
	public var textFieldBorderColor: UIColor?
	public var segmentSelectedColor: UIColor?
	public var segmentTextColor: UIColor?
	public var segmentSelectedTextColor: UIColor?
	public var toggleOnColor: UIColor?
	public var toggleOffColor: UIColor?
	
	public init(themeColor: UIColor = UIColor.clear, altThemeColor: UIColor = UIColor.clear) {
		self.themeColor = themeColor
		self.altThemeColor = altThemeColor
	}
	
	public init() {
		self.themeColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1)
		self.altThemeColor = UIColor(red: 0.7, green: 0.94, blue: 1, alpha: 1)
	}
}
