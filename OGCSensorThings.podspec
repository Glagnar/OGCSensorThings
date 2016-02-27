Pod::Spec.new do |s|

  s.name         = "OGCSensorThings"
  s.version      = "0.0.4"
  s.summary      = "Easily consume OGCSensortings services."

  s.description  = <<-DESC
A POD that allows SWIFT development of applications that consume OGCSensorthings services.
                   DESC

  s.homepage     = "http://www.almanac-project.eu"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Thomas Gilbert" => "thomas.gilbert@alexandra.dk" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/Glagnar/OGCSensorThings.git", :tag => s.version.to_s}

  s.source_files = 'Pod/Classes/**/*.swift'
  s.dependency "Alamofire"

end
