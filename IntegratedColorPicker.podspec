Pod::Spec.new do |s|
  s.name             = 'IntegratedColorPicker'
  s.version          = '1.0.0'
  s.summary          = 'A color picker that shows example content above'


  s.description      = <<-DESC
  'A color picker that shows example content above'
                       DESC

  s.homepage         = 'https://github.com/badalnoky/IntegratedColorPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'badalnoky' => 'dalnoky.bertalan.andras@gmail.com' }
  s.source           = { :git => 'https://github.com/badalnoky/IntegratedColorPicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '17.0'

  s.source_files = 'IntegratedColorPicker/Classes/**/*'
  s.swift_version = '5.0'
  s.platforms = {
    "ios": "17.0"
  }
end
