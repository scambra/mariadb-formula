# mariadb-formula

This formula will install MariaDB from the official repo.

## Compatibility

This formula currently only works on Debian-based systems (Debian, Ubuntu etc).

## Contributing

Pull requests for other OSes and bug fixes are more than welcome.

## Usage

Include "mariadb" in your project.
Via pillar you can configure certain aspects such as the my.cnf configuration.

You can also install just the server by including "mariadb.server".
Same for the client: "mariadb.client". Including "mariadb" installs both.

See the pillar.example for configuration options. All are optional.

Please note:
The salt service id used is "mysql-client" and "mysql-server" for compatibility with
other (non-Enrise) formulas.

## Todo
