# 📤 How to Upload WordGuess to GitHub

This guide will walk you through uploading your WordGuess app to GitHub step-by-step. Perfect for beginners! 🚀

## ✅ What's Already Done

I've already prepared your project for GitHub:
- ✅ Created `.gitignore` file (tells Git which files to ignore)
- ✅ Initialized Git repository
- ✅ Created initial commit with all your code
- ✅ Updated README.md for GitHub

## 📋 Step-by-Step Instructions

### Step 1: Create a GitHub Account (if you don't have one)

1. Go to [github.com](https://github.com)
2. Click "Sign up" in the top right
3. Follow the registration process
4. Verify your email address

### Step 2: Create a New Repository on GitHub

1. **Log in to GitHub**
2. **Click the "+" icon** in the top right corner
3. **Select "New repository"**

4. **Fill in the repository details**:
   - **Repository name**: `WordGuess` (or any name you prefer)
   - **Description**: "5-letter word guessing iOS game with progressive cat reveal 🐱"
   - **Visibility**: 
     - Choose **Public** if you want anyone to see your code
     - Choose **Private** if you want only you (and collaborators) to see it
   - ❌ **DO NOT** check "Add a README file" (we already have one!)
   - ❌ **DO NOT** add .gitignore (we already have one!)
   - ❌ **DO NOT** choose a license yet

5. **Click "Create repository"**

### Step 3: Connect Your Local Project to GitHub

After creating the repository, GitHub will show you a page with instructions. Follow these steps:

1. **Copy your repository URL**. It will look like:
   ```
   https://github.com/YOUR_USERNAME/WordGuess.git
   ```

2. **Open Terminal** (you can use the one in Cursor or the macOS Terminal app)

3. **Navigate to your project** (if not already there):
   ```bash
   cd /Users/tina/Desktop/Cursor/WordGuess
   ```

4. **Add the remote repository** (replace YOUR_USERNAME with your actual GitHub username):
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/WordGuess.git
   ```

5. **Verify the remote was added**:
   ```bash
   git remote -v
   ```
   You should see two lines showing your repository URL.

### Step 4: Push Your Code to GitHub

1. **Push your code**:
   ```bash
   git push -u origin main
   ```

2. **Enter your GitHub credentials** when prompted:
   - **Username**: Your GitHub username
   - **Password**: 
     - ⚠️ **Note**: GitHub no longer accepts account passwords here!
     - You need to use a **Personal Access Token** instead

### Step 5: Create a Personal Access Token (if needed)

If you get an authentication error when pushing, you need to create a Personal Access Token:

1. **Go to GitHub Settings**:
   - Click your profile picture (top right)
   - Click "Settings"

2. **Navigate to Developer Settings**:
   - Scroll down in the left sidebar
   - Click "Developer settings"

3. **Create a Token**:
   - Click "Personal access tokens" → "Tokens (classic)"
   - Click "Generate new token" → "Generate new token (classic)"
   - Give it a note like "WordGuess Upload"
   - Set expiration (recommend 90 days or no expiration for personal projects)
   - Check the **"repo"** scope (this gives full control of private repositories)
   - Scroll down and click "Generate token"

4. **Copy the token** (you won't be able to see it again!)

5. **Use the token as your password** when pushing:
   ```bash
   git push -u origin main
   ```
   - Username: YOUR_USERNAME
   - Password: PASTE_YOUR_TOKEN_HERE

### Step 6: Verify Your Upload

1. **Go to your repository** on GitHub:
   ```
   https://github.com/YOUR_USERNAME/WordGuess
   ```

2. **You should see**:
   - All your project files
   - Your README.md displayed nicely with formatting
   - Green indicators showing your files were added

🎉 **Congratulations! Your WordGuess app is now on GitHub!**

## 🔄 Making Changes Later

When you make changes to your code and want to upload them to GitHub:

1. **Stage your changes**:
   ```bash
   git add .
   ```

2. **Commit with a message** describing what you changed:
   ```bash
   git commit -m "Your descriptive message here"
   ```
   Example:
   ```bash
   git commit -m "Fixed scoring bug and improved cat animation"
   ```

3. **Push to GitHub**:
   ```bash
   git push
   ```

## 📝 Updating the README

After uploading, update the README.md on GitHub to replace placeholders:

1. Go to your repository on GitHub
2. Click on `README.md`
3. Click the pencil icon (Edit this file)
4. Replace `YOUR_USERNAME` with your actual GitHub username in these lines:
   - Line 28: `git clone https://github.com/YOUR_USERNAME/WordGuess.git`
   - Line 173: `[issues page](https://github.com/YOUR_USERNAME/WordGuess/issues)`
5. Scroll down and click "Commit changes"

## 🔗 Adding Topics (Optional but Recommended)

Make your repository more discoverable:

1. Go to your repository on GitHub
2. Click the ⚙️ (gear icon) next to "About" on the right
3. Add topics like:
   - `ios`
   - `swift`
   - `swiftui`
   - `game`
   - `word-game`
   - `wordle`
   - `amplitude`
   - `mobile-app`
4. Click "Save changes"

## 📄 Adding a License (Optional)

1. In your repository, click "Add file" → "Create new file"
2. Name it `LICENSE`
3. Click "Choose a license template"
4. Select "MIT License" (a popular, permissive license)
5. Fill in your name
6. Click "Review and submit"
7. Click "Commit changes"

## 🎨 Adding Screenshots (Optional)

Make your README more appealing:

1. Take screenshots of your app running
2. Go to an "Issue" in your GitHub repository
3. Drag and drop the screenshots into the issue text box
4. Copy the generated markdown image URLs
5. Edit your README.md and add the images:
   ```markdown
   ## Screenshots
   
   ![Game Screen](YOUR_IMAGE_URL)
   ![Winner Screen](YOUR_IMAGE_URL)
   ```

## ❓ Troubleshooting

### "fatal: remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/WordGuess.git
```

### "Permission denied"
- Make sure you're using a Personal Access Token, not your password
- Check that your token has the "repo" scope

### "failed to push some refs"
```bash
git pull origin main --rebase
git push origin main
```

### Files are too large
- GitHub has a 100MB file size limit
- The `.gitignore` file should prevent large build files from being uploaded
- If you see warnings, make sure you didn't accidentally add build artifacts

## 🆘 Need Help?

- **GitHub Docs**: [docs.github.com](https://docs.github.com)
- **Git Tutorial**: [git-scm.com/docs/gittutorial](https://git-scm.com/docs/gittutorial)
- **GitHub Help**: [support.github.com](https://support.github.com)

---

**Happy coding! 🚀🐱**

