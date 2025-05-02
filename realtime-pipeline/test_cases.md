
---

## 📄 3. `test_cases.md`

```markdown
# Test Cases

| Test Case ID | Description | Expected Output | Actual Result | Status |
|--------------|-------------|-----------------|----------------|--------|
| TC001 | CSV file is created by generator | A new file appears in `/generated_data` every ~10s | ✅ File appears | Pass |
| TC002 | Spark detects new CSV files | Spark logs show batch being processed | ✅ Streaming job detects files | Pass |
| TC003 | Data is inserted into PostgreSQL | `SELECT COUNT(*) FROM user_events` returns > 0 | ✅ Rows found | Pass |
| TC004 | Data fields are correctly transformed | Timestamps are parsed into `event_timestamp` | ✅ Timestamp format is correct | Pass |
| TC005 | System handles continuous data | No crashes during long runs | ✅ System runs without error | Pass |
