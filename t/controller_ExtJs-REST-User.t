use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShantanuBhadoria::Site';
use ShantanuBhadoria::Site::Controller::ExtJs::REST::User;

ok( request('/extjs/rest/user')->is_success, 'Request should succeed' );
done_testing();
