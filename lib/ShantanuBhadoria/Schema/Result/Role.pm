use utf8;
package ShantanuBhadoria::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ShantanuBhadoria::Schema::Result::Role

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<roles>

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 role

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 parent_role_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "role",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "parent_role_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<role_UNIQUE>

=over 4

=item * L</role>

=back

=cut

__PACKAGE__->add_unique_constraint("role_UNIQUE", ["role"]);

=head1 RELATIONS

=head2 parent_role

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "parent_role",
  "ShantanuBhadoria::Schema::Result::Role",
  { id => "parent_role_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 permissions

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Permission>

=cut

__PACKAGE__->has_many(
  "permissions",
  "ShantanuBhadoria::Schema::Result::Permission",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Role>

=cut

__PACKAGE__->has_many(
  "roles",
  "ShantanuBhadoria::Schema::Result::Role",
  { "foreign.parent_role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_role_maps

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::UserRoleMap>

=cut

__PACKAGE__->has_many(
  "user_role_maps",
  "ShantanuBhadoria::Schema::Result::UserRoleMap",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-19 22:41:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:z7qJ2/ar2oV98JOIF7FrfA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
