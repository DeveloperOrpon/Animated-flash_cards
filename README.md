# Animated Flash Cards

A Flutter package for **animated flash cards** with book-like forward and backward page flipping. Fully customizable cards with top and bottom pages, colors, fonts, and page flip animations.

[![pub package](https://img.shields.io/pub/v/animated_flash_cards.svg)](https://pub.dev/packages/animated_flash_cards)

---

## 📦 Features

- Forward and backward page flipping animation.
- Customizable top and bottom pages.
- DecorationImage support for page flip GIFs.
- Customizable card height, colors, border radius, and margins.
- Easy to integrate into any Flutter app.

---

## 🛠 Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  animated_flash_cards:
    git:
      url: https://github.com/DeveloperOrpon/Animated-flash_cards.git
```

Then run:

```bash
flutter pub get
```

---

## 🎨 Usage

Import the package:

```dart
import 'package:animated_flash_cards/animated_flash_cards.dart';
```

Create a flash card:

```dart
FlashCard(
  topPages: [
    Container(color: Colors.red, child: Center(child: Text('Top 1'))),
    Container(color: Colors.blue, child: Center(child: Text('Top 2'))),
  ],
  bottomPages: [
    Container(color: Colors.green, child: Center(child: Text('Bottom 1'))),
    Container(color: Colors.orange, child: Center(child: Text('Bottom 2'))),
  ],
  cardHeight: 250,
  borderRadiusAll: 16,
  headerColor: Colors.amber,
  topPageColor: Colors.white,
  bottomPageColor: Colors.grey[200]!,
);
```

> **Note:** `topPages` and `bottomPages` lists **must have the same length**. Otherwise, an assertion error will be thrown.

---

## 🖼 Example Images

**FLASH CARD:**

<div>
  <img src="https://raw.githubusercontent.com/DeveloperOrpon/Animated-flash_cards/main/doc/doc2.png" width="200" alt="Top Page Flip" />
  <img src="https://raw.githubusercontent.com/DeveloperOrpon/Animated-flash_cards/main/doc/doc1.png" width="200" alt="Animation Running" />
   
</div>

---

## 🎥 Demo Video

 <img src="https://raw.githubusercontent.com/DeveloperOrpon/Animated-flash_cards/main/doc/doc3.gif" width="200" alt="Bottom Page Flip" />

Click the image to watch the demo video of the package in action.

---

## ⚙️ Customization

| Property | Description | Default |
|----------|-------------|---------|
| `cardHeight` | Height of the flash card | 200 |
| `margin` | Outer margin of the card | null |
| `topPages` | List of widgets for top pages | required |
| `bottomPages` | List of widgets for bottom pages | required |
| `headerColor` | Color of the header | `Colors.amber` |
| `topPageColor` | Background color of top pages | `Colors.amber` |
| `bottomPageColor` | Background color of bottom pages | `Colors.amber` |
| `borderRadiusAll` | Card border radius | 20 |

---

## 💻 Example Project

You can check the `example/` folder in the repository for a full working demo.

---

## 📄 License

This package is licensed under the [MIT License](LICENSE).

