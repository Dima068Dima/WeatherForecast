#!/usr/bin/env ruby
file_path = 'WeatherForecast.xcodeproj/project.pbxproj'
content = File.read(file_path)

# Список ключевых слов для удаления
patterns = [
  /\/\* Begin XCRemoteSwiftPackageReference section \*\/.*?\/\* End XCRemoteSwiftPackageReference section \*\//m,
  /\/\* Begin XCSwiftPackageProductDependency section \*\/.*?\/\* End XCSwiftPackageProductDependency section \*\//m,
  /^.*Alamofire.*$\n?/,
  /^.*SnapKit.*$\n?/,
  /^.*XCRemoteSwiftPackageReference.*$\n?/,
  /^.*XCSwiftPackageProductDependency.*$\n?/
]

patterns.each do |pattern|
  content = content.gsub(pattern, '')
end

# Удаляем пустые строки
content = content.gsub(/\n{3,}/, "\n\n")

File.write(file_path, content)
puts "✅ Все зависимости удалены"
