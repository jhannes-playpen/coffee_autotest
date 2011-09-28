def compile_coffee(file)
  puts "compiling #{file}"
  puts `node l.js #{file} p > #{file}.js`
end

def run_tests
  puts "Run tests"
end

def process_files(modified_files, new_files, deleted_files)
  for file in deleted_files
    if file =~ /.coffee$/
      File.delete "#{file}.js" if File.exist? "#{file}.js"
    end
  end
  
  interesting_files = modified_files + new_files
  for file in interesting_files
    compile_coffee(file) if file =~ /.coffee$/
  end
  return    if interesting_files.count { |file| file =~ /.coffee$/ } > 0
  run_tests  if interesting_files.count { |file| file =~ /.js$/ } > 0
end
