using Almanna;
using Ambition.Plugin;
using Gee;
namespace PluginService.Model.DB {
	/**
	 * Almanna Entity for table "plugin".
	 * Generated by generate-schema.pl.
	 */
	public class Plugin : Almanna.Entity {
		public override string entity_name { owned get { return "plugin"; } }
		public int plugin_id { get; set; }
		public int author_id { get; set; }
		public int active { get; set; }
		public int size_k { get; set; }
		public int views { get; set; }
		public int installs { get; set; }
		public string name { get; set; }
		public string version { get; set; }
		public string description { get; set; }
		public string filename { get; set; }
		public string url { get; set; }
		public DateTime date_created { get; set; }
		public DateTime date_modified { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "plugin_id", "integer" ) );
			columns["plugin_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "author_id", "integer" ) );
			columns["author_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "active", "integer" ) );
			columns["active"].size = 4;
			columns["active"].is_nullable = true;
			
			add_column( new Column<int>.with_name_type( "size_k", "integer" ) );
			columns["size_k"].size = 4;
			columns["size_k"].is_nullable = true;
			
			add_column( new Column<int>.with_name_type( "views", "integer" ) );
			columns["views"].size = 4;
			
			add_column( new Column<int>.with_name_type( "installs", "integer" ) );
			columns["installs"].size = 4;
			
			add_column( new Column<string>.with_name_type( "name", "character varying" ) );
			columns["name"].size = 128;
			
			add_column( new Column<string>.with_name_type( "version", "character varying" ) );
			columns["version"].size = 16;
			
			add_column( new Column<string>.with_name_type( "description", "text" ) );
			
			add_column( new Column<string>.with_name_type( "filename", "character varying" ) );
			columns["filename"].size = 128;
			columns["filename"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "url", "character varying" ) );
			columns["url"].size = 255;
			columns["url"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_created", "timestamp without time zone" ) );
			columns["date_created"].size = 8;
			columns["date_created"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_modified", "timestamp without time zone" ) );
			columns["date_modified"].size = 8;
			columns["date_modified"].is_nullable = true;
			
			try {
				set_primary_key("plugin_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}

		public static ArrayList<Plugin> do_search( string query ) {
			var result_search = new Search<Plugin>()
				.ilike( "name", "%" + query + "%" )
				.ilike( "description", "%" + query + "%" )
				.order_by( "( CASE WHEN name LIKE '%" + query + "%' THEN 0 WHEN description LIKE '%" + query + "%' THEN 1 END )" );
			return result_search.list();
		}

		public static Plugin generate_from_source( PluginManifest manifest, File archive_file, File? documentation ) {
			var info = archive_file.query_info( FileAttribute.STANDARD_SIZE, FileQueryInfoFlags.NONE );
			var plugin = new Plugin();
			plugin.author_id = Author.get_by_author_string( manifest.author ).author_id;
			plugin.size_k = (int) info.get_size() / 1024;
			plugin.name = manifest.name;
			plugin.version = manifest.version;
			plugin.description = manifest.description;
			plugin.filename = archive_file.get_basename();
			plugin.url = manifest.url;
			plugin.date_created = new DateTime.now_utc();
			plugin.date_modified = new DateTime.now_utc();
			plugin.save();

			if ( documentation != null ) {
				var extension = documentation.get_basename().substring( documentation.get_basename().last_index_of(".") + 1 );
				var plugin_documentation = new PluginDocumentation();
				plugin_documentation.plugin_id = plugin.plugin_id;
				plugin_documentation.format = "txt";
				if ( extension == "md" || extension == "html" ) {
					plugin_documentation.format = extension;
				}
				uint8[] contents;
				string etag;
				documentation.load_contents( null, out contents, out etag );
				plugin_documentation.documentation = (string) contents;
				plugin_documentation.save();
			}

			PluginHistory.create_from_plugin(plugin);

			return plugin;
		}

		public string? author() {
			var author = new Search<Author>()
				.eq( "author_id", this.author_id )
				.single();
			if ( author != null ) {
				return "%s &lt;%s&gt;".printf( author.name, author.sanitized_email() );
			}
			return "";
		}

		public string? render_documentation() {
			var doc = new Search<PluginDocumentation>()
				.eq( "plugin_id", this.plugin_id )
				.single();
			if ( doc != null ) {
				switch ( doc.format ) {
					case "txt":
						return "<code>%s</code>".printf( doc.documentation );
					case "html":
						return doc.documentation;
					case "md":
						return PluginService.Model.PSMarkdown.process( doc.documentation );
				}
			}
			return "No documentation available.";
		}
	}
}

