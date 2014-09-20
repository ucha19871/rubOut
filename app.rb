require 'rubygems'
require 'highline/import'
require 'cli-console'
require 'mysql'
require 'digest/md5'





class ShellUI

    private
    extend CLI::Task

    usage 'Usage: register'
    desc 'Register a new user into Database'
    def rg(params)
        con = Mysql.new("localhost", "admin", "pl,okm", "ruby")
        reg = con.query("INSERT INTO `ruby`.`users` (`id`, `username`, `password`) VALUES (NULL, '"+params[0]+"', '"+Digest::MD5.hexdigest(params[1])+"')")
        puts "User Registered"
    end


    usage 'Usage: login'
    desc 'Loggin with user creadentials'

    def login(params)

    	def get_username(prompt="Enter Username")
			ask(prompt) {|q| q.echo = true}
		end

    	def get_password(prompt="Enter Password")
			ask(prompt) {|q| q.echo = "*"}
		end

		theUserName = get_username()
		thePassword = Digest::MD5.hexdigest(get_password())

		con = Mysql.new("localhost", "admin", "pl,okm", "ruby")
		reg = con.query("SELECT * FROM `users` as u WHERE u.username = '"+theUserName+"' AND u.password = '"+thePassword+"' ")
		
		
		
		if(reg.num_rows > 0 )
			puts "You are now loged in!"
		else
			puts "Username or Uassword is incorrect!"
		end
    end



    usage 'Usage: show'
    desc 'This functions Shows user by name'

    def show(params)
		con = Mysql.new("localhost", "admin", "pl,okm", "ruby")
        reg = con.query("SELECT * FROM `users` as u WHERE  u.username = '"+params[0]+"'")
        if(reg.num_rows > 0 )
			reg.each do |row|
				puts row
			end

		else
			puts "There is not username like: " + params[0]
		end
        
    end
end

io = HighLine.new
shell = ShellUI.new
console = CLI::Console.new(io)

console.addCommand('rg', shell.method(:rg), 'Register a New User')
console.addCommand('login', shell.method(:login), 'Loggin User') { |q| q.echo = false }
console.addCommand('show', shell.method(:show), 'Show User By username')

console.addHelpCommand('help', 'Help')
console.addExitCommand('exit', 'Exit from program')
console.addAlias('quit', 'exit')
console.start("%s> ",[Dir.method(:pwd)])


