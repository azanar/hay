$:.push("lib", "config")

require 'coinstar/hay/integration'

require 'pocketchange/processors/extract'
require 'hay/task'
require 'hay/task/context'
require 'hay/batch/task/context'

require 'coinstar/tasks/dump'
require 'coinstar/task/context'

e = Coinstar::Task::Extract.new("payload" => {"model" => "Event", "opts" => {"backfill_all" => true}})
p = e.to_hay

dump = Coinstar::Task::Dump.new("payload" => {"file" => "/tmp/coinstar_dump_file"})
du = dump.to_hay

p.flow.between.push(du)
p.flow.after.push(du)

e = p.dehydrate

puts "E #{e}"

t = Hay::Task.new(e)

puts t.inspect

ac = Hay::Batch::Task::Context.new(t)

t.process(ac)
exit

r = c.runner
r.push(p)
r.run


