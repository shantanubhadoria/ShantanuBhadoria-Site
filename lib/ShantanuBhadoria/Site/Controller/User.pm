package ShantanuBhadoria::Site::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

ShantanuBhadoria::Site::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('user') :CaptureArgs(0) {
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ShantanuBhadoria::Site::Controller::User in User.');
}

=head2 add 

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
            template     => 'user/add.tt',
            section_name => 'User Registration',
        );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;

    if ( $form->submitted_and_valid ) {
        my $user = $c->model('DBIC::User')->new_result({});
        $form->model->update($user);
        $c->response->redirect($c->uri_for($self->action_for('login'),
                {mid => $c->set_status_msg("Registration Successful")}));
        $c->detach;
    } else {
    }
}

sub roles :Chained('base') :PathPart('roles') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
            template     => 'user/roles.tt',
            section_name => 'User Roles',
        );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $c->check_user_roles('admin') ) {
        if ( $form->submitted_and_valid ) {
            my $user_role_map = $c->model('DBIC::UserRoleMap')->new_result({});
            $form->model->update($user_role_map);
            $c->response->redirect($c->uri_for($self->action_for('roles'),
                    {mid => $c->set_status_msg("Role Added")}));
            $c->detach;
        } else {
        }
    } else {
        $c->response->redirect($c->uri_for($self->action_for('login'),
                {mid => $c->set_status_msg("Insufficient Privileges")}));
    }
}

=head2 login

=cut

sub login :Chained('base') :PathPart('login') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
            template     => 'user/login.tt',
            section_name => 'Login',
        );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $form->submitted_and_valid ) {
        if (
            $c->authenticate({
                    username => $c->req->params->{'username'},
                    password => $c->req->params->{'password'}
                }) 
        )
        {
            $c->log->debug("*** Authenticated User ***");
            ## $c->user now contains the information related to the user
            $c->response->redirect($c->uri_for($c->controller('Root'),
                {mid => $c->set_status_msg("Login Successful")}));
        } else {
            ### authentication failed.
            $c->log->debug("*** Authentication Failed ***");
            $c->response->redirect($c->uri_for($self->action_for('login'),
                {mid => $c->set_status_msg("Login Failed")}));
        }
        $c->detach;
    } else {
    }
}

=head2 logout

=cut

sub logout :Chained('base') :PathPart('logout') :Args(0) {
    my ( $self, $c ) = @_;
    $c->logout();
    $c->response->redirect($c->uri_for($self->action_for('login'),
            {mid => $c->set_status_msg("Logged Out")}));
}


=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
