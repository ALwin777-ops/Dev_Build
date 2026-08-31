# 1. Private Docker Network for internal routing
resource "docker_network" "app_network" {
  name = "app_network"
}

# 2. Download NGINX Image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# 3. Matrix Container (Internal Only)
resource "docker_container" "matrix_dashboard" {
  name    = "matrix-dashboard"
  image   = docker_image.nginx.image_id
  restart = "always"

  memory = 256 # Limits RAM usage to 256MB

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost/"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

# 4. Dev Server Container (Internal Only)
resource "docker_container" "instant_dev_server" {
  name    = "instant-dev-server"
  image   = docker_image.nginx.image_id
  restart = "always"

  memory = 256 # Limits RAM usage to 256MB

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost/"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    host_path      = "${path.cwd}/src"
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }
}

# 5. Reverse Proxy Container (Public Entry Point)
resource "docker_container" "proxy" {
  name    = "reverse-proxy"
  image   = docker_image.nginx.image_id
  restart = "always"

  memory = 512 # Limits RAM usage to 512MB

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost/"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  # Mount local nginx.conf into the container
  volumes {
    host_path      = "${path.cwd}/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
    read_only      = true
  }

  # Expose Port 80 publicly
  ports {
    internal = 80
    external = 80
  }
}