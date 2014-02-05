using Ambition;
using Ambition.Testing;
public class ServiceSearchTest {
	public static void add_tests() {
		Test.add_func("/service/search", () => {
			var c = new PluginService.Controller.Service.Search();
			assert( c != null );
		});
		Test.add_func("/service/search/happy", () => {
			var result = generic_get_request( "/service/search?q=a", 200 );
			result.assert_content_type_is("application/json");
			result.assert_content_like(""""plugins":[{"name":""");
		});
		Test.add_func("/service/search/invalid/missing_query", () => {
			var result = generic_get_request( "/service/search", 400 );
		});
	}
}
