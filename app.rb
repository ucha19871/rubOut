require 'cli-console'
require 'mysql'  
  
#my = Mysql.new(hostname, username, password, databasename)  
con = Mysql.new('localhost', 'admin', 'pl,okm', 'ruby')  
rs = con.query('select * from users')  
rs.each_hash { |h| puts h['password']}
con.close

=begin
class ShellUI
    private
    extend CLI::Task

    public

    usage 'Usage: ls'
    desc 'List file information about current directory'
    def ls(params)
        Dir.foreach(Dir.pwd) do |file|
            puts file
        end
    end

    usage 'Usage: pwd'
    desc 'Display current directory'

    def pwd(params)
        puts "Current directory: #{Dir.pwd}"
    end

    usage 'Usage: cd <Directory>'
    desc 'Change current directory'

    def cd(params)
        Dir.chdir(params[0]) unless params.empty?
    end
end

io = HighLine.new
shell = ShellUI.new
console = CLI::Console.new(io)

console.addCommand('ls', shell.method(:ls), 'List files')
console.addCommand('pwd', shell.method(:pwd), 'Current directory')
console.addCommand('cd', shell.method(:cd), 'Change directory')
console.addHelpCommand('help', 'Help')
console.addExitCommand('exit', 'Exit from program')
console.addAlias('quit', 'exit')

console.start("%s> ",[Dir.method(:pwd)])=end
=end
