//
//  PKAutogrowingTextViewCellDelegate.swift
//  PKAutogrowingTextViewCell
//
//  Created by Pavel Krasnobrovkin on 08/11/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

public protocol PKAutogrowingTextViewCellDelegate: class {
	
	var tableView: UITableView! { get }
	
	func pkAutogrowingTextViewCellShouldBeginEditing(_ cell: PKAutogrowingTextViewCell) -> Bool
	func pkAutogrowingTextViewCellDidBeginEditing(_ cell: PKAutogrowingTextViewCell)
	func pkAutogrowingTextViewCellDidEndEditing(_ cell: PKAutogrowingTextViewCell)
	
	func pkAutogrowingTextViewCell(_ cell: PKAutogrowingTextViewCell, didChangeText newText: String)
	
	func pkAutogrowingTextViewCellDidRequestToChangeHeight(_ cell: PKAutogrowingTextViewCell)
}

public extension PKAutogrowingTextViewCellDelegate {
	
	func pkAutogrowingTextViewCellShouldBeginEditing(_ cell: PKAutogrowingTextViewCell) -> Bool { true }
	
	func pkAutogrowingTextViewCellDidBeginEditing(_ cell: PKAutogrowingTextViewCell) {}
	func pkAutogrowingTextViewCellDidEndEditing(_ cell: PKAutogrowingTextViewCell) {}
	
	func pkAutogrowingTextViewCell(_ cell: PKAutogrowingTextViewCell, didChangeText newText: String) {}
	
	func pkAutogrowingTextViewCellDidRequestToChangeHeight(_ cell: PKAutogrowingTextViewCell) {
		UIView.setAnimationsEnabled(false)
		tableView.beginUpdates()
		tableView.endUpdates()
		UIView.setAnimationsEnabled(true)
		scrollCellToBottom(cell, animated: false)
	}
	
	private func scrollCellToBottom(_ cell: PKAutogrowingTextViewCell, animated: Bool) {
		guard
			let tableView = tableView,
			let indexPath = tableView.indexPath(for: cell) else {
			return
		}
		
		tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
	}
}
