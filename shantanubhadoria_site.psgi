use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use ShantanuBhadoria::Site;

my $app = ShantanuBhadoria::Site->apply_default_middlewares(ShantanuBhadoria::Site->psgi_app);
$app;

