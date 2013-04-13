package ShantanuBhadoria::Schema::Result::Article;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

ShantanuBhadoria::Schema::Result::Article

=cut

__PACKAGE__->table("articles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 parent_article_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 url_alias

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 content

  data_type: 'text'
  is_nullable: 0

=head2 author_id

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
  "parent_article_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "url_alias",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "content",
  { data_type => "text", is_nullable => 0 },
  "author_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(
  "parent_article_id_url_alias_UNIQUE",
  ["url_alias", "parent_article_id"],
);

=head1 RELATIONS

=head2 parent_article

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::Article>

=cut

__PACKAGE__->belongs_to(
  "parent_article",
  "ShantanuBhadoria::Schema::Result::Article",
  { id => "parent_article_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 articles

Type: has_many

Related object: L<ShantanuBhadoria::Schema::Result::Article>

=cut

__PACKAGE__->has_many(
  "articles",
  "ShantanuBhadoria::Schema::Result::Article",
  { "foreign.parent_article_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 author

Type: belongs_to

Related object: L<ShantanuBhadoria::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "author",
  "ShantanuBhadoria::Schema::Result::User",
  { id => "author_id" },
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
  { "foreign.article_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-18 11:01:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uwGB9wI4nObq6TN1NIh2WA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
