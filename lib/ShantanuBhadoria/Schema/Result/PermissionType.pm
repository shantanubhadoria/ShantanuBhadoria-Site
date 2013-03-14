package ShantanuBhadoria::Schema::Result::PermissionType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

ShantanuBhadoria::Schema::Result::PermissionType

=cut

__PACKAGE__->table("permission_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("name_UNIQUE", ["name"]);

=head1 RELATIONS

=head2 permissions

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Permission>

=cut

__PACKAGE__->has_many(
  "permissions",
  "ShantanuBhadoria::Schema::Result::Permission",
  { "foreign.permission_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-13 13:06:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0eEoUdUVKsN//VZkE89eZA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
