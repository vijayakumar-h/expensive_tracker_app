// weather_screen.dar
import '../../../../common_exports.dart';
import '../bloc/weather_bloc.dart';
import '../data/weather_repository.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();

    return BlocProvider(
      // Inject BLoC with the Singleton Repository
      create: (context) => WeatherBloc(WeatherRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Weather Search')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Search Bar
              Builder(
                builder: (context) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            labelText: 'Enter City Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Dispatch Event when button is tapped
                          context.read<WeatherBloc>().add(
                            FetchWeatherEvent(cityController.text),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),

              // 2. Dynamic Weather Display (Rebuilds based on State)
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state.status == WeatherStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    else if (state.status == WeatherStatus.success) {
                      final weather = state.weather!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.cityName,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${weather.temperature}°C',
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            weather.condition,
                            style: const TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      );
                    }

                    else if (state.status == WeatherStatus.failure) {
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Error fetching weather',
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    }

                    // Default Initial State
                    return const Center(
                      child: Text('Enter a city name above to check the weather!'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}