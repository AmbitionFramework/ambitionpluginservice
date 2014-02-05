/**
 * Test cases should be added to this method.
 */
void main ( string[] args ) {
	Test.init( ref args );

	ServiceSearchTest.add_tests();
	ServicePluginTest.add_tests();

	Test.run();
}

public static Ambition.Testing.TestResponse generic_get_request( string url, int expected_status ) {
	var request = Ambition.Testing.Helper.get_mock_request( Ambition.HttpMethod.GET, url );
	request.headers["HTTP_ACCEPT"] = "application/json";
	var result = Ambition.Testing.Helper.mock_dispatch_with_request( new PluginService.Application(), request );
	result.assert_status_is(expected_status);
	return result;
}
