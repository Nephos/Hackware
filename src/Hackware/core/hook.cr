class Hook
  YAML.mapping(
    before_install: String,
    install: String,
    after_install: String,
    before_start: String,
    start: String,
    after_start: String,
  )
end
