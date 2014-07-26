class CreateFile < Command
  def initialize(path, contents)
    super "Create file: #{path}"
    @path = path
    @contents = contents
  end
  
  def execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end
  
  def unexecute
    File.delete(@path)
  end 
end

class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end
  
  def execute
    @contents = File.read(@target) if File.exist?(@target)
    FileUtils.copy(@source, @target)
  end 

  def unexecute
    if @contents
      File.open(@target, 'w') do |f|
        f.write @contents
      end
    end
  end
end

class DeleteFile < Command
  def initialize(path)
    super "Delete file: #{path}"
    @path = path
  end

  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
    end
    f = File.delete(@path)
  end
  
  def unexecute
    if @contents
      f = File.open(@path,"w")
      f.write(@contents)
      f.close
    end 
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end
  
  def add_command(cmd)
    @commands << cmd
  end
  
  def execute
    @commands.each {|cmd| cmd.execute}
  end

  def unexecute
    @commands.reverse.each {|cmd| cmd.unexecute}
  end
  
  def description
    description = ''
    @commands.each {|cmd| description += cmd.description + "\n"}
    description
  end 
end

cmds = CompositeCommand.new
cmds.add_command(CreateFile.new('file1.txt', "hello world\n"))
cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add_command(DeleteFile.new('file1.txt'))

cmds.execute
cmds.unexecute
