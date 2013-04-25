package ShantanuBhadoria::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

ShantanuBhadoria::Schema::Result::Tag

=cut

__PACKAGE__->table("tags");

=head1 ACCESSORS

=head2 tag

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 parent_tag

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "tag",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "parent_tag",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("tag");

=head1 RELATIONS

=head2 article_tag_maps

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::ArticleTagMap>

=cut

__PACKAGE__->has_many(
  "article_tag_maps",
  "ShantanuBhadoria::Schema::Result::ArticleTagMap",
  { "foreign.tag" => "self.tag" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent_tag

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "parent_tag",
  "ShantanuBhadoria::Schema::Result::Tag",
  { tag => "parent_tag" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 tags

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Tag>

=cut

__PACKAGE__->has_many(
  "tags",
  "ShantanuBhadoria::Schema::Result::Tag",
  { "foreign.parent_tag" => "self.tag" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-04-25 10:54:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/IFAF+Ti0Y66h1gLo3lcdQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
