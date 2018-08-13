namespace :app do
  desc "Remove all users"
  task remove_all_users: :environment do
    puts "Running rake task to remove selected users..."
    @users = User.all 

    if @users.blank?
      puts "No user in database"
    else
      @users.each do |user|
        puts "Checking a user..."
        if user.username[0] == "u"
          puts "Removing #{user.username} since username starts with 'u'"
          user.destroy
        else
          puts "Skipping #{user.username} as username does not start with 'u'"
        end
      end
    end
  end
  
  desc "Migrate users data from another database"
  task migrate_users_data_from_another_database: :environment do
    puts "Preparing to copy user data from guests..."

    Guest.establish_connection(
      adapter: "postgresql",
      host: ENV["POSTGRES_BACKUP_HOST"],
      username: ENV["POSTGRES_USER"],
      database: ENV["POSTGRES_BACKUP_DB"]
    )

    @all_usernames = User.all.pluck(:username).flatten

    Guest.find_each do |guest|
      puts "Checking #{guest.username}"
      unless user_exists?(guest, @all_usernames)
        puts "Creating new user"
        save_user(guest)
      end
    end

    Guest.connection.close
  end

  def save_user(guest)
    User.create(
      username: guest.username,
      email: "#{guest.username}@example.com",
      password: "mypassword"
    )
  end

  def user_exists?(user, all_usernames)
    all_usernames.include?(user.username) ? true : false
  end
end
