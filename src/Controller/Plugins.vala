using Ambition;
using PluginService.View;
using Ambition.Plugin;
namespace PluginService.Controller {

	/**
	 * Plugins Controller.
	 */
	public class Plugins : Object {

		public Result list ( State state ) {
			var plugins = new Almanna.Search<PluginService.Model.DB.Plugin>()
				.order_by( "name" )
				.list();
			return new Template.Plugins.list(plugins);
		}

		public Result view ( State state ) {
			string? plugin_id = state.request.get_capture("plugin_id");
			var plugin = new Almanna.Search<PluginService.Model.DB.Plugin>()
				.eq( "plugin_id", int.parse(plugin_id) )
				.single();
			plugin.views++;
			plugin.save();
			return new Template.Plugins.view(plugin);
		}

		public Result generate( State state ) {
			string path = state.request.get_capture("file");
			var file = File.new_for_path(path);
			if ( file == null || ! file.query_exists() ) {
				return new CoreView.None();
			}

			// Create temporary directory
			string temp_name = "%s/tmp-%s".printf( Environment.get_tmp_dir(), path.substring( 0, path.index_of("-") ) );
			File temp_dir = File.new_for_path(temp_name);
			temp_dir.make_directory();
			if ( Environment.set_current_dir(temp_name) == -1 ) {
				Logger.error( "Unable to change to temp directory: " + temp_name );
				return new CoreView.None();
			}

			// Unarchive file
			string standard_output, standard_error;
			int exit_status;
			try {
				Process.spawn_command_line_sync(
					"tar xf " + file.get_path(),
					out standard_output,
					out standard_error,
					out exit_status
				);
			} catch (SpawnError se) {
				Logger.error( "Unable to run tar xf: %s".printf( se.message ) );
				return new CoreView.None();
			}

			// Parse manifest
			var manifest = PluginManifest.load_manifest(temp_name);
			if ( manifest == null ) {
				Logger.error( "No manifest" );
				return new CoreView.None();
			}

			// Call generate
			var documentation = File.new_for_path( "%s/%s".printf( temp_name, manifest.documentation ) );
			if ( documentation == null || ! documentation.query_exists() ) {
				Logger.error( "No documentation file: " + "%s/%s".printf( temp_name, manifest.documentation ) );
				documentation = null;
			}
			PluginService.Model.DB.Plugin.generate_from_source( manifest, file, documentation );

			// Clean up temporary directory
			clean_directory(temp_dir);
			temp_dir.delete();

			return new CoreView.None();
		}

	}

	public void clean_directory( File directory ) {
		FileInfo file_info;
		try {
			var enumerator = directory.enumerate_children(
				FileAttribute.STANDARD_NAME + "," + FileAttribute.STANDARD_TYPE, 0
			);

			while ( ( file_info = enumerator.next_file() ) != null ) {
				if ( file_info.get_file_type() == FileType.DIRECTORY ) {
					clean_directory( File.new_for_path( "%s/%s".printf( directory.get_path(), file_info.get_name() ) ) );
				} else {
					// stdout.printf( "Deleting %s\n", "%s/%s".printf( directory.get_path(), file_info.get_name() ) );
					File.new_for_path( "%s/%s".printf( directory.get_path(), file_info.get_name() ) ).delete();
				}
			}
		} catch (Error e) {
			Logger.error( "Error while enumerating directory '%s': %s".printf( directory.get_path(), e.message ) );
		}
	}
}
