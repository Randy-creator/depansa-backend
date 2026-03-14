-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "__role__" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "__user_role__" (
    "accountId" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,

    PRIMARY KEY ("accountId", "roleId"),
    CONSTRAINT "__user_role___accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "__user_role___roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "__role__" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "File" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "path" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_username_key" ON "Account"("username");

-- CreateIndex
CREATE UNIQUE INDEX "__role___name_key" ON "__role__"("name");

-- CreateIndex
CREATE UNIQUE INDEX "File_path_key" ON "File"("path");
