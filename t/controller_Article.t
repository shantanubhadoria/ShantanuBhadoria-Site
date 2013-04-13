use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShantanuBhadoria::Site';
use ShantanuBhadoria::Site::Controller::Article;

ok( request('/article')->is_success, 'Request should succeed' );
done_testing();
