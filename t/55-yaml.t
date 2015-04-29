use strict;
use warnings;
no warnings 'once';

use Test::More;
use Config::Any;
use Config::Any::YAML;

if ( !Config::Any::YAML->is_supported ) {
    plan skip_all => 'YAML format not supported';
}
else {
    plan tests => 6;
}

{
    my $config = Config::Any::YAML->load( 't/conf/conf.yml' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid config
{
    my $file = 't/invalid/conf.yml';
    my $config = eval { Config::Any::YAML->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}

# parse error generated on invalid config
{
    my $file = 't/invalid/conf.yml';
    my $config = eval { Config::Any->load_files( { files => [$file], use_ext => 1} ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
