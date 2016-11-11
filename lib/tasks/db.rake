# -*- coding: utf-8 -*-
##
# An idempotent "set up my dev DB" task -- this shouldn't be so hard; if you can see a simpler way, PLEASE implement it!

db_namespace = namespace(:db) {
  task :safe_setup do
    # NOTE(rtlong): this is a naïve implementation and not generally useful:
    def capture_output
      tmperr = StringIO.new
      tmpout = StringIO.new
      original_stderr = $stderr
      original_stdout = $stdout
      $stderr = tmperr
      $stdout = tmpout
      yield
      return tmpout.string + tmperr.string
    ensure
      original_stderr.write tmperr.string
      original_stdout.write tmpout.string
      $stderr = original_stderr
      $stdout = original_stdout
    end

    output = capture_output {
      db_namespace['create'].invoke
    }

    case output
    when /already exists/
      db_namespace['migrate'].invoke
    when /Created/
      db_namespace['schema:load'].invoke
    else
      exit
    end
    db_namespace['seed'].invoke
  end
}
