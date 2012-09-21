#!/usr/bin/ruby

(puts "Usage: #{__FILE__} ~/code/project_directory"; exit) unless ARGV[0]

start_path = ARGV[0]

# Install bundle
Dir.chdir(start_path)
`bundle`

# Find all gem paths
bundle_gems_path = 'vendor/bundle/gems'
Dir.chdir([Dir.pwd,bundle_gems_path].join('/'))
bundle_gem_folders = Dir.glob('*').select { |d| File.directory?(d) }

# Enter each gem path and find license file(s)
bundle_gem_folders.each do |folder|
  
  gem_path = [start_path,bundle_gems_path,folder].join('/')
  
  Dir.chdir(gem_path)
  
  # Find LICENSE file(s)
  licenses = Dir.glob('*').select { |f| f if f.match(/LICENSE|COPYING|License|Licence/) }
  
  if !licenses.empty?
    puts "In #{folder}:"
    
    for license in licenses
      # Should read LICENSE file and check its TYPE
      #TODO: Check license type
      File.open(license).readlines.each { |l| puts l }
      
      puts ('+') * 90
    end
    
    puts ('-') * 120
  else
    # puts "No licenses in #{folder}."
    # Dir.glob('*').each { |f| puts f }
    # puts ('-') * 20
  end
  
end

# Need to separate "commercial" with one-two lines around from other
# grep commerc -A 2 -B 2