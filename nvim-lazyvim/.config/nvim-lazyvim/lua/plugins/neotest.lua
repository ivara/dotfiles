return {
  -- { "Issafalcon/neotest-dotnet" },
  {
    "Issafalcon/neotest-dotnet",
    commit = "184f9f5c5e39b87025eebbbeed7736200338377c",
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "Issafalcon/neotest-dotnet" },
    opts = { adapters = { "neotest-dotnet" } },
  },
}
