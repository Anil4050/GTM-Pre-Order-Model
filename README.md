<!-- # Flutter Mobile Developer – Case Assignment

##  Assignment Overview
This assignment simulates a real feature we are building for **EA Foods’ next year GTM Pre-Order Model**.

### Key Rules of the Model
- All orders are placed **in advance** (no ad-hoc sales).
- Customers, TSUs, and SRs place pre-orders for **next-day delivery**.
- Orders are **stock-driven** (cannot exceed available inventory).
- **Delivery windows & cut-offs**:
  - Customers must choose a slot.
  - Cut-off time is **6:00 PM daily**.
- Ops managers update **stock balances twice a day** (morning/evening).

The task tests **design, correctness, scalability, and testing** in Flutter.

---

## ⏱ Rules & Timeline
- **Work Solo**: No collaboration, no external infra.
- **Environment**: All work must run locally (SQLite, JSON mocks, in-memory DB, or local Flutter dev server).
- **Communication**: No clarifications once started.  
   Any assumptions must be documented in this README.

---

##  Deliverables
1. **GitHub Repo Link** (public or invited access).  
2. **README** including:
   - Setup & run instructions.
   - Clear **Design Notes** (assumptions, trade-offs, future improvements).
   - **Time spent log** (approx breakdown of hours).
3. **Code**: Clean, modular, well-structured.
4. **Tests**: Unit or integration tests.
5. **Screenshots** or a **short recording** of main flows working.

---

##  Constraints
- No external infra ( AWS,  Firebase, etc).  
- Use only **open-source libraries**.  
- Must include **basic linting/formatter setup**.  
- Must **seed at least 5–10 products** in local DB/mocks.  
- Delivery slots:  
  - Morning: **8–11 AM**  
  - Afternoon: **12–3 PM**  
  - Evening: **4–7 PM**  
- Enforce **cut-off rule**: Orders after 6PM → **+2 days delivery**.  
- Ops manager updates stock at **8 AM and 6 PM daily**.  

---

##  Evaluation Rubric (5 = Excellent, 1 = Poor)
- **Design & Architecture** – Models, state management, structure.  
- **Code Quality** – Readability, error handling, clean configs.  
- **Correctness** – Meets requirements, handles edge cases.  
- **Scalability/Performance** – Efficient queries, caching, offline readiness.  
- **Testing/Observability** – Test coverage, logs, bug prevention.  

---

## Example Scenarios to Cover
- Place an order **within stock** →  Success.  
- Place an order **exceeding stock** →  Rejected.  
- Place an order **after cut-off** → Scheduled **+2 days later**.  
- Cancel an order → Stock restored.  
- Ops manager updates stock → Reflected in availability.  

---

##  Setup & Run Instructions
```bash
# Clone the repository
git clone https://github.com/<your-username>/pre_order_mobile_app.git
cd pre_order_mobile_app

# Get dependencies
flutter pub get

# Run the app
flutter run -->


Flutter Mobile Developer – Case Assignment
Assignment Overview

This assignment simulates a real feature we are building for EA Foods’ next year GTM Pre-Order Model.

Key Rules of the Model

All orders are placed in advance (no ad-hoc sales).

Customers, TSUs, and SRs place pre-orders for next-day delivery.

Orders are stock-driven (cannot exceed available inventory).

Delivery windows & cut-offs:

Customers must choose a slot.

Cut-off time is 6:00 PM daily.

Ops managers update stock balances twice a day (morning/evening).

The task tests design, correctness, scalability, and testing in Flutter.

⏱ Rules & Timeline

Work Solo: No collaboration, no external infra.

Environment: All work must run locally (SQLite, JSON mocks, in-memory DB, or local Flutter dev server).

Communication: No clarifications once started.
Any assumptions must be documented in this README.

Deliverables

GitHub Repo Link (public or invited access).

README including:

Setup & run instructions.

Clear Design Notes (assumptions, trade-offs, future improvements).

Time spent log (approx breakdown of hours).

Code: Clean, modular, well-structured.

Tests: Unit or integration tests.

Screenshots or a short recording of main flows working.

Constraints

No external infra ( AWS, Firebase, etc).

Use only open-source libraries.

Must include basic linting/formatter setup.

Must seed at least 5–10 products in local DB/mocks.

Delivery slots:

Morning: 8–11 AM

Afternoon: 12–3 PM

Evening: 4–7 PM

Enforce cut-off rule: Orders after 6PM → +2 days delivery.

Ops manager updates stock at 8 AM and 6 PM daily.

Evaluation Rubric (5 = Excellent, 1 = Poor)

Design & Architecture – Models, state management, structure.

Code Quality – Readability, error handling, clean configs.

Correctness – Meets requirements, handles edge cases.

Scalability/Performance – Efficient queries, caching, offline readiness.

Testing/Observability – Test coverage, logs, bug prevention.

Example Scenarios to Cover

Place an order within stock → Success.

Place an order exceeding stock → Rejected.

Place an order after cut-off → Scheduled +2 days later.

Cancel an order → Stock restored.

Ops manager updates stock → Reflected in availability.

Setup & Run Instructions
# Clone the repository
git clone https://github.com/<your-username>/pre_order_mobile_app.git
cd pre_order_mobile_app

# Get dependencies
flutter pub get

# Generate Hive adapters (for models)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run


# Project Structure
lib/
 ┣ core/          # constants, utils
 ┣ data/          # local DB, models, repositories
 ┣ domain/        # entities & use cases
 ┣ presentation/  # screens (Stock, Pre-Order, My Orders), controllers
 ┣ main.dart


# Seeded Products

| ID  | Name        | Unit  | Price (₹) | Stock |
| --- | ----------- | ----- | --------- | ----- |
| P01 | Tomato      | Kg    | 30        | 50    |
| P02 | Potato      | Kg    | 25        | 60    |
| P03 | Onion       | Kg    | 28        | 40    |
| P04 | Cabbage     | Pc    | 20        | 30    |
| P05 | Cauliflower | Pc    | 25        | 25    |
| P06 | Spinach     | Bunch | 15        | 20    |


# Design Notes
Assumptions

Only Ops Manager updates stock (8 AM, 6 PM).

Orders are validated only against local DB stock.

Offline-first: Orders are queued locally and synced later.

Trade-offs

Used Hive for simplicity & offline support (instead of SQLite).

Limited UI polish to focus on correctness.

Future Improvements

API integration for real sync.

Authentication for multiple roles (Customer, TSU, SR, Ops).

Retry mechanism for offline sync queue.

Improved error handling & observability.

# Time Spent Log
  | Task                                | Hours  |
| ----------------------------------- | ------ |
| Project setup + Hive integration    | 2.5    |
| Models, entities, repositories      | 2.0    |
| Stock update flow (Ops Manager)     | 2.0    |
| Pre-order form + cut-off rule       | 2.5    |
| My Orders screen + cancel + restore | 2.0    |
| Offline queue (Hive Box)            | 2.0    |
| Testing & debugging                 | 1.5    |
| README + docs                       | 1.0    |
| **Total**                           | \~15.5 |



# Testing

 Place order within stock (success).

 Place order exceeding stock (rejected).

 Place order after cut-off (scheduled +2 days).

 Cancel order (stock restored).

 Ops updates stock (availability refreshed).