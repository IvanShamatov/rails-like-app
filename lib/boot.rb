# Создаем коннект к базе
db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'database.yml')
if File.exist?(db_config_file)
  config  = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

# Подключаем все классы нашего фреймоворка
Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each {|file| require file }

# Подключаем все файлы нашего приложения
Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].each {|file| require file }

# Если есть коннект к базе данных, то прогоняем миграции
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations'))
end

# Читаем роутинги
ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))

