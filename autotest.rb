def find_all_files(dir)
  result = []
  for file in Dir.entries(dir)
    next if file == '.' || file == '..'
    result << dir + "/" + file if File.file?(dir + "/" + file)
    result += find_all_files(dir + "/" + file) if File.directory?(file)
  end
  result
end

def monitor_files(dir, sleep = 1)
  file_time = {}
  for file in find_all_files(dir)
    file_time[file] = File.mtime(file)
  end
  
  yield [], file_time.keys, []
  
  while true
    new_files = []
    deleted_files = file_time.keys
    modified_files = []
    for file in find_all_files(dir)
      if file_time[file]
        deleted_files.delete(file)
        if file_time[file] != File.mtime(file)
          file_time[file] = File.mtime(file)
          modified_files << file
        end
      else
        new_files << file
        file_time[file] = File.mtime(file)
      end
    end
    for deleted_file in deleted_files
      file_time.delete(deleted_file)
    end
  
    yield modified_files, new_files, deleted_files
    Kernel.sleep sleep
  end
end

DEBUG = false

monitor_files(".") do
  |modified_files, new_files, deleted_files|
  puts "modified: #{modified_files.join(', ')}, new: #{new_files.join(', ')}, deleted: #{deleted_files.join(', ')}" if DEBUG
  if !modified_files.empty? || !new_files.empty? || !deleted_files.empty?
    begin  
      load "autotest-actions.rb"
      process_files(modified_files, new_files, deleted_files) 
    rescue Exception => e  
      puts "autotest failed"
      puts e.message  
      puts e.backtrace.inspect  
    end
  end
end
