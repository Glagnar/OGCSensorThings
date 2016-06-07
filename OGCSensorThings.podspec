Pod::Spec.new do |s|

  s.name         = "OGCSensorThings"
  s.version      = "2.1.1"
  s.summary      = "Easily consume OGCSensorThings services."

  s.description  = <<-DESC
A POD that allows Swift development of applications that consume OGCSensorthings services.
This POD is made possible through the efforts of Dario Bonino, and funded by the EU FP7 Framework.
                   DESC

  s.homepage     = "http://www.almanac-project.eu"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Thomas Gilbert" => "thomas.gilbert@alexandra.dk" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Glagnar/OGCSensorThings.git", :tag => s.version.to_s}

  s.source_files = 'Pod/Classes/**/*.swift'
  s.dependency "Alamofire"

end
