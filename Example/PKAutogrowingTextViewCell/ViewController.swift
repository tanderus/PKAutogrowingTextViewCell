//
//  ViewController.swift
//  PKAutogrowingTextViewCell_Example
//
//  Created by Pavel Krasnobrovkin on 08/11/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit
import PKAutogrowingTextViewCell

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private let labelCellId = LabelCell.id
	private let autoGrowingCellId = String(describing: PKAutogrowingTextViewCell.self)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.keyboardDismissMode = .onDrag
		tableView.register(LabelCell.self, forCellReuseIdentifier: labelCellId)
		tableView.register(PKAutogrowingTextViewCell.self, forCellReuseIdentifier: autoGrowingCellId)
		tableView.delegate = self
		tableView.dataSource = self
		
		NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { [weak self] notification in
			guard
				let self = self,
				let keyboard = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
				return
			}
			
			let height = keyboard.cgRectValue.height
			self.tableView.contentInset.bottom = height - self.view.safeAreaInsets.bottom
		}
		
		NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { [weak self] _ in
			self?.tableView.contentInset = .zero
		}
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: autoGrowingCellId, for: indexPath) as! PKAutogrowingTextViewCell
			cell.delegate = self
			
			var text = (1 ... 10).reduce("") { $0 + String($1) + "\n" }
			text.removeLast()
			cell.textView.text = text
			return cell
		}
		
		return tableView.dequeueReusableCell(withIdentifier: labelCellId, for: indexPath)
	}
}

// MARK: - PKAutogrowingTextViewCellDelegate
extension ViewController: PKAutogrowingTextViewCellDelegate {}
