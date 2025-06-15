output "instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.postgres.name
}

output "instance_connection_name" {
  description = "The connection name of the database instance"
  value       = google_sql_database_instance.postgres.connection_name
}

output "database_name" {
  description = "The name of the database"
  value       = google_sql_database.database.name
}

output "user_name" {
  description = "The name of the database user"
  value       = google_sql_user.user.name
}

output "secret_id" {
  description = "The ID of the secret containing the database password"
  value       = google_secret_manager_secret.db_password.id
}