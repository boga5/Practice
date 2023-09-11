- #Error: Cycle: module.rg.random_id.random_id, module.rg.azurerm_resource_group.this_rg
  - Faced this issue as random_id is dependent on resource_group name and RG is dependent on Random ID.

- #No module call named "nic" is declared in module.vm.
  - https://stackoverflow.com/questions/59132282/terraform-reports-no-module-called-name-of-the-module-is-declared-in-root
  - The modules can't be referred while creating resource in respective modules.
