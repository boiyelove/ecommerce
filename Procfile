web: bundle exec puma -C config/puma.rb
release: rake db:schema:load DISABLE_DATABASE_ENVIRONMENT_CHECK=1
release: rake db:seed