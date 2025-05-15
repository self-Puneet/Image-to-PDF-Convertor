# 📸 SwiftConvert – Image to PDF Converter

SwiftConvert is a beautifully crafted **Flutter Android app** that lets users **convert images from their gallery into a single PDF document** with just a few taps. Whether you're a student scanning notes, a professional organizing receipts, or anyone who needs quick image-to-PDF functionality — SwiftConvert makes the process intuitive and seamless.

<p align="center">
  <img src="https://cdn.discordapp.com/attachments/1372643280847769690/1372667909972951160/WhatsApp_Image_2025-05-16_at_01.42.00_b2042bed.jpg?ex=68279c1c&is=68264a9c&hm=5ba6ee72ffca4b346dd636851201d0e14c4175b7a3de65334d380ad0631e9169&" alt="SwiftConvert Screenshot 1" width="300"/>
  &nbsp;&nbsp;
  <img src="https://cdn.discordapp.com/attachments/1372643280847769690/1372667241329590373/WhatsApp_Image_2025-05-16_at_01.37.19_a29d85a2.jpg?ex=68279b7d&is=682649fd&hm=7923867ed0104a3613ed1a09862595b178cc4ef916561f654d27ab90ccc65c4d&" alt="SwiftConvert Screenshot 2" width="300"/>
</p>

---

## 🚀 Features

### 📂 **Select Multiple Images**

* Browse your device's gallery and select as many images as you like.
* Selection order is preserved — your first selected image will be the first page in the PDF.

### 🔀 **Reorder Images**

* Rearrange the selected images using a drag-and-drop interface.
* Preview the final order before converting to PDF.

### ✂️ **Choose PDF Margins**

* On upload, you're prompted to select margin size:

  * **No Margin**
  * **Small Margin**
  * **Large Margin**

### 🧾 **Generate and Save PDF**

* Combines all selected images into a clean, paginated PDF.
* Saves the file to your chosen directory with a unique filename.
* Instantly opens the file for preview after saving.

### 🎨 **Modern & Minimal UI**

* Clean layout and responsive design.
* User-friendly experience optimized for all screen sizes.

---

## 📱 How It Works

1. **Tap the Upload Button:**
   Opens the gallery to select images.

2. **Select & Preview:**
   Pick multiple images — order is tracked.

3. **Reorder if Needed:**
   Use drag-and-drop to reorder before proceeding.

4. **Choose Margins:**
   Select preferred spacing around each image.

5. **Save as PDF:**
   Choose the output folder and generate the PDF.

6. **Open & View:**
   The PDF opens automatically for quick access.

---

## 🧰 Packages & Libraries Used

| Package                                                                   | Description                                |
| ------------------------------------------------------------------------- | ------------------------------------------ |
| [`image_picker`](https://pub.dev/packages/image_picker)                   | Select images from the device gallery      |
| [`pdf`](https://pub.dev/packages/pdf)                                     | Generate PDF documents from images         |
| [`path_provider`](https://pub.dev/packages/path_provider)                 | Get file system paths for saving documents |
| [`open_file`](https://pub.dev/packages/open_file)                         | Open generated PDF files directly          |
| [`permission_handler`](https://pub.dev/packages/permission_handler)       | Handle runtime permissions                 |
| [`file_picker`](https://pub.dev/packages/file_picker)                     | Let users choose folders for saving PDFs   |
| [`reorderable_grid_view`](https://pub.dev/packages/reorderable_grid_view) | Drag-and-drop image reordering UI          |
| [`intl`](https://pub.dev/packages/intl)                                   | Format dates and timestamps for filenames  |
| [`cupertino_icons`](https://pub.dev/packages/cupertino_icons)             | iOS-style icons and UI support             |

---

## 🔐 Permissions

To function properly, the app requires the following permissions:

* **Storage Access (Read & Write):**

  * Read images from gallery.
  * Save generated PDFs to user-specified directories.

* **File Management:**

  * Allows opening and viewing generated files within the app.

These permissions are requested gracefully at runtime using the `permission_handler` package.
