package ShantanuBhadoria::Schema::Result::Permission;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

ShantanuBhadoria::Schema::Result::Permission

=cut

__PACKAGE__->table("permissions");

=head1 ACCESSORS

=head2 article_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 permission_type_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 is_permitted

  data_type: 'tinyint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "article_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "role_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "permission_type_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "is_permitted",
  { data_type => "tinyint", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("article_id", "role_id");

=head1 RELATIONS

=head2 article

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Article>

=cut

__PACKAGE__->belongs_to(
  "article",
  "ShantanuBhadoria::Schema::Result::Article",
  { id => "article_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 permission_type

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::PermissionType>

=cut

__PACKAGE__->belongs_to(
  "permission_type",
  "ShantanuBhadoria::Schema::Result::PermissionType",
  { id => "permission_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 role

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "ShantanuBhadoria::Schema::Result::Role",
  { id => "role_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-13 13:06:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EIKWwb0Yopjrtt0pn53Eug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
