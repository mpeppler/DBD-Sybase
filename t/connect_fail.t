#!perl

use lib 'blib/lib';
use lib 'blib/arch';

use lib 't';
use _test;

use strict;

use Test::More tests => 4;

use vars qw($Pwd $Uid $Srv $Db);

BEGIN { use_ok('DBI');
        use_ok('DBD::Sybase');}

($Uid, $Pwd, $Srv, $Db) = _test::get_info();

$Srv = "invalid_srv";

#DBI->trace(3);
my $dbh = DBI->connect("dbi:Sybase:$Srv;database=$Db", $Uid, $Pwd, {PrintError => 0, RaiseError => 0});
#DBI->trace(0);

ok(!defined($dbh), "$Srv is not available");

$dbh = DBI->connect("dbi:Sybase:$Srv;database=$Db", $Uid, $Pwd, {PrintError => 0, RaiseError => 0});

ok(!defined($dbh), "$Srv is not available after retry");

exit(0);
