defmodule App.Commands do
  use App.Commander
  alias App.Tweets

  # You can create commands in the format `/command` by
  # using the macro `command "command"`.
  command "start" do
    Logger.log :info, "Command /start receieved"
    send_message """
      Welcome to GeeksDontSlack! My available commands are:
      `/qotd` : Returns a random developer quote from http://fortrabbit.github.io/quotes/
      `/qotd_gds` : Returns a random user-submitted quote
      `/qotd_gds_add <author name> the actual quote` : Add your own quote to the list! Only works if you PM the bot. (example: `/qotd_add <Shia Labeouf> Don't let your dreams be dreams`)
    """, parse_mode: "Markdown"
  end

  command "chapter_list" do
    Logger.log :info, "Command /chapter_list receieved"
    send_message """
      List of Chapters within GDS:
      - Agile
      - Quality Engineering
      - User Experience Design (UXD)
      - Dev Hiring
      - Tertiary Relations
      - Telegram Bots
      - Financial Freedom
      - Insanity workout
      - Swimming
      - Gundam/Gunpla
      - Nerf
      - Music
      If you're interested in any of the Chapters, please enquire about them in the GDS telegram group!
    """
  end

  command "qotd" do
    Logger.log :info, "Command /qotd receieved"
  end

  command "qotd_gds" do
    Logger.log :info, "Command /qotd_gds receieved"
  end

  command "qotd_gds_add" do
    Logger.log :info, "Command /qotd_gds_add receieved"
  end

  command "50nerds" do
    Logger.log :info, "Command /50nerds receieved"
    send_message Tweets.get_random
  end

  # Fallbacks

  message do
    # ignore non-slash messages
  end
end