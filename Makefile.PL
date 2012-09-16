use strict;
use warnings;
BEGIN {
    unshift @INC, 'inc';

    # author requires, or bundled modules
    my @devmods = qw(
inc::Module::Install 1.00
Module::Install::AuthorTests 0.002
Test::Requires 0.06
);
    my @not_available;
    while(my($mod, $ver) = splice @devmods, 0, 2) {
        eval qq{use $mod $ver (); 1} or push @not_available, $mod;
    }
    if(@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `perl $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        exit 1;
     }
}
use inc::Module::Install;
name 'OreOre-Readtwit';
all_from 'lib/OreOre/Readtwit.pm';

requires 'Any::Moose';
requires 'AnyEvent::Twitter::Stream';
requires 'Config::Pit';
requires 'File::Spec';
requires 'File::Temp';
requires 'FindBin::libs';
requires 'FindBin';
requires 'Furl';
requires 'Regexp::Assemble';
requires 'Regexp::Common';
requires 'Time::Piece';
requires 'URI';
requires 'XML::FeedPP';
requires 'YAML';
requires 'namespace::autoclean';

test_requires 'Test::More' => '0.88';
test_requires 'Test::Requires' => '0.06';
test_requires 'Plack' => '0.99';
test_requires 'Hook::LexWrap';
test_requires 'Test::TCP';
test_requires 'Plack::Handler::Twiggy';
test_requires 'File::Temp';
test_requires 'JSON';


auto_set_repository;

tests 't/*.t';
#author_tests 'xt';
auto_include;
auto_install;

install_script('readtwit');
WriteAll;
