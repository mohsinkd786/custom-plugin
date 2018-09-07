package = "custom-plugin"
version = "0.0.1-0"
supported_platforms = {"linux"}
source = {
  url = "git://github.com/mohsinkd786/custom-plugin"
}
description = {
  summary = "Custom Plugin ",
  homepage = "http://getkong.org",
  license = "MIT"
}
dependencies = {
  
}
build = {
  type = "builtin",
  modules = {
   
    ["kong.plugins.sample-plugin.migrations.cassandra"] = "kong/plugins/sample/migrations/cassandra.lua",
    ["kong.plugins.sample-plugin.handler"] = "kong/plugins/sample-plugin/handler.lua",
    ["kong.plugins.sample-plugin.access"] = "kong/plugins/sample-plugin/access.lua",
    ["kong.plugins.sample-plugin.schema"] = "kong/plugins/sample-plugin/schema.lua",
    ["kong.plugins.sample-plugin.daos"] = "kong/plugins/sample-plugin/daos.lua",

   
  }
}
