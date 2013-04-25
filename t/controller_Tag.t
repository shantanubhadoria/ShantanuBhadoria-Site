use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShantanuBhadoria::Site';
use ShantanuBhadoria::Site::Controller::Tag;

ok( request('/tag')->is_success, 'Request should succeed' );
done_testing();
