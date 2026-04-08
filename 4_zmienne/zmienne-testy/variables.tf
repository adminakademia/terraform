variable "typ_instancji_serwera" {
 default = "t3.micro"
}

variable "db_password" {
  type        = string
  description = "Hasło do bazy danych"
  sensitive   = true # Zapobiega wyciekowi hasła do konsoli
}

variable "env_name" {
  type        = string
  description = "Nazwa środowiska (tylko dev lub prod)"

  validation {
    condition     = contains(["dev", "prod"], var.env_name)
    error_message = "Błąd: Środowisko musi być ustawione na 'dev' lub 'prod'!"
  }
}


variable "app_regions" {
  type    = list(string)
  default = ["us-east-1", "eu-central-1"]
  description = "Lista stref dostępności."
}

variable "server_labels" {
  type = map(string)
  default = {
    team = "devops"
    tier = "frontend"
  }
}	


variable "vm_spec" {
  type = object({
    name    = string
    cpus    = number
    managed = bool
  })
  
  default = {
    name    = "web-srv-01"
    cpus    = 2
    managed = true
  }
}


variable "project_ids" {
  type        = set(number)
  default     = [101, 102, 103, 101] # 101 powtarza się celowo
  description = "Unikalne ID projektów."
}

variable "endpoint_config" {
  type        = tuple([string, number, bool])
  default     = ["api.example.com", 443, true]
  description = "Konfiguracja endpointu: [Host, Port, SSL_Enabled]"
}	

variable "user_accounts" {
  type = map(object({
    role          = string
    is_admin      = bool
    department_id = number
  }))
  
  default = {
    "jan.kowalski" = {
      role          = "developer"
      is_admin      = false
      department_id = 10
    }
    "admin.system" = {
      role          = "architect"
      is_admin      = true
      department_id = 1
    }
  }
}


variable "instances" {
  type = map(object({
    instance_type = optional(string, "t2.micro")
    ami_id        = optional(string, "ami-123456")
    tags          = optional(map(string), {})
  }))
}



