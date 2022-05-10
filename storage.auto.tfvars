storage_accounts = {
  sa1 = {
    location  = "westeurope"
    tier      = "Standard"
    repl_type = "GRS"
    kind      = "StorageV2"
    containers = {
      sc1 = {name = "mystore250",access_type = "private"}
    }
  }

  sa2 = {
    location  = "eastus2"
    tier      = "Standard"
    repl_type = "GRS"
    kind      = "StorageV2"
    shares = {
      fs1 = {name = "smbfileshare2",quota = 50}
    }
  }

  sa3 = {
    location  = "southeastasia"
    tier      = "Standard"
    repl_type = "GRS"
    kind      = "StorageV2"
    queues = {
      q1 = {name = "queue1"}
      q2 = {name = "queue2"}
    }
  }

  sa4 = {
    location  = "eastus"
    tier      = "Standard"
    repl_type = "GRS"
    kind      = "StorageV2"
    tables = {
      t1 = {name = "table1"}
      t2 = {name = "table2"}
    }
  }
}