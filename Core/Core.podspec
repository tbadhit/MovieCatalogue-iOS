Pod::Spec.new do |s|
 
  s.platform = :ios
  s.ios.deployment_target = '16.0'
  s.name = "Core"
  s.summary = "Core module for dicoding submission"
  s.requires_arc = true
 
  s.version = "1.0.0"
 
  s.license = { :type => "MIT", :file => "LICENSE" }
 
  s.author = { "Tubagus Adhitya Permana" => "aditt7116@gmail.com" }
 
  s.homepage = "https://github.com/tbadhit/Modularization-Core-Module"
 
  s.source = { 
    :git => "https://github.com/tbadhit/Modularization-Core-Module.git", 
    :tag => "#{s.version}" 
  }
 
  s.framework = "SwiftUI"
 
  s.source_files = "Core/**/*.{swift}"
 
  #s.resources = "Core/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.dependency 'RealmSwift', '~>10'
 
  s.swift_version = "5.5"
 
end