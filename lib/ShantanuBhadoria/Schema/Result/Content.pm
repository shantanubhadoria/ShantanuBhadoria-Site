use utf8;
package ShantanuBhadoria::Schema::Result::Content;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ShantanuBhadoria::Schema::Result::Content

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

=head1 TABLE: C<contents>

=cut

__PACKAGE__->table("contents");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 parent_content_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 url_alias

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 handler

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 handler_params

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "parent_content_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "url_alias",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "handler",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "handler_params",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<parent_content_id_url_alias_UNIQUE>

=over 4

=item * L</url_alias>

=item * L</parent_content_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "parent_content_id_url_alias_UNIQUE",
  ["url_alias", "parent_content_id"],
);

=head1 RELATIONS

=head2 contents

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Content>

=cut

__PACKAGE__->has_many(
  "contents",
  "ShantanuBhadoria::Schema::Result::Content",
  { "foreign.parent_content_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent_content

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Content>

=cut

__PACKAGE__->belongs_to(
  "parent_content",
  "ShantanuBhadoria::Schema::Result::Content",
  { id => "parent_content_id" },
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
  { "foreign.content_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-19 22:41:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:A5eaLi3RKexYRVRYMpZOfQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
