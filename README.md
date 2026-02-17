# Robot Framework + Jenkins + Report Portal

**Version:** 1.1 (branch: feature/updates)

This project contains **Robot Framework** test suites, a **Jenkins pipeline** that checks out from **GitHub** and runs them, and optional **Report Portal** integration to push results into Report Portal.

---

## Project Structure

```
report_portal_system/
├── Jenkinsfile              # Pipeline: GitHub checkout → run tests → Report Portal
├── requirements.txt         # Robot Framework + robotframework-reportportal
├── resources/
│   └── keywords.robot       # Reusable keywords (math, strings, lists)
├── tests/
│   ├── test_passing.robot   # Tests that pass
│   ├── test_failing.robot   # Tests that fail (for demo)
│   └── test_mixed.robot     # Mix of pass and fail
├── .gitignore
└── results/                 # Created when tests run (report.html, log.html, output.xml)
```

---

## How the Entire Process Works

### 1. Robot Framework tests

- **Tests** are in `tests/*.robot`. Each file is a test suite; each `*** Test Case ***` block is one test.
- **Keywords** in `resources/keywords.robot` provide reusable steps (e.g. add numbers, check list length).
- Running `robot tests/` executes all suites and produces:
  - `results/output.xml` – machine-readable results
  - `results/report.html` – summary report
  - `results/log.html` – detailed execution log

**Passing tests** (`test_passing.robot`): assertions match (e.g. 10+5=15, list length 3).  
**Failing tests** (`test_failing.robot`): assertions are wrong on purpose (e.g. expect 99 instead of 15, or assert lowercase as uppercase).  
**Mixed** (`test_mixed.robot`): some pass, some fail.

### 2. Jenkins pipeline (high level)

When you run the pipeline (e.g. “Build Now” on a job that uses this repo):

1. **Checkout from GitHub** – Jenkins checks out the repository from GitHub into the workspace (`checkout scm`; the job must be configured with Git and your GitHub repo URL).
2. **Setup Python & Dependencies** – Installs packages from `requirements.txt` (Robot Framework + `robotframework-reportportal`). Uses a cache dir to speed up later runs.
3. **Run Robot Framework Tests** – Runs `robot` against `tests/`. If Report Portal parameters are set, the run uses the **Report Portal listener** so results are sent to Report Portal during execution; otherwise it runs without the listener.
4. **Post-step (always)** – The Robot Framework Jenkins plugin reads `results/` and sets the build status (pass/fail/unstable) from the test outcome and optionally publishes the HTML report. `publishHTML` (if installed) makes `report.html` viewable in Jenkins.

After the run:

- **Archive** – Contents of `results/` are archived so you can download report/log/output from the build.
- **Report Portal** – If configured, the same run has already pushed launch and test results to Report Portal (launch name includes job name and build number).

### 3. End-to-end flow

```
Code in GitHub
        ↓
Jenkins job (Pipeline from SCM → GitHub repo, Script Path: Jenkinsfile)
        ↓
Pipeline: Checkout from GitHub → Install deps → robot tests/ (with optional RP listener)
        ↓
Robot produces results/ and (if configured) sends results to Report Portal
        ↓
Jenkins: set build result, publish report, archive artifacts
        ↓
View results in Jenkins and in Report Portal
```


---

## Running Tests Locally

1. **Create a virtual environment (recommended):**
   ```bash
   python -m venv venv
   venv\Scripts\activate
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run all tests:**
   ```bash
   robot --outputdir results --loglevel INFO tests/
   ```

4. **Open the report:**
   - Open `results/report.html` in a browser.

To run only passing or only failing suites:

```bash
robot --outputdir results tests/test_passing.robot
robot --outputdir results tests/test_failing.robot
```

---

## Making this a GitHub repo

1. **Create a new repository** on GitHub (e.g. `report_portal_system`).
2. **From your project folder**, initialize Git and push (if not already done):

   ```bash
   git init
   git add .
   git commit -m "Initial commit: Robot Framework + Jenkins + Report Portal"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/report_portal_system.git
   git push -u origin main
   ```

3. The **Jenkinsfile** uses **checkout scm**, so when the Jenkins job is configured with "Pipeline script from SCM" and this GitHub repo, Jenkins will **check out from GitHub** on every run.

---

## Setting Up Jenkins

1. **Create a Pipeline job** in Jenkins (e.g. “New Item” → “Pipeline”).
2. **Pipeline definition:** choose “Pipeline script from SCM”; set SCM to your repo; set “Script Path” to `Jenkinsfile`.
3. **Python:** ensure the Jenkins agent has Python 3 and `pip` (or use a Docker image / tool that provides them).
4. **Plugins (recommended):** Robot Framework (parses output.xml), HTML Publisher (for report.html).

If the agent is **Linux**, replace the `bat` blocks in the Jenkinsfile with `sh`.

---

## Sending results to Report Portal

The pipeline can **move results to Report Portal** using the official Robot Framework listener (`robotframework-reportportal`). Results are sent during the test run.

- **Report Portal:** Have a Report Portal instance URL and a project; get your **API key** from User Profile.
- **Jenkins:** Create a **Secret text** credential with ID **`reportportal-api-key`** (your API key). When running the job, set **RP_ENDPOINT** to your Report Portal URL; leave it empty to skip Report Portal. **RP_PROJECT** is the Report Portal project name (default: `default_project`).
- When RP_ENDPOINT is set, the launch and test results are sent to Report Portal; the launch name is like `Robot_<JobName>_<BuildNumber>`.

---

## Test Case Summary

| Suite             | Purpose                         | Expected result   |
|------------------|----------------------------------|-------------------|
| test_passing.robot | All assertions correct          | All pass          |
| test_failing.robot | Wrong expectations on purpose   | All fail          |
| test_mixed.robot   | Some pass, some fail            | Mixed pass/fail   |

Use `test_passing.robot` to verify the pipeline and reports when everything should be green; use `test_failing.robot` or `test_mixed.robot` to see how Jenkins reports failures and archives artifacts.
