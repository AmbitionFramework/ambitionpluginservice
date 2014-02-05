using Ambition;
using Ambition.Testing;
public class ServicePluginTest {
	public static void add_tests() {
		Test.add_func("/service/plugin", () => {
			var c = new PluginService.Controller.Service.Plugin();
			assert( c != null );
		});
		Test.add_func("/service/plugin/versions/happy", () => {
			string plugin_list = """{"plugins":[{"name":"SCGI","version":"0.0.1"}]}""";
			var result = generic_get_request( "/service/versions?l=" + plugin_list, 200 );
			result.assert_content_type_is("application/json");
			result.assert_content_like(""""plugins":[{"name":"SCGI"""");
		});
		Test.add_func("/service/plugin/versions/no_plugin", () => {
			string plugin_list = """{"plugins":[{"name":"Zzazifr","version":"0.0.1"}]}""";
			var result = generic_get_request( "/service/versions?l=" + plugin_list, 200 );
			result.assert_content_type_is("application/json");
			result.assert_content_like(""""plugins":[]""");
		});
		Test.add_func("/service/plugin/versions/invalid/missing_query", () => {
			var result = generic_get_request( "/service/versions", 400 );
		});
	}
}
