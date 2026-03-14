/*
  Warnings:

  - Added the required column `startingDate` to the `Goal` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Goal" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "startingDate" DATETIME NOT NULL,
    "endingDate" DATETIME NOT NULL,
    "color" TEXT NOT NULL DEFAULT '#00ff00',
    "iconRef" TEXT,
    "isArchived" BOOLEAN NOT NULL DEFAULT false,
    "amount" INTEGER NOT NULL,
    "accountId" TEXT NOT NULL,
    "walletId" TEXT,
    CONSTRAINT "Goal_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "Wallet" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Goal_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Goal" ("accountId", "amount", "color", "createdAt", "endingDate", "iconRef", "id", "isArchived", "name", "updatedAt", "walletId") SELECT "accountId", "amount", "color", "createdAt", "endingDate", "iconRef", "id", "isArchived", "name", "updatedAt", "walletId" FROM "Goal";
DROP TABLE "Goal";
ALTER TABLE "new_Goal" RENAME TO "Goal";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
