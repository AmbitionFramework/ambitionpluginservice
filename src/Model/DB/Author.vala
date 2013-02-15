using Almanna;
namespace PluginService.Model.DB {
	/**
	 * Almanna Entity for table "author".
	 * Generated by generate-schema.pl.
	 */
	public class Author : Almanna.Entity {
		public override string entity_name { owned get { return "author"; } }
		public int author_id { get; set; }
		public int active { get; set; }
		public string name { get; set; }
		public string email { get; set; }
		public string url { get; set; }
		public string password_hash { get; set; }
		public string api_key { get; set; }
		public DateTime date_created { get; set; }
		public DateTime date_modified { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "author_id", "integer" ) );
			columns["author_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "active", "integer" ) );
			columns["active"].size = 4;
			columns["active"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "name", "character varying" ) );
			columns["name"].size = 255;
			
			add_column( new Column<string>.with_name_type( "email", "character varying" ) );
			columns["email"].size = 255;
			
			add_column( new Column<string>.with_name_type( "url", "character varying" ) );
			columns["url"].size = 255;
			columns["url"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "password_hash", "character" ) );
			columns["password_hash"].size = 40;
			columns["password_hash"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "api_key", "character" ) );
			columns["api_key"].size = 40;
			columns["api_key"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_created", "timestamp without time zone" ) );
			columns["date_created"].size = 8;
			columns["date_created"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_modified", "timestamp without time zone" ) );
			columns["date_modified"].size = 8;
			columns["date_modified"].is_nullable = true;
			
			try {
				set_primary_key("author_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}

		public string sanitized_email() {
			return this.email.replace( "@", " -a-t- ").replace( ".", " -dot- " );
		}
	}
}

