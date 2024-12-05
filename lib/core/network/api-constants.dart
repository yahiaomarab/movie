class ApiConstance {

  static const String baseUrl = 'https://api.themoviedb.org/3/';


  static const String apiKey = '52384181cde0bdd6f21ec4369dfc9374';


  static const String trendingDayUrl = 'trending/all/day';
  static const String trendingWeekUrl = 'trending/all/week';
  static const String popularMoviesUrl = 'movie/popular';
  static const String nowPlayingMoviesUrl = 'movie/now_playing';
  static const String topRatedMoviesUrl = 'movie/top_rated';
  static const String upComingMoviesUrl = 'movie/upcoming';
  static String moviesUrl = 'movie';
  static String similarMovie='/similar';
  
  static const String popularTvSeriesUrl = 'tv/popular';
  static const String topRatedTvSeriesUrl = 'tv/top_rated';
  static const String onAirTvSeriesUrl = 'tv/airing_today';
  static String tv = 'tv/';

  static const String multisearchUrl = 'search/multi';

  static int? movieId;
  static int popularNumPage = 1;
  static int upcomingNumPage = 1;
}