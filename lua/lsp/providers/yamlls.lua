local opts = {
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = {
            "daemon.yaml",
            "manager.yaml",
            "restapi.yaml",
            "role.yaml",
            "role_binding.yaml",
            "*onfigma*.yml",
            "*ngres*.yml",
            "*ecre*.yml",
            "*eployment*.yml",
            "*ervic*.yml",
            "*onfigma*.yaml",
            "*ngres*.yaml",
            "*ecre*.yaml",
            "*eployment*.yaml",
            "*ervic*.yaml",
            "kubectl-edit*.yaml",
          },
          ["https://json.schemastore.org/ansible-role-2.9.json"] = {
            "tasks/*.yml",
            "tasks/*.yaml",
          },
          ["https://json.schemastore.org/ansible-inventory.json"] = {
            "inventories/*.yml",
            "*nventori*/*.yml",
            "staging.yml",
            "production.yml",
          },
          ["https://json.schemastore.org/ansible-playbook.json"] = {
            "playbook.yml",
            "playbook.yaml",
            "main.yml",
          },
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
          ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/helmfile"] = "helmfile.{yml,yaml}",
          ["http://json.schemastore.org/gitlab-ci"] = "/*lab-ci.{yml,yaml}",
        },
      },
    },
}

return opts
