locals {
  # W workspace "default" przedrostek zostaje bez zmian - oryginal nie zauwazy tej zmiany.
  # W kazdej kopii przedrostek dostaje nazwe workspace'u (mechanizm z lekcji 11).
  name_prefix = terraform.workspace == "default" ? "lab20" : "lab20-${terraform.workspace}"
}