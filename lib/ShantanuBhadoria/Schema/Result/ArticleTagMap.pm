package ShantanuBhadoria::Schema::Result::ArticleTagMap;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

ShantanuBhadoria::Schema::Result::ArticleTagMap

=cut

__PACKAGE__->table("article_tag_maps");

=head1 ACCESSORS

=head2 article_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 tag

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "article_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "tag",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("article_id", "tag");

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

=head2 tag

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "ShantanuBhadoria::Schema::Result::Tag",
  { tag => "tag" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-04-25 10:54:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:06A7n0Vwr7Sk+/JRR24xMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
