Pod::Spec.new do |spec|

  spec.name         = "Aquino"
  spec.version      = "1.0.7"
  spec.summary      = "Aquino Networking."
  spec.description  = "Aquino is a network framework for tests."
  spec.homepage     = "https://github.com/issuran/Aquino"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Tiago Oliveira" => "tiago_fernandes89@hotmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/issuran/Aquino.git", :tag => "1.0.7" }
  spec.source_files = "Aquino/**/*"
  
  spec.exclude_files = "Aquino/**/*.plist"
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  spec.swift_versions = '5.0'

end
