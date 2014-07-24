class Report
  def initialize
    @title = 'Monthly Report'
    @text =  ['Things are going', 'really, really well.']
  end

  # outline the template in base class
  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end
  
  # supply a sensible default implementation of these methods for the convenience of its subclasses
  def output_start
  end
    
  def output_body_start
  end

  def output_body
    @text.each do |line|
      output_line line
    end
  end
  
  def output_body_end
  end

  def output_end
  end

  def output_head
    output_line(@title)
  end

  # raise error in abstract methods, so subclasses MUST implement them
  # It's better raise NotImplementedError than RuntimeError
  def output_line(line)
    raise NotImplementedError, 'Called abstract method: output_line'
  end
end

class PlainTextReport < Report
  def output_head
    puts("**** #{@title} ****")
    puts
  end

  def output_line(line)
    puts(line)
  end
end

class HTMLReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts('<head>')
    puts("<title>#{@title}</title>")
    puts('</head>')
  end

  def output_body_start
    puts('<body>')
  end

  def output_line(line)
    puts("<p>#{line}</p>")
  end

  def output_body_end
    puts('</body>')
  end

  def output_end
    puts('</html>')
  end
end
