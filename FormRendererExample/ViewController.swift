//
//  ViewController.swift
//  FormRendererExample
//
//  Created by KnilaDev on 24/11/20.
//

import UIKit
import FormRenderer

class ViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	
	private var renderer: FormRenderer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let cellData: [FormCellType] = [
			FormCellType.textEdit(TextEditModel(key: "Some", contextText: "Hey Yo"))
		]
		
		renderer = FormRenderer(cellData, tableView: tableView, controller: self, config: nil)
	}


}

