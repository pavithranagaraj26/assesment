resource "google_sql_database_instance" "sql_db" {
  depends_on = [
    google_compute_network.vpc
  ]
  name = "sqldb38"
  database_version = "MYSQL_5_7"
  region       = "us-central1"
  settings {
    tier = "db-f1-micro"

     ip_configuration {
                ipv4_enabled = true
                require_ssl  = false
                
                authorized_networks {
                    name  = "wpSQLconnect"
                    // value = var.static_ip_wp
                    value = "0.0.0.0/0"
         }
      }
   }
}

resource "google_sql_database" "database" {
  name      = "wpdb"
  instance  = google_sql_database_instance.sql_db.name
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.sql_db.name
  password = "nopassword"
}
