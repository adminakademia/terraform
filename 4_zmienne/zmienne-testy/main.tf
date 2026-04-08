resource "local_file" "db_config" {
  filename = "config_${var.env_name}.txt"
  content  = "Environment: ${var.env_name}\nPassword: ${var.db_password}"
}	

resource "local_file" "infra_labels" {
  filename = "labels.txt"
  content  = "Region główny: ${var.app_regions[0]}\nTeam: ${var.server_labels["team"]}"
}

resource "local_file" "collections_test" {
  filename = "collections.txt"
  content  = <<-EOT
    Pierwszy element krotki (Host): ${var.endpoint_config[0]}
    Czy SSL włączony: ${var.endpoint_config[2]}
    
    Liczba unikalnych projektów: ${length(var.project_ids)}
    ID projektów: ${join(", ", [for id in var.project_ids : tostring(id)])}
  EOT
}


resource "local_file" "users_report" {
  filename = "users_report.txt"
  content  = <<-EOT
    Lista użytkowników w systemie:
    %{ for name, data in var.user_accounts ~}
    Użytkownik: ${name}
    - Rola: ${data.role}
    - Uprawnienia Admina: ${data.is_admin}
    ---
    %{ endfor ~}
  EOT
}


