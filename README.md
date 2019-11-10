# PKAutogrowingTextViewCell
A Dynamic-height UITableViewCell with UITextView

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
