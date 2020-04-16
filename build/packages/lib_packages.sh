#######################################
# Install common packages.
#######################################
install_packages() {
  apt install -y wget
  return $?
}