using Almanna;

namespace PluginService.Model.DB.Entity {
	
	/**
	 * Almanna Entity for table "plugin".
	 * Generated by almanna-generate.
	 */
	public class Plugin : Almanna.Entity {
		public override string entity_name { owned get { return "plugin"; } }
		public int plugin_id { get; set; }
		public int author_id { get; set; }
		public int active { get; set; }
		public int size_k { get; set; }
		public int views { get; set; }
		public int installs { get; set; }
		public int latest { get; set; }
		public string name { get; set; }
		public string version { get; set; }
		public string description { get; set; }
		public string min_version { get; set; }
		public string max_version { get; set; }
		public string filename { get; set; }
		public string url { get; set; }
		public DateTime date_created { get; set; }
		public DateTime date_modified { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "plugin_id", "int4" ) );
			columns["plugin_id"].size = 4;
			columns["plugin_id"].is_sequenced = true;
			
			add_column( new Column<int>.with_name_type( "author_id", "int4" ) );
			columns["author_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "active", "int4" ) );
			columns["active"].size = 4;
			
			add_column( new Column<int>.with_name_type( "size_k", "int4" ) );
			columns["size_k"].size = 4;
			
			add_column( new Column<int>.with_name_type( "views", "int4" ) );
			columns["views"].size = 4;
			
			add_column( new Column<int>.with_name_type( "installs", "int4" ) );
			columns["installs"].size = 4;
			
			add_column( new Column<int>.with_name_type( "latest", "int4" ) );
			columns["latest"].size = 4;
			
			add_column( new Column<string>.with_name_type( "name", "varchar" ) );
			
			add_column( new Column<string>.with_name_type( "version", "varchar" ) );
			
			add_column( new Column<string>.with_name_type( "description", "text" ) );
			
			add_column( new Column<string>.with_name_type( "min_version", "varchar" ) );
			columns["min_version"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "max_version", "varchar" ) );
			columns["max_version"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "filename", "varchar" ) );
			columns["filename"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "url", "varchar" ) );
			columns["url"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_created", "timestamp" ) );
			columns["date_created"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_modified", "timestamp" ) );
			columns["date_modified"].is_nullable = true;
			
			try {
				set_primary_key("plugin_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}
	}
}
