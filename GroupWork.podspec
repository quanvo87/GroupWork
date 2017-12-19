Pod::Spec.new do |s|
  s.name         = "GroupWork"
  s.version      = "0.0.1"
  s.summary      = "Swift module that helps with running multiple, simultaneous, asynchronous tasks in a clean way."
  s.description  = "Swift module that helps with running multiple, simultaneous, asynchronous tasks in a clean way. Better description inc."
  s.homepage     = "https://github.com/quanvo87/GroupWork"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Quan Vo" => "qvo1987@gmail.com",
                     "Wilson Ding" => "hello@wilsonding.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/quanvo87/GroupWork.git", :tag => "0.0.1" }
  s.source_files  = "GroupWork", "GroupWork/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
end
