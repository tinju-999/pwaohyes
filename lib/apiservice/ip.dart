enum ApiEnvironment {
  dev("https://staging.ohyesworld.com/"),
  prod("https://live.ohyesworld.com/");

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}

const apiEnvironment = ApiEnvironment.dev;
