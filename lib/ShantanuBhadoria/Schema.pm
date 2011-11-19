use utf8;
package ShantanuBhadoria::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-19 22:41:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qPov6UoBYmIK7o7dbYbBNA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
