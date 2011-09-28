def compile_coffee(file)
  puts "compiling #{file}"
  puts `node coffee-compile.js #{file} > #{file.gsub(/.coffee$/, ".js")}`.chomp
end

def run_expresso(files)
  puts "Run expresso"
  files = files.delete_if { |file| file !~ /.js$/ }
  if files.find { |file| file !~ /\^.\/test/ }
    files = Dir.entries("./test/").select { |f| f =~ /.js$/ }.collect { |f| "./test/#{f}" }
  end
  puts "node vendor/expresso.js --boring #{files.join(" ")}"
  puts `node vendor/expresso.js --boring #{files.join(" ")}`.gsub(/\n\r/, "\n")
end

def run_jasmine(files)
  puts "Run jasmin"
  files = files.delete_if { |file| file !~ /.js$/ }
  if files.find { |file| file !~ /\^.\/spec/ }
    files = Dir.entries("./spec/").select { |f| f =~ /.js$/ }.collect { |f| "./spec/#{f}" }
  end
  puts "node vendor\\jasmine-node\\cli.js --noColor #{files.join(" ")}"
  puts `node vendor\\jasmine-node\\cli.js --noColor #{files.join(" ")}`.gsub(/\n\r/, "\n")
end


def run_tests(files)
  run_expresso(files)
  run_jasmine(files)
end


def process_files(modified_files, new_files, deleted_files)
  for file in deleted_files
    if file =~ /.coffee$/
      File.delete "#{file.gsub(/.coffee$/, ".js")}" if File.exist? "#{file.gsub(/.coffee$/, ".js")}"
    end
  end
  
  interesting_files = modified_files + new_files
  for file in interesting_files
    compile_coffee(file) if file =~ /.coffee$/
  end
  
  return    if (interesting_files.find { |file| file =~ /.coffee$/ })
  run_tests(interesting_files)  if (interesting_files.find { |file| file =~ /.js$/ })
end
