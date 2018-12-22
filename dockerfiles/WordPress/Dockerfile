FROM wordpress:latest

# Install requirements for wp-cli support
## Removing this part, as the latest official images now include WP CLI
RUN apt-get update \
  && apt-get install -y sudo less mysql-client subversion \
  && apt-get install -y zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-install zip


# Add WP-CLI
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
# Optional: add your custom config
#COPY wp-cli.yml /var/www/html/wp-cli.yml
RUN chmod +x /bin/wp-cli.phar
RUN chown -R www-data:www-data /var/www/html

## Add PHPCS
WORKDIR /tmp
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
  cp /tmp/phpcs.phar /usr/local/bin/phpcs && \
  chmod +x /usr/local/bin/phpcs
# Set some useful defaults to phpcs
# show_progress - I like to see a progress while phpcs does its magic
# colors - Enable colors; My terminal supports more than black and white
# report_width - I am using a large display so I can afford a larger width
# encoding - Unicode all the way
RUN /usr/local/bin/phpcs --config-set show_progress 1 && \
  /usr/local/bin/phpcs --config-set colors 1 && \
  /usr/local/bin/phpcs --config-set report_width 140 && \
  /usr/local/bin/phpcs --config-set encoding utf-8
ENTRYPOINT ["/usr/local/bin/phpcs"]

## Add PHPcbf
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
RUN cp /tmp/phpcbf.phar /usr/local/bin/phpcbf
RUN chmod +x /usr/local/bin/phpcbf


## Add PHPUnit 6.5
RUN curl -OL https://phar.phpunit.de/phpunit-6.5.phar
RUN chmod +x /tmp/phpunit-6.5.phar
RUN mv /tmp/phpunit-6.5.phar /usr/local/bin/phpunit

WORKDIR /var/www/html
