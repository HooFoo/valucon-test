namespace :fake do

  desc "switch logger to stdout"
  task :to_stdout => [:environment] do
    Rails.logger = Logger.new(STDOUT)
  end

  desc "Add some users"
  task :users, [:count] => [:environment,:to_stdout] do |t, args|
    users = args[:count].to_i || 5
    users.times do |i|
      pwd = Faker::Internet.password 6,8
      user = User.create! email: Faker::Internet.email,
                   password: pwd,
                   password_confirmation: pwd,
                   role: User::ROLES.sample
      Rails.logger.info "\n\nCreated fake user: #{user.email}/#{pwd} .\n\n"
    end
  end

  desc "Add some tasks"
  task :tasks,  [:users,:tasks] => [:environment,:to_stdout] do |t, args|
    users = args[:users].to_i || 5
    tasks = args[:tasks].to_i || 2
    if User.count < users
      abort "You need at least #{users} users.\nRun 'rake fake:users[#{users}]' first"
    end
    users.times do |i|
      user = User.all.sample
      tasks.times do
      task = Task.create! name: Faker::Beer.name,
                            file: Faker::Placeholdit.image('150x150'),
                            description: Faker::Hipster.paragraph(Random.rand 15),
                            user: user,
                            state: Task.state_machine.states.to_a.sample.to_s
      Rails.logger.debug "Task '#{task.name}' created for user '#{user.name}'"
      end
    end
  end

end
