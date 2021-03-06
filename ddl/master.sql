CREATE TABLE author (
	author_id serial primary key,
	active integer default 1,
	name varchar(255) not null,
	email varchar(255) not null,
	url varchar(255),
	password_hash char(40),
	api_key char(40),
	date_created timestamp,
	date_modified timestamp
) WITH OIDS;

CREATE INDEX author_name ON author (name);

CREATE TABLE plugin (
	plugin_id serial primary key,
	author_id integer not null,
	active integer default 1 not null,
	size_k integer default 0 not null,
	views integer default 0 not null,
	installs integer default 0 not null,
	name varchar(128) not null,
	version varchar(16) not null,
	description text not null,
	filename varchar(128),
	url varchar(255),
	date_created timestamp,
	date_modified timestamp
) WITH OIDS;

CREATE INDEX plugin_author_id ON plugin (author_id);
CREATE INDEX plugin_name ON plugin (name);

CREATE TABLE plugin_documentation (
	plugin_id integer primary key,
	format varchar(4) not null,
	documentation text
) WITH OIDS;

CREATE TABLE plugin_history (
	plugin_history_id serial primary key,
	plugin_id integer not null,
	size_k integer default 0,
	version varchar(16),
	filename varchar(128),
	date_uploaded timestamp
) WITH OIDS;

CREATE INDEX plugin_history_plugin_id ON plugin_history (plugin_id);

CREATE TABLE plugin_install (
	plugin_install_id serial primary key,
	plugin_id integer not null,
	version varchar(16),
	ip_address varchar(15) not null,
	date_created timestamp
) WITH OIDS;

CREATE INDEX plugin_install_plugin_id ON plugin_install (plugin_id);
