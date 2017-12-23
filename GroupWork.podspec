Pod::Spec.new do |s|
  s.name         = "GroupWork"
  s.version      = "0.0.6"
  s.summary      = "Easy concurrent, asynchronous tasks in Swift."
  s.description  = "GroupWork is an easy to use Swift framework that helps you orchestrate your concurrent, asynchronous functions in a clean and organized way. This helps make large functions with multiple asynchronous tasks more clear and easy to follow."
  s.homepage     = "https://github.com/quanvo87/GroupWork"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Quan Vo" => "qvo1987@gmail.com",
                     "Wilson Ding" => "hello@wilsonding.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/quanvo87/GroupWork.git", :tag => s.version }
  s.source_files  = "Sources/GroupWork/*.{h,m,swift}"
end
