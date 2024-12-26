return {
  { "Issafalcon/neotest-dotnet" },
  {
    "nvim-neotest/neotest",
    dependencies = { "Issafalcon/neotest-dotnet" },
    opts = { adapters = { "neotest-dotnet" } },
  },
}
