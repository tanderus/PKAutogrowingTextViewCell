# PKAutogrowingTextViewCell
A Dynamic-height UITableViewCell with UITextView

<img src="Demo.gif" alt="Demo" width="207" height="448">

## Features

1. The cell auto-grows till the  `maximumLinesAllowed` reached
2. After that the `textView.isScrollEnabled` gets `true`
3. Automatic cell's height recalculation after on-fly changing
..1. Cell's properties: `maximumLinesAllowed` and `textViewMargins`
..2. TextView's properties:  `text`,  `attributedText`,  `font`,  `textContainerInset`
4. Easily to subclass, if you want to customize the behavior

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'PKAutogrowingTextViewCell', :git => "https://github.com/tanderus/PKAutogrowingTextViewCell.git"
```

### Manually

Just copy-paste the "PKAutogrowingTextViewCell.swift" and "PKAutogrowingTextViewCellDelegate.swift" files


## Usage

Register the PKAutogrowingTextViewCell class on your tableView (or it's subclass):

```swift
tableView.register(PKAutogrowingTextViewCell.self, forCellReuseIdentifier: autoGrowingCellId)
```

At some point like 
`func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell` 
setup the cell's delegate:

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: autoGrowingCellId, for: indexPath) as! PKAutogrowingTextViewCell
cell.delegate = self
return cell
```
