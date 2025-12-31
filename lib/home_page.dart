import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ---------- Image picker ----------
  final ImagePicker picker = ImagePicker();
  XFile? img;

  // ---------- Counter ----------
  final List<Color> counterColors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.redAccent,
  ];
  int colorIndex = 0;
  int count = 0;
  bool circle = false;

  // ---------- Slider Images ----------
  final List<String> sliderImages = [
    "https://i.postimg.cc/SN5sXQ2r/nature1.jpg",
    "https://i.postimg.cc/3J2gWj17/nature2.jpg",
    "https://i.postimg.cc/9F7LkQdN/nature3.jpg",
    "https://i.postimg.cc/HkdbZk0Q/nature4.jpg",
    "https://i.postimg.cc/zXhP2Tk6/nature5.jpg",
    "https://i.postimg.cc/3J1N7M8B/nature6.jpg"
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);

    // ====== تمرير الصور تلقائيًا كل 2 ثانية ======
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_pageController.hasClients) return;
      _currentPage++;
      if (_currentPage >= sliderImages.length) {
        _currentPage = 0; // العودة للأولى بعد الأخيرة
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ---------- Camera ----------
  void openCameraOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('التقاط صورة'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource src) async {
    final x = await picker.pickImage(source: src, imageQuality: 85);
    if (x == null) return;
    setState(() => img = x);
  }

  // ---------- Counter Button ----------
  void increaseCounter() {
    setState(() {
      count++;
      circle = !circle;
      colorIndex = (colorIndex + 1) % counterColors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Slider App'),
        centerTitle: true,
      ),

      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "counter",
            onPressed: increaseCounter,
            backgroundColor: counterColors[colorIndex],
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: "camera",
            onPressed: openCameraOptions,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // ===== Slider Section =====
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sliderImages.length,
              onPageChanged: (index) {
                _currentPage = index;
              },
              itemBuilder: (_, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(sliderImages[index]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // ===== Counter + Image =====
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$count",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: counterColors[colorIndex],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: img == null ? counterColors[colorIndex] : null,
                    shape: circle ? BoxShape.circle : BoxShape.rectangle,
                    image: img == null
                        ? null
                        : DecorationImage(
                      image: FileImage(File(img!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
