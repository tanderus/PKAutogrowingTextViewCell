
Pod::Spec.new do |s|
  s.name             = 'PKAutogrowingTextViewCell'
  s.version          = '1.0.0'
  s.summary          = 'Dynamic-height UITableViewCell with a UITextView.'

  s.description      = "Dynamic-height UITableViewCell with a UITextView"

  s.homepage         = 'https://github.com/tanderus/PKAutogrowingTextViewCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tanderus' => '6lackk@gmail.com' }
  s.source           = { :git => 'https://github.com/tanderus/PKAutogrowingTextViewCell.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'PKAutogrowingTextViewCell/Classes/**/*'
end
