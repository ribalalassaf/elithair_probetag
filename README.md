# 🏥 Medical History Feature – Elithair Probation Task

This Flutter feature implements the medical history intake module as part of the Elithair app. The solution follows a clean architectural pattern and uses BLoC for state management instead of Riverpod.

Follow these steps to set up the project:

```bash
# Get all dependencies
flutter pub get

# Run code generation (e.g., for freezed, json_serializable, etc.)
flutter pub run build_runner build --delete-conflicting-outputs


## ✅ Features Implemented

### 📋 1. Viewing Old Records
- Displays a list of **combined local and remote records**.
- **Limitation**: Full synchronization is limited because remote records lack a unique ID field.
- As a result, comparing records (e.g., for update/delete) using `==` is not feasible.

### 📝 2. Submitting a New Record
- Users can fill out a **validated form** with medical history details.
- On **successful submission** to the mock API:
  - A **success toast** is shown.
  - The record is added to the **local Hive database**.

### 🗑️ 3. Deleting a Record
- **Not implemented** due to not having an id for each record.
- Without a stable identifier, record equality and deletion logic cannot be safely handled.

---

## ⚙️ Technical Overview

| Area             | Implementation                |
|------------------|-------------------------------|
| State Management | **Bloc** (instead of Riverpod)|

