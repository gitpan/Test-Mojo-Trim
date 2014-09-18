requires 'perl', '5.010';

requires 'Mojolicious', '5.00';

on test => sub {
    requires 'Test::More', '0.96';
};

on build => sub {
	requires 'Test::EOL';
	requires 'Test::Pod';
};
