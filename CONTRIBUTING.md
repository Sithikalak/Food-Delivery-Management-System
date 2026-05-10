# Contributing to Food Delivery Management System

## Team Members & Modules

| # | Role | Branch | Module Folders |
|---|------|--------|---------------|
| 1 | Customer Management | `feature/customer-management` | `mod_customer/` |
| 2 | Restaurant & Menu Management | `feature/restaurant-menu-management` | `mod_restaurant/` |
| 3 | Order Management | `feature/order-management` | `mod_orders/` |
| 4 | Delivery Agent Management | `feature/delivery-agent-management` | `mod_delivery/` |
| 5 | Payment & Review Management | `feature/payment-review-management` | `mod_billing/` |

## Rules

1. **Always work on YOUR branch** — never commit directly to `main`.
2. **Only edit files in YOUR module** — avoid touching other members' folders.
3. **Shared files** (`model/`, `util/`, `pom.xml`, `web.xml`, `css/`, `jsp/navbar.jsp`) require team discussion before changes.
4. **Pull from `main` daily** — run `git pull origin main` to stay in sync.
5. **Create Pull Requests** — all code goes through PR review before merging to `main`.

## Git Workflow

```bash
# Start of day
git checkout feature/your-branch
git pull origin main

# After making changes
git add .
git commit -m "feat(module): description"
git push origin feature/your-branch

# Then create a Pull Request on GitHub
```

## Commit Message Format

```
feat(customer): add login validation
fix(restaurant): fix menu delete bug
style(orders): improve cart layout
docs(delivery): update README
refactor(billing): clean up DAO queries
```
