#!/bin/sh -l

/composer/vendor/bin/phpstan --version

echo "::group::Installed PHPStan extensions"
composer show | grep phpstan
echo "::endgroup::"

IGNORE_PLATFORM_REQS=""
if [ "$CHECK_PLATFORM_REQUIREMENTS" = "false" ]; then
    IGNORE_PLATFORM_REQS="--ignore-platform-reqs"
    composer global require jetbrains/phpstorm-stubs
fi

NO_DEV="--no-dev"
if [ "$REQUIRE_DEV" = "true" ]; then
    NO_DEV=""
fi

COMPOSER_COMMAND="composer install --no-scripts --no-progress $NO_DEV $IGNORE_PLATFORM_REQS"
echo "::group::$COMPOSER_COMMAND"
$COMPOSER_COMMAND
echo "::endgroup::"
/composer/vendor/bin/phpstan $*
