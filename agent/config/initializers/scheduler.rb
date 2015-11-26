require 'rake'

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

unless scheduler.down?
  scheduler.every("1m") do
    system 'rake agent:save_matrices'
  end
end

