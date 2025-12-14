import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  final List<String> imageUrls = const [
    'https://www.shutterstock.com/shutterstock/photos/1929328700/display_1500/stock-photo-bunch-of-bananas-ready-for-sale-at-the-market-1929328700.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2677223589/display_1500/stock-photo-orange-knitted-sweater-with-geometric-beige-pattern-and-high-ribbed-collar-womens-warm-winter-2677223589.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2587859633/display_1500/stock-photo-close-up-of-colorful-candy-gum-drops-2587859633.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2610703851/display_1500/stock-photo-bangkok-thailand-apr-iphone-series-comparing-and-testing-the-new-iphone-as-well-as-2610703851.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2583657853/display_1500/stock-photo-dnipro-ukraine-dec-a-white-sony-playstation-controller-and-playstation-console-on-a-2583657853.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2656907887/display_1500/stock-photo-dog-toys-isolated-on-white-background-2656907887.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Галерея изображений'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Кешированные изображения из сети:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Эти изображения загружаются из интернета и кешируются локально. '
                  'При повторном открытии они будут загружаться из кеша.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            progressIndicatorBuilder: (context, url, progress) =>
                                Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Изображение ${index + 1}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}