return {
  name = 'jsonls',
  config = {
    capabilities = nil,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
}
