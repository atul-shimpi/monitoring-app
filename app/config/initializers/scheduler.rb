require 'rake'

scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

unless scheduler.down?
  scheduler.every("10m") do
    system 'rake agents:collect_matrices'
  end
end
